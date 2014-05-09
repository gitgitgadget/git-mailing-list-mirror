From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 04/25] contrib: remove 'buildsystems'
Date: Fri, 09 May 2014 04:35:00 -0500
Message-ID: <536ca144161a_39ea14ab31097@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <1399597116-1851-5-git-send-email-felipe.contreras@gmail.com>
 <CABPQNSYZ4eWS_9_omZGK5wCD7ap_siEkC10e4ayT8Jp9w1bOSw@mail.gmail.com>
 <536c8e63448c2_25d198d30c55@nysa.notmuch>
 <CABPQNSYgfUdtfT0sYCwGsWQgW3QFOZvSZSyG76dmF6+ZSMaByw@mail.gmail.com>
 <536c966cf0e9c_2bf0e952f079@nysa.notmuch>
 <8761lfnwel.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: David Kastrup <dak@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 11:35:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WihCw-0004ei-HE
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 11:35:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451AbaEIJfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 05:35:06 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:35592 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790AbaEIJfE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 05:35:04 -0400
Received: by mail-yh0-f44.google.com with SMTP id b6so3489081yha.31
        for <git@vger.kernel.org>; Fri, 09 May 2014 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=qZ25lqp/zPIFWTW+phI7RzfcRE2HHdaY0jEN2Xr0Ric=;
        b=B8zToPVl2bAMfsPi57pEVxpE09H0XybL8S5+BuJUW2bRlHH0UCOu20S7GqBN8s0an/
         1kYpf69tdi3aP1rZ2UfDzP7RgX0p5p+2vY1UkT+i3jKZ1ZfqANa0CSZDiTZuHGsgf6OW
         2nLu2Do8QCmCENszDkRdWXsBp0nqvSNYgR9Kb0EJ0ofj9y3kjG/ILkZcOkZof7O9zCrA
         ImJ/8HDhI5NxrgAus+MVSyyS4zPOFbqsayBNlOUUc6ufNbJJQ61PVIUlhkzXdjrSbdlX
         bqzhDeNRXV7/qdV2ULFb/Shk/4xnTsOOWiF2v1cULZq0V+Ss4A3ICFbgj5mpRvfxvz5V
         d7LA==
X-Received: by 10.236.93.194 with SMTP id l42mr13438928yhf.17.1399628104267;
        Fri, 09 May 2014 02:35:04 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id a104sm5418312yhq.5.2014.05.09.02.35.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 02:35:02 -0700 (PDT)
In-Reply-To: <8761lfnwel.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248543>

David Kastrup wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> Besides, you say "No activity since 2010" - this is not the case,
> >> bc380fc is from November 2013.
> >
> > You think changing the execution bit of a file is considered "activity"?
> 
> For an indication of "this software has actual users", it definitely
> would count as such, yes.  Why would someone change the executable bit
> if it did not impact his usage of the software?

Because that somebody spotted this while changing the executable bit of
other scripts, which is precisely what happened (or at least seems so
from the history).

> The idea of removing software from distribution is to get rid of stuff
> without a user base rather than punishing lazy developers.

No. There's tons of Git tools out there. Should we include them all in
contrib/?

-- 
Felipe Contreras
