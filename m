From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 14:14:13 -0500
Message-ID: <CAMP44s3xbvaftqbWA97S=OEFguCbRdA45ryEXECnL7yDf+L0Uw@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
	<CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
	<alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3YyBEdXk=?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:14:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul27A-0002Fz-0F
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab3FGTOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:14:16 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:46989 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab3FGTOP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:14:15 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so3120710lbh.37
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N5u12u1o8QaFkBOwBZ85yuood5NDOTedmcXHJQm6irI=;
        b=bdqVQJirCXV8040C4MNB4xPtG1yO/iMkWZcnXtu5OyXHmC1W/84zynt5g8mOlRRIy0
         wZuB1QFDBF400hLrbWdWuNSc7WCTUmN/bEGDTWPpb7RxmTDuVMOLk/UAveUpEvABGjhX
         1yb3UAhCAB7qldTOFf2Qlgn4a9yW2QCUO2oZrQoFOmIGWEzVu6L5gUbKuS60oaaTN8d1
         h2MzrHuc+9vH8lOa+xpJndYIFOq48fRwcFC8MZk92dcTa/BDYRHUNSlwNjUawzHk9nhV
         P0N7MmulwY5kStcsGSCJlwAXWpeMpg9UkwlEkHF7TdsI+aOx0eWu9+Zl9sZ3a3EfmQsd
         BKMQ==
X-Received: by 10.152.7.74 with SMTP id h10mr3155269laa.83.1370632453703; Fri,
 07 Jun 2013 12:14:13 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 12:14:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226677>

On Thu, Jun 6, 2013 at 10:25 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 7 Jun 2013, Ramkumar Ramachandra wrote:
>
>> Johannes Schindelin wrote:
>> > My initial reaction, too. It was hard enough to get Perl included with Git
>> > for Windows (because of that pesky Subversion dependency).
>>
>> Nevertheless, we had to do it, and we did it.
>
> That is not quite correct. *I* did it. Not *we*. And I will not do it
> again.

That's fine, I can do it. I bet it will be easy.

While at it, why not re-evaluate the whole msysgit approach? I bet we
don't need a whole separate project just to create a Windows
installer. I've written Windows installers before, it's very easy to
do from Linux.

>> Rewriting everything in C?  Is anyone bored enough to pick up this task?
>> Bourne shell is a great language for prototyping; git-rebase.sh (and
>> friends), git-stash.sh, git-pull.sh are doing just fine.  Sure, it makes
>> sense to do heavy-lifting in C, and this is happening as it has always
>> been happening (remember git-commit.sh?).  If you followed the list
>> emails, you'd know that Felipe is looking into delegating large portions
>> of the work done by git-rebase.sh to sequencer.c.
>
> As you know, there are very good reasons why I do not follow those mails.

To the detriment on the project.

-- 
Felipe Contreras
