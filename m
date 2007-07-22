From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Avoid to duplicate commit message when is not encoded
Date: Mon, 23 Jul 2007 00:04:33 +0200
Message-ID: <e5bfff550707221504g395580e6jdde1f37a810302f0@mail.gmail.com>
References: <e5bfff550707220123g5826cbf5n3e2ff7256d9b5366@mail.gmail.com>
	 <20070722085225.GB3408@steel.home>
	 <7v4pjwssp0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:04:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjXg-0007kJ-Kv
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbXGVWEi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbXGVWEh
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:04:37 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:14992 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765996AbXGVWEg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:04:36 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1767858wah
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 15:04:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K52XlSomglL5jm7PTo2ISgwLi0PcWhaH/AjfulW1x9op4Gtt13rpPqpUcbyLzpRvzAlxL/tlBRMik94H0PSGo6ZZqhwGBekvkN0E0V23EC1PPIcfMusJglWA0NOM8qYQ9cOGu4n2BYzsa4txbIrdPbSTdQuumRjnDxTo4bgZiv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rQVfRk0ld6WJLHIZ8LhkCYC/3/v3EEg8lyan8rCU4ztCZVcULcefQugbXchMJiCb2Lab/Lerq86/oFaNPnFBo6IQx8kZazK2Mw5QpKRFcmbT9RBet4q9mQiKMC2tgF3n09D110gCxSH0JXPP4p7oBipskpqnj0DMFHiBXoE91j8=
Received: by 10.114.176.1 with SMTP id y1mr2385734wae.1185141874044;
        Sun, 22 Jul 2007 15:04:34 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Sun, 22 Jul 2007 15:04:33 -0700 (PDT)
In-Reply-To: <7v4pjwssp0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53334>

On 7/22/07, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
> > Marco Costalba, Sun, Jul 22, 2007 10:23:05 +0200:
> >> +            if (encoding) // we'll strip encoding header later
> >
> > You better avoid using C++ comments, not all C compilers support them.
>
> I've "fixed" them.
>

Sorry, I wrote them automatically without thinking it is better to
avoid them in C. BTW I would think it's more about coding style then
compiler support.

> >> +            else
> >> +                    return NULL; // nothing to do
> >
> > And you better avoid such useless comments too
>
> I think this one is probably a good-to-have.  It really needs a
> bit of thinking why there is nothing to do in this case.  At
> least for me it did ;-)
>

Me too ;-)
