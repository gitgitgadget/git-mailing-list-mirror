From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [PATCH] On error, do not list all commands, but point to --help option.
Date: Sun, 21 Oct 2007 14:33:26 +0800
Message-ID: <46dff0320710202333g70b022f4r6574e93aa0463065@mail.gmail.com>
References: <bqaujirk.fsf@blue.sea.net>
	 <Pine.LNX.4.64.0710202126430.25221@racer.site>
	 <odetifoh.fsf@blue.sea.net>
	 <Pine.LNX.4.64.0710210001390.25221@racer.site>
	 <20071021020653.GA14735@spearce.org>
	 <20071021032427.GB8545@coredump.intra.peff.net>
	 <20071021032953.GC14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jari Aalto" <jari.aalto@cante.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 08:33:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjUNY-0003LS-8Z
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 08:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXJUGd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 02:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbXJUGd2
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 02:33:28 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:52514 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbXJUGd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 02:33:27 -0400
Received: by py-out-1112.google.com with SMTP id u77so1794224pyb
        for <git@vger.kernel.org>; Sat, 20 Oct 2007 23:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eO/RVifSsCbtvTEe/N4SRKHWj0J8Eag+29n5cKXaZXY=;
        b=UKmY+gLeweA00uD0bHcCg2cbRkkqHKqUmQMZ6gNhQoSxBtZq1pq9rCoXsf4l05GhprvGCSm3XU6VZcfg6l2+ps8doYXWQ/WRqX57gEuHxZOJgJ9BMR50IcsbaRzePsqeTr3YQHF5GbcxYbIPtmLBDuSa7YiufpGOUTLwc0ofDME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y2IsfllxclX/Mtmgrqgd3DyeISfAYjmEFLSn+r+z9Fav2ydaJczMu09cD1uRm1IKAOE3iIcCBwy2yPQsZhbiFXjfVqK0hOamtrnzqJi1Sf4AlQblK+WNvgLH1LCnG8lqhbQlrf9Tb2akeSmgTjOlg+xMiG/3VoCEoiAqSEbtnFA=
Received: by 10.35.39.2 with SMTP id r2mr4388679pyj.1192948406396;
        Sat, 20 Oct 2007 23:33:26 -0700 (PDT)
Received: by 10.35.52.7 with HTTP; Sat, 20 Oct 2007 23:33:26 -0700 (PDT)
In-Reply-To: <20071021032953.GC14735@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61882>

On 10/21/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jeff King <peff@peff.net> wrote:
> > On Sat, Oct 20, 2007 at 10:06:53PM -0400, Shawn O. Pearce wrote:
> >
> > > I actually had to do `git config alias.upsh push` just to keep
> > > myself from screaming every time I made a small typo and Git gave
> > > me a screenful of "helpful reminders".
> >
> > Yeah, somebody should really work on bash completion...
>
>   $ git pu<TAB><TAB>
>   pull     push
>
> By the time I type out "pus" and hit tab I've already typed out
> the name "push ".  Except I frequently find myself getting the
> u before the p, which can't complete.  Of course with the above
> alias in place "git u<TAB>" completes out uniquely to "git push "
> (between bash completion and the alias expansion).
>
> But that alias isn't there for my bash tab completion.  Its there
> exactly because otherwise "git upsh" gives me 31 lines of useless
> (to me) output without it.
>


My way to resolve this is to define some alias begenning with 'gt' for
frequently used commands, such as 'gtps -> git-push,  gtpl ->
git-pull,  gtco->git-checkout,  gtci->git-commit,  gtbr->git-branch'.
so that when i type 'gt<TAB>', only commands that i frequently use are
listed.


-- 
franky
