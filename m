From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: git pull for update of netdev fails.
Date: Sat, 23 Sep 2006 14:15:01 +0100
Message-ID: <b0943d9e0609230615t60e6d573r4abe043c079a2367@mail.gmail.com>
References: <20060920080308.673a1e93@localhost.localdomain>
	 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org>
	 <20060920155431.GO8259@pasky.or.cz>
	 <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060920160756.GP8259@pasky.or.cz>
	 <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
	 <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060923034407.GF8259@pasky.or.cz>
	 <20060923040035.GB18105@spearce.org>
	 <20060923040942.GG8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 15:15:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR7LY-0006ae-HJ
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 15:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWIWNPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 09:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWIWNPE
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 09:15:04 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:60716 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751098AbWIWNPB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 09:15:01 -0400
Received: by py-out-1112.google.com with SMTP id n25so1672257pyg
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 06:15:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EmFx5OSiVfEEAwDQS5CVY/LTAzzuPltr1xEltN8lIJyPhyhzwXy02iek4nbGmZXaWT/SisG1Sk7lolOdM4AWUqa32sITXqLz3uEDLvE4o9ovsjLRcCW0lfo36eWjEILq0ieBhI5EU53zpUq5/6TDBP1NSnL76lY9bS62D3g6QMU=
Received: by 10.35.125.16 with SMTP id c16mr3689932pyn;
        Sat, 23 Sep 2006 06:15:01 -0700 (PDT)
Received: by 10.35.77.5 with HTTP; Sat, 23 Sep 2006 06:15:00 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060923040942.GG8259@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27588>

On 23/09/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Sat, Sep 23, 2006 at 06:00:35AM CEST, I got a letter
> where Shawn Pearce <spearce@spearce.org> said that...
> > I can see the same concept of ref history being useful even for
> > core git-rebase and doing it this way would also give it to StGIT
> > without Catalin needing to change code.
>
> In my StGIT tree, I don't want to have arbitrary N-days cutoff point,
> I want all the patches history preserved at least as long as I carry
> the patch, because it's just as valuable as the "regular" project
> history to me.

That's how it currently works (the top of the log is in
refs/patches/<branch>/<patch>.log). I gave up the idea of using
reflogs for patch history.

-- 
Catalin
