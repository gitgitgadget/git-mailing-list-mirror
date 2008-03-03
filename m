From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] builtin clone: support bundles
Date: Mon, 3 Mar 2008 01:04:11 +0100
Message-ID: <8aa486160803021604r25f80e06xe3aecf23eb4fe172@mail.gmail.com>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
	 <200802260321.14038.johan@herland.net>
	 <alpine.LNX.1.00.0802261128360.19024@iabervon.org>
	 <alpine.LSU.1.00.0803020556380.22527@racer.site>
	 <alpine.LSU.1.00.0803020622190.22527@racer.site>
	 <alpine.LSU.1.00.0803020743170.22527@racer.site>
	 <alpine.LNX.1.00.0803021113390.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"=?ISO-8859-1?Q?Kristian_H=F8gsberg?=" <krh@redhat.com>
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 01:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVyBk-0003Lu-5u
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 01:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbYCCAEn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 19:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbYCCAEe
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 19:04:34 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:24885 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbYCCAEP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2008 19:04:15 -0500
Received: by ti-out-0910.google.com with SMTP id 28so5431859tif.23
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 16:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eJOR3PbazcNtJtRP6oEprqsbY84/Vt1dUwZwiACQKdY=;
        b=g4KVJIfBsIXW+vmjxpjGLpGSJeqqWCWKHXrfdM8lcC6FjeqfmRG0zprC+haXjYeUXgdqn2SPBDcI6DvJyFTM3CrR6tHCDTMKGaHxnpZU2BFwDv7dA4WxG2ikIlBdhqQfGHALD2m08G6iUGV1XmLLk7qcdaNCE80ph4+hLkZeg1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d4YXDZJd48+rN361RyQJdlcRmqrnDTF2JArB3nygr3DRt8R82nBtl1AhoX95xWV9y9rbS2zKMyEGtnASTq4oz4orK3dXo9flLMLNWzYNFPSbdCXmHaRsHtvamD5dSH5TCCcXyV5czf8Oowu8PhZPV/ounK1BCPaJ+nVxzZpd1vw=
Received: by 10.150.54.6 with SMTP id c6mr4257480yba.43.1204502651815;
        Sun, 02 Mar 2008 16:04:11 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Sun, 2 Mar 2008 16:04:11 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0803021113390.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75859>

On Sun, Mar 2, 2008 at 5:19 PM, Daniel Barkalow <barkalow@iabervon.org>=
 wrote:
> On Sun, 2 Mar 2008, Johannes Schindelin wrote:
>
>  >       Daniel, do you have a branch where you have your current ver=
sion
>  >       of builting clone?  Mine is in "my-next" of
>  >       http://repo.or.cz/w/git/dscho.git.
>
>  I don't yet, and I've been meaning to post my latest, but haven't go=
tten
>  to it. Once I get these two patches integrated, I'll put something u=
p at:
>
>  git://iabervon.org/~barkalow/git.git builtin-clone

I've tested the bundle modifications in it and they work for me, so:

Tested-by: Santi B=E9jar <sbejar@gmail.com>

at least for the bundles part (022fc130). Thanks Johannes for the forwa=
rd-port.

Santi
