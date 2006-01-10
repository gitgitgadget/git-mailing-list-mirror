From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: undoing changes with git-checkout -f
Date: Tue, 10 Jan 2006 17:17:01 +0100
Message-ID: <81b0412b0601100817h2a288a4ag337c749857f2c7fc@mail.gmail.com>
References: <43C2D2C4.2010904@cc.jyu.fi>
	 <7vmzi5hy69.fsf@assigned-by-dhcp.cox.net>
	 <20060110045533.GO18439@ca-server1.us.oracle.com>
	 <Pine.LNX.4.63.0601101549360.26054@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 17:17:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwMBH-0002qL-Fw
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 17:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWAJQRE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 11:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWAJQRE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 11:17:04 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:4931 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932112AbWAJQRD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 11:17:03 -0500
Received: by nproxy.gmail.com with SMTP id k26so1366451nfc
        for <git@vger.kernel.org>; Tue, 10 Jan 2006 08:17:02 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n9GkgR02EdlQKTB8J9OQ7QbFpUZ61TUOLfrdElT3DHbA3YF8riiedbQtXE2gvjHP5aaZzS0/Zpxhge9sku+4V9TGtOdTmGZZgUi2woSeMAZb/eaov9RtIJmO18wv1YT7Rz64ZLf/cXkKKH8O7T09fsKTrgwzWPZ4cBphyKK0+w0=
Received: by 10.48.48.12 with SMTP id v12mr85844nfv;
        Tue, 10 Jan 2006 08:17:01 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Tue, 10 Jan 2006 08:17:01 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601101549360.26054@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14425>

On 1/10/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >       Can we teach the git:// fetch program to use CONNECT over HTTP
> > proxies?  rsync can do this, but git:// cannot, so firewalls that block
> > 9418 mean we use rsync://
>
> I think it is good and well with the proxy command support. Everybody can
> write a little script.
>
> Otherwise, where would it end? If you include http_proxy functionality in
> git, why not also https_proxy functionality? And if that, why not

And, BTW, why not? It may as well stop here.
