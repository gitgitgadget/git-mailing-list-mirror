From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Fix earlier "import quilt patches" patch
Date: Sat, 24 Sep 2005 20:47:55 +0100
Message-ID: <b0943d9e0509241247b2a5c75@mail.gmail.com>
References: <20050924104622.17274.18611.stgit@zion.home.lan>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 21:49:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJG0F-0008TR-KN
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 21:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVIXTr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 15:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVIXTr4
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 15:47:56 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:11001 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750725AbVIXTrz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2005 15:47:55 -0400
Received: by xproxy.gmail.com with SMTP id i30so959145wxd
        for <git@vger.kernel.org>; Sat, 24 Sep 2005 12:47:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ugoSVHYQPD1OfjrRddLYPk52mp4sNsUlcU8EojAsCbIT1NJzXSSOMpIx3JnVCNE+qwvgWO35rd9rCLDyU9fWSka2xKxlY7lhWQB5GY4e9Sf574TKzfBbfY9fgjeh+Bul4bk/Ibr5RkcMDPyn8yeoD6WchdKtlHz0MnSIv/oWW2g=
Received: by 10.70.60.14 with SMTP id i14mr1579291wxa;
        Sat, 24 Sep 2005 12:47:55 -0700 (PDT)
Received: by 10.70.31.3 with HTTP; Sat, 24 Sep 2005 12:47:55 -0700 (PDT)
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <20050924104622.17274.18611.stgit@zion.home.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9244>

On 24/09/05, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> wrote:
> I forgot to update all cases - I updated __parse_mail, not __parse_patch, so
> refactor together this duplication and use the fixed version.

Thanks. I'll apply it tomorrow.

> Btw, I don't like those regexps - they'd match in the middle of line too. What
> about adding ^ to their beginning like for the "^Index: " regexp?

Python's re.match() only matches from the beginning of the line, so ^
is not needed.

Catalin

--
Catalin
