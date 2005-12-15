From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Now what: multiple HEAD refs
Date: Thu, 15 Dec 2005 11:16:26 +0100
Message-ID: <81b0412b0512150216w295a5943ma66522befe381529@mail.gmail.com>
References: <81b0412b0512150105p5bacd6a1j938824ae2ab96858@mail.gmail.com>
	 <7v8xumr9mw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 11:18:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmqAE-0000ER-BG
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 11:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbVLOKQ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 05:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbVLOKQ2
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 05:16:28 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:22597 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422677AbVLOKQ2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 05:16:28 -0500
Received: by nproxy.gmail.com with SMTP id x29so107359nfb
        for <git@vger.kernel.org>; Thu, 15 Dec 2005 02:16:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n46EXUJ5pClGDOIV1f13jmeDJgJRtfumUzUNvIIRTyA0QMLQluMBPn1L06WThmhmlK8W6R8q+YckfPEXvt2jSKDVeYoqC2YlJWa8IFTr/2YT0ciiiHgmRypftmbnsfWa+cdRaN29gIySoYi5Nnkf+GEGMafSPhfnU3BX9TIg2m0=
Received: by 10.48.80.1 with SMTP id d1mr75454nfb;
        Thu, 15 Dec 2005 02:16:26 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 15 Dec 2005 02:16:26 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xumr9mw.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13692>

On 12/15/05, Junio C Hamano <junkio@cox.net> wrote:
> > just a heads-up for everyone tried "git pull" after using "git merge" too much:
> >
> > $ git pull . ref1 HEAD (notice the space!)
>
> If you were too used to git merge, you would have wrote
> HEAD before ref1, so that does not sound plausible ;-).

no, that I have remembered. What I constantly forget is the
space-vs-colon difference.

>         $ git pull . maint HEAD
>         error: no such remote ref refs/heads/HEAD
>         Fetch failure: .
>         $ echo $?
>         1
>
> But worse yet, the above syntax is to create an Octopus, and you
> probably did not mean that.

no, of course not.

> I think the reason why my trial here worked correctly while you
> had trouble with it is because I have the send-pack fix from
> Pasky last night.

yes, probably. It cleanups a reference if there was an error, right?
