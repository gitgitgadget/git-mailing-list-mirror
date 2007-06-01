From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 1/4] Add 2 new contrib scripts.
Date: Fri, 01 Jun 2007 11:22:12 +0200
Message-ID: <87fy5cqbaz.fsf@morpheus.local>
References: <20070531222920.6005.74481.stgit@gandelf.nowhere.earth> <20070531223423.6005.59088.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 11:22:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu3LR-0001Xq-19
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 11:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbXFAJWd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 1 Jun 2007 05:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755489AbXFAJWc
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 05:22:32 -0400
Received: from main.gmane.org ([80.91.229.2]:37702 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243AbXFAJWc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 05:22:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hu3Ku-00026x-Qn
	for git@vger.kernel.org; Fri, 01 Jun 2007 11:22:20 +0200
Received: from c83-253-22-183.bredband.comhem.se ([83.253.22.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 11:22:20 +0200
Received: from davidk by c83-253-22-183.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 11:22:20 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-183.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:rbLrpUk/GXRwy4I8pnEB29N+g48=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48858>

Yann Dirson <ydirson@altern.org> writes:

> diff --git a/contrib/stg-unnew b/contrib/stg-unnew
> new file mode 100755
> index 0000000..5ac8781
> --- /dev/null
> +++ b/contrib/stg-unnew
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +set -e
> +
> +# stg-unnew - sort of "reverse an 'stg new'"
> +
> +# Remove the current patch from the stack, keeping its contents as
> +# uncommitted changes.
> +
> +# Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
> +# Subject to the GNU GPL, version 2.
> +
> +patch=3D$(stg top)
> +stg pop
> +stg pick --fold $patch
> +stg delete $patch
>

This is something I've been missing.  But I'd call it "stg merge" or
something, since what it does is that it merges the top patch into the
patch below it.  But since "merge" means something else to git, it
might not be the best choice.

--=20
David K=C3=A5gedal
