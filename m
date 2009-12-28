From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Allow git to use any HTTP authentication method.
Date: Mon, 28 Dec 2009 07:37:01 -0800
Message-ID: <20091228153701.GA2252@spearce.org>
References: <200912281154.09442.lenaic@lhuard.fr.eu.org> <alpine.DEB.2.00.0912281406210.5582@cone.home.martin.st> <be6fef0d0912280412w58401f10n972f9198144cd580@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Storsj? <martin@martin.st>,
	L?na?c Huard <lenaic@lhuard.fr.eu.org>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 16:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPHf9-0001Kk-Ft
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 16:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbZL1Ph3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 10:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbZL1Ph2
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 10:37:28 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:47851 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbZL1Ph2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 10:37:28 -0500
Received: by ywh6 with SMTP id 6so10468103ywh.4
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 07:37:27 -0800 (PST)
Received: by 10.151.88.28 with SMTP id q28mr22493491ybl.337.1262014647517;
        Mon, 28 Dec 2009 07:37:27 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 8sm4720754yxb.43.2009.12.28.07.37.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Dec 2009 07:37:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <be6fef0d0912280412w58401f10n972f9198144cd580@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135741>

Tay Ray Chuan <rctay89@gmail.com> wrote:
> On Mon, Dec 28, 2009 at 8:09 PM, Martin Storsj?? <martin@martin.st> wrote:
> > On Mon, 28 Dec 2009, L??na??c Huard wrote:
> >
> >> The attached patch makes git configure libcurl to negotiate the most suitable
> >> HTTP authentication method.
...
> > Something similar has already been queued for inclusion, and is available
> > in the branch 'next', in commit b8ac923010484908d8426cb8ded5ad7e8c21a7f6.
> > The patch available there requires you to set http.authAny for the libcurl
> > option to be enabled.

Uh, stupid question, but why must we enable this option?  I don't
have to enable something in my browser before I use digest auth to
visit a website, why do I need to enable it in git?

How does one use git clone with an http:// URL with digest
authentication?  Its not obvious to the user that you would need
to first export an obtuse environment variable to get something
that should Just Work(tm).

Yes, I realize you may need to perform an extra HTTP request to
start the transaction, but why aren't we doing that?  Isn't it only
1 additional request to discover the desired authentication method?

-- 
Shawn.
