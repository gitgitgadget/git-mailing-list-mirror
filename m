From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 12:11:44 -0800
Message-ID: <20130131201144.GJ27340@google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org>
 <20130131190747.GE27340@google.com>
 <7vip6dgmx2.fsf@alter.siamese.dyndns.org>
 <20130131195712.GH27340@google.com>
 <7va9rpgm06.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 21:12:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U10UX-00033t-IL
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 21:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721Ab3AaULw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 15:11:52 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:33339 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab3AaULu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 15:11:50 -0500
Received: by mail-pb0-f41.google.com with SMTP id ro12so1775647pbb.14
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 12:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Uq8RVTRnh/dVw7S8cONXHornUuBipMoWDmTAmPM+Ga4=;
        b=K5ADaVsVuBKEnkB9BcRej7Azufn9UfXlBbDcdVUyXGZdz1GDBh+BEah8l9g5UeOsJ6
         aU6YFn+Fgf5ojjaGOFYeLhATEByYrUdqaUrqsetktuTIjagRYeGU12i3sh1pN3UnhW4E
         sc1JHn7blHJbMa4W1zK5Fe1yQGz1Cx5HvZwr1jZm+wq2hLPheDesyXjMES9yxMXFA7nG
         51ICFzbY/Fz+fYh7dTpB1FFsgYbDP7Hhgk4oxZ5QpLc7pvX/ZK9ahFIBOeljgTR5/h7Z
         W3gMDbcEu3hfLaC2kQtEPH3TsMTCJ2S4AVN1baCH0lXs3i8SFF0f9DNUmdOCUFtNFiOo
         U6mg==
X-Received: by 10.66.81.199 with SMTP id c7mr23448614pay.39.1359663110198;
        Thu, 31 Jan 2013 12:11:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id rv8sm5906033pbc.27.2013.01.31.12.11.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 12:11:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7va9rpgm06.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215162>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> That works because, as you mention, the usual way to look up an option
>> in manpages is to search for "--print", including the two minus signs.
>>
>> Unfortunately an analagous approach in gitconfig(5) would be seriously
>> broken, because searching for "tracking" (no minus signs) is going to
>> hit many false positives.  I do not think such a change would be an
>> improvement.
>
> I thought your example was that you saw "pull.default = tracking"
> and wondering what it is.  Why do you need global search for
> "tracking", not just near pull.default is described, in the first
> place?

Because the UI for local searches in web browsers and man pagers is
seriously lacking.  Or, because people have bad habits and do not
take apppropriate advantage of search in small subsections of a
document.  All I know is that I have seen myself and others doing
searches analagous to "--print" and not seen searches analagous to
"tracking".

Am I really the only one that doesn't see the "--print" change as
hiding an option and sees burying "tracking" in the text as
qualitatively different?

Jonathan
