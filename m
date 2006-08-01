From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Tue, 1 Aug 2006 15:53:52 -0700 (PDT)
Message-ID: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com>
References: <7vfygg14sq.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 00:54:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G837n-0006Xz-Le
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 00:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWHAWxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 18:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWHAWxy
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 18:53:54 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:54190 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750728AbWHAWxx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 18:53:53 -0400
Received: (qmail 27000 invoked by uid 60001); 1 Aug 2006 22:53:52 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XV5dVgjlTOejh9Ciav2xDHiCGwy+maCntzmILd9bxEygEIIK4JiQE3yExxW/o9ILUTOT7LyI5D/JsK3HI6/6d9+wwN4TXvzFsKaFXMyRv7zFj9ZK7imFmkgscStbJd5ZSh4bft38fiq7K0POTBq/Y/TK6H+wewtetO+3RRa22Ic=  ;
Received: from [64.215.88.90] by web31801.mail.mud.yahoo.com via HTTP; Tue, 01 Aug 2006 15:53:52 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfygg14sq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24614>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Copy "Gitweb_customization.pm" to where your "gitweb.cgi" or
> > its link lives.
> 
> I do not think this is a good idea -- there may not be any harm
> done when http://site/cgi-bin/Gitweb_customization.pm is
> accessed, but this _does_ pollute the cgi-bin/ namespace.

As does "gitweb.css".  Similarly, "gitweb.css"'s contents
used to live in "gitweb.cgi" itself.

"Gitweb_customization.pm" doesn't necessarily need to live
in "http://site/cgi-bin/", but anywhere in any path
in @INC, i.e. such that it wouldn't be accessible from
the outside world.

This method of customization seemed the least intrusive
and easiest from re-deployment point of view.

    Luben
