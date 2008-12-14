From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2008, #02; Sun, 14)
Date: Sun, 14 Dec 2008 03:17:05 -0800 (PST)
Message-ID: <m3ljujdn2k.fsf@localhost.localdomain>
References: <7v7i632mg9.fsf@gitster.siamese.dyndns.org>
	<alpine.DEB.1.00.0812141142300.2014@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 14 12:18:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBozd-00048V-GT
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 12:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbYLNLRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 06:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbYLNLRT
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 06:17:19 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:35734 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbYLNLRT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 06:17:19 -0500
Received: by ewy10 with SMTP id 10so2516365ewy.13
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=fWdb8qx0UzxlyAY42JAVxhWe9IUXDAhlkXxtiiK4JOs=;
        b=sW/EGH9bzUptOJQVi2dioyckmlx0kOHQqNdS7PhbTVMiGHMHh/g1t6wCtT+exGk9J7
         0R4LKD0YfN3F3pDunePNtiZ+kMHFIrOtOzNwmKrl2iE+1eqxxINXZiyWrta0JpQB9oTw
         Gf0IF3zXuoJ9E68As+Gve9dDT0r72OjLyfj/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=qumNHwQ06Mssv5PYLu+mF69VhfYlJtbQUNCYK5v/7JsqiJdajCWw/u20ZM297ZNRU4
         estCXhDbpZ8Nd1HmQdAeNJs+bje42azw9LsboN4SEv39qqPILCAUAXBhdBsUkKDQWL1D
         6R8smhx86yIZJJlgQ3na3kk6BhZFrImg3/JX8=
Received: by 10.210.81.3 with SMTP id e3mr6475633ebb.21.1229253437184;
        Sun, 14 Dec 2008 03:17:17 -0800 (PST)
Received: from localhost.localdomain (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id k9sm48861nfh.57.2008.12.14.03.17.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 03:17:05 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBEBGQVk015890;
	Sun, 14 Dec 2008 12:16:37 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBEBG3JA015875;
	Sun, 14 Dec 2008 12:16:03 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0812141142300.2014@eeepc-johanness>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103069>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> On Sun, 14 Dec 2008, Junio C Hamano wrote:
> 
> > * mv/um-pdf (Wed Dec 10 23:44:50 2008 +0100) 1 commit
> >  - Add support for a pdf version of the user manual
> > 
> > I do not have a new enough combination of dblatex and asciidoc myself 
> > but this would help interested people.
> 
> I haven't had a look at the patches, but isn't "pdflatex" supposed to be 
> the common way to get .pdf files from LaTeX sources?

The problem is that AsciiDoc, from what I understand, by itself
generates only XML-ish formats, namely HTML, XHTML and DocBook, and
the rest of formats are generated in postprocessing step by extra
tools from DocBook format:
 * manpages require xmlto
 * info requires docbook2X and makeinfo
 * PDF requires dblatex (db = DocBook), or FOP and xmlto

So the answer is that AsciiDoc does not generate LaTeX, so pdflatex
would be not enough.

By the way, from the AsciiDoc page:

 NOTE: Owning to to other commitments, Benjamin is unable to maintain
       this backend. I don't have the expertise or time to take this
       on consequently the LaTeX backend has not been tested or
       updated since AsciiDoc version 8.2.7 and is currently
       unsupported.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
