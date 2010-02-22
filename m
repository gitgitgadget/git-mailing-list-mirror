From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-gui: fix worktree initialization with empty prefix
Date: Mon, 22 Feb 2010 16:32:59 +0100
Message-ID: <vpqsk8t1e1g.fsf@bauges.imag.fr>
References: <vpqaav1llpn.fsf@bauges.imag.fr>
	<1266851964-13044-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 16:33:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjaHX-0003qV-5K
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 16:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab0BVPdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 10:33:05 -0500
Received: from mx1.imag.fr ([129.88.30.5]:49377 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955Ab0BVPdE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 10:33:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o1MFUcs4003467
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Feb 2010 16:30:38 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NjaHL-0001kT-9Z; Mon, 22 Feb 2010 16:32:59 +0100
In-Reply-To: <1266851964-13044-1-git-send-email-giuseppe.bilotta@gmail.com> (Giuseppe Bilotta's message of "Mon\, 22 Feb 2010 16\:19\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 22 Feb 2010 16:30:38 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140690>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> This is sort of a chicken-and-egg problem, because we should only
> bother setting the worktree if we are not in a bare repository, but
> an unset worktree is one of the conditions we check to see if we have
> a bare repository.
>
> Maintain the same sequence of checks, but swap the check for bareness
> support and bareness of repository, and check again for an unset
> worktree if we are not in the bare case.

Tested-by: Matthieu Moy <Matthieu.Moy@imag.fr>

(don't forget Signed-off-by)

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
