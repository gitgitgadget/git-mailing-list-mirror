From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Allow git to use any HTTP authentication method.
Date: Mon, 28 Dec 2009 07:53:46 -0800
Message-ID: <20091228155346.GB2252@spearce.org>
References: <200912281154.09442.lenaic@lhuard.fr.eu.org> <alpine.DEB.2.00.0912281406210.5582@cone.home.martin.st> <be6fef0d0912280412w58401f10n972f9198144cd580@mail.gmail.com> <20091228153701.GA2252@spearce.org> <alpine.DEB.2.00.0912281745540.5582@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	L?na?c Huard <lenaic@lhuard.fr.eu.org>, git@vger.kernel.org
To: Martin Storsj? <martin@martin.st>
X-From: git-owner@vger.kernel.org Mon Dec 28 16:53:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPHus-000764-B7
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 16:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbZL1Pxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 10:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbZL1Pxv
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 10:53:51 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:63713 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbZL1Pxu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 10:53:50 -0500
Received: by yxe17 with SMTP id 17so9381736yxe.33
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 07:53:49 -0800 (PST)
Received: by 10.150.44.21 with SMTP id r21mr23103236ybr.78.1262015629775;
        Mon, 28 Dec 2009 07:53:49 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 4sm4084834ywd.29.2009.12.28.07.53.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Dec 2009 07:53:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0912281745540.5582@cone.home.martin.st>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135743>

Martin Storsj? <martin@martin.st> wrote:
> Initially when I added support for this, curl sessions weren't reused, so 
> every single request had to be duplicated if authentication was used, 
> adding quite a bit of overhead.
> 
> Now that sessions are reused properly, I tend to agree that this should be 
> enabled automatically.

Oh, that makes sense, thanks for the explanation.
 
> Should I send in a new patch that removes the http.authAny option and 
> always enables this, or send a rewritten version of the patch that already 
> is in 'next'?

I'm not Junio, but I would suggest sending in a new patch series,
and asking Junio politely to revert the one that is currently in
next before merging in the new series.

If we really are killing http.authAny before it hits master, there
is no reason for it to appear in the final project history.

-- 
Shawn.
