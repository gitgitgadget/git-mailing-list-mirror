From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 16:39:59 -0500
Message-ID: <5373e2af9ae58_592416ad2f892@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
 <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
 <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
 <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
 <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
 <CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
 <87mweku2pt.fsf@fencepost.gnu.org>
 <CAGK7Mr5ezbTVyq2wr7kYWjab6V1srrYwkqSGjo1GuPnkSuGWTQ@mail.gmail.com>
 <87iop8u1km.fsf@fencepost.gnu.org>
 <CAGK7Mr4N5L+jRE0ykBHvopgGv1x4iNXAK+_94R5KhBxHHqMYmA@mail.gmail.com>
 <87egzwtthf.fsf@fencepost.gnu.org>
 <CAGK7Mr6XTxpeJLSqL8PZMS8w+YCqxLrC5wX-dg4BdEaW3QAYTA@mail.gmail.com>
 <87a9aktqms.fsf@fencepost.gnu.org>
 <CAGK7Mr7jhpizoHuA9NDnyNPy_rr8_R0m8-hCFO3CDn2Hbh3_pQ@mail.gmail.com>
 <5373cfb744982_57c3bfb300a0@nysa.notmuch>
 <87mwekrsap.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 23:51:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkh4m-00033F-Cv
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbaENVu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:50:58 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:44499 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbaENVu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:50:57 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so222414obc.16
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=YWkbCwlm12g7+XVvCPAmwN+dM1F1vcBmxRfjjtXN22g=;
        b=dDla1rmjvtdXFz3LIwahakNavGI+kFbGLfuktXn5odW3RQ36NTIcCT0fQJhr+id3nK
         JuwydIeQC5pdaVl406Vkq8kbH59VxdSWQqM0zhZUoYbAXfmnTmJzzdkaqHAqeawD0I8J
         MeAY1f1j8efBrMidBmmayurIba6lAQP2YrEbz6AlPknmCK2rJLRGPgFxzSLXpy8X6qKE
         w+XVwR0zP4NpsvsEfuAuHn1MX/ZT8AJtxs7MU7EbWwUXUlpeu+bR5D44zkNkhoPZCE4Q
         f+lnqq++jvN7eVnf5ZdMjwIP0cIujsGcO3vCjoU/B6sEcfjpiid7J8Td8sqEUNwW43VJ
         X84Q==
X-Received: by 10.182.33.6 with SMTP id n6mr6153956obi.48.1400104257299;
        Wed, 14 May 2014 14:50:57 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qh7sm5415319obc.13.2014.05.14.14.50.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 May 2014 14:50:56 -0700 (PDT)
In-Reply-To: <87mwekrsap.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249002>

David Kastrup wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Philippe Vaucher wrote:
> 
> [...]
> 
> >> > Do you feel Felipe is in control of what you label bad behavior?  Do you
> >> > feel you are in control over how you react to his behavior?
> >> 
> >> I feel that Felipe cannot control this (or decided not to),
> >
> > I am pretty much in control of my behavior. Those who know me
> > personally know that I *never* get angry.
> 
> You are missing the point.  The point is not what effect your behavior
> has on you but what it has on others.

If me saying "I do not believe in God" has a negative effect on Mark,
your answer seems to be "do not tell Mark the truth". If Mark was a
co-worker and I had no option but to interact with him, I would probably
do something along those lines if possible. But if Mark was a member of
an open source project, I do have an option and I'd rather tell it like
it is. If Mark has a problem with that, I can always avoid Mark, or just
leave the project (say if Mark was the maintainer).

In both cases Mark is wrong. I do understand that most people would
rather comprimise their beliefs in order to win penguing points. I'm
not that way.

If I can't speak my mind in an open source project where I'm
contributing my time *for free*, I do not want to be part of that
project. It's the project that's wrong, not me, and it's the project
that looses, not me.

-- 
Felipe Contreras
