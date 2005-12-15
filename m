From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Now what: multiple HEAD refs
Date: Thu, 15 Dec 2005 16:57:02 +0100
Message-ID: <81b0412b0512150757v3acf1bdfudbe9ff26b544b196@mail.gmail.com>
References: <81b0412b0512150105p5bacd6a1j938824ae2ab96858@mail.gmail.com>
	 <7v8xumr9mw.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0512150216w295a5943ma66522befe381529@mail.gmail.com>
	 <7vlkymph4f.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0512150654o49e1edacu67b88df6347736d2@mail.gmail.com>
	 <Pine.LNX.4.63.0512151638260.3104@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 17:03:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmvTh-0008LP-8j
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 16:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVLOP5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 10:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVLOP5F
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 10:57:05 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:16105 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750775AbVLOP5E convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 10:57:04 -0500
Received: by nproxy.gmail.com with SMTP id m18so133048nfc
        for <git@vger.kernel.org>; Thu, 15 Dec 2005 07:57:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FVtclVYtoTxgenNr2qZxc9sm4zZ6+NcXHlEOEBzjfiiC1azKgmAS1FzfV5jilZJB2FSox1mkqny6zdA3s4fxkKPHV9l8k6eLxFQdLLgj95jR+VYPun7S49wk1UXQ7UQiSWhY5WoA0rbj2c24r7kL2ol5+8r1llxYW5o7krXXzMA=
Received: by 10.48.254.11 with SMTP id b11mr95028nfi;
        Thu, 15 Dec 2005 07:57:03 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Thu, 15 Dec 2005 07:57:02 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512151638260.3104@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13701>

On 12/15/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > not make any sense to me; I am puzzled ... what are you trying
> > > to achieve with "git pull . ref1:HEAD"?
> >
> > merge branch ref1 into current. Is that not a correct refspec?
>
> No, it is not correct. To pull means that you want to merge the fetched
> ref (your ref1), and store the result in the current branch.
>
> But if you write "ref1:HEAD", you pretend that you want to fast-forward
> the local branch "HEAD" to ref1, and get an error if it is not
> forwardable.
>
> In your case, I guess, "git pull ref1" is what you meant.

I did, I guess...
Confused now.
