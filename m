From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 00:48:38 +0100
Message-ID: <46d6db660701291548j454d7d70w9302640e28b0e70e@mail.gmail.com>
References: <200701292320.43888.johannes.sixt@telecom.at>
	 <20070129223513.GA31372@spearce.org>
	 <46d6db660701291511v700bfcf7l4851dd6be4fc6e03@mail.gmail.com>
	 <20070129232425.GB31372@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 00:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBgEs-0003Yt-CI
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 00:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbXA2Xsk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 18:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbXA2Xsk
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 18:48:40 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:39012 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964845AbXA2Xsj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 18:48:39 -0500
Received: by an-out-0708.google.com with SMTP id b33so810860ana
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 15:48:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UfrNQjEFvWo9Gdqa/kcjq7qS2Zg4EIbcNvyGiDD8dK5w/V1LWw8uadrnLO58+KiEHjiNM1VwLEx25rg8Z73pySQeqKwsYyFmNVrMhKpnI1aegwOfXpkrm1Lv3wAQgtc521NFWqBDKc70vNFT4el7gsAsUA6/8vJQuDbJU+NlSl4=
Received: by 10.114.39.16 with SMTP id m16mr317018wam.1170114518135;
        Mon, 29 Jan 2007 15:48:38 -0800 (PST)
Received: by 10.115.16.9 with HTTP; Mon, 29 Jan 2007 15:48:37 -0800 (PST)
In-Reply-To: <20070129232425.GB31372@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38115>

On 1/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Try creating a desktop icon (Repository->Create Desktop Icon) and
> start git-gui from the resulting .bat file.  It *should* come up
> right on MinGW, but I'm only guessing here.

ok noted for tomorrow's tests :)

> The other one that I'm curious about is if fetch/push/merge work.
> merge requires git-merge right now, which is a shell script.
> fetch is the same, but push is pure C so it should work.  But I
> don't think the Tcl environment will make it into the child, which
> means things like SSH_AUTH_SOCK don't get used.

I'll see what I can do.

> But I really should just install the git-mingw port on one of
> my windows systems and play with it.  If its faster than Cygwin
> then it's worthwhile.

one of the hassles with this mingw thingy is that you need to
install it, and whatever you compile gets inside it, like libs,
includes, etc... Whenever I come out with a stable product
that can be sfx'ed inside a 7zip executable, I do it, to avoid
installing/uninstalling or even modifying it.

it works like a charm with msys/mingw, and I guess git/gitk/git-gui
will all work in this way too. Once this port is ready for mass
testing, I guess we can either show how to compile it (actually
some patches are still needed, like no symlinks exist on
msys/mingw, so we should replace those links by bash scripts),
or provide a 7z sfx binary that can help <<pushing>> git
to the mass. On this last possibility I can help out...

your call, guys. :)

> The blame feature is in git-gui (went in last night).  It requires
> the --incremental patches from Linus&Junio, which are now in git.git
> master.  It also needs a big display, as the interface is horrid.  :)

I'll find a big one then.

-- 
Christian
