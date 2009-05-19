From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH v2] Add a --set-tree flag to stg push
Date: Tue, 19 May 2009 12:27:43 +0200
Message-ID: <20090519102743.GA11135@diana.vm.bytemark.co.uk>
References: <20090519072512.GA8451@diana.vm.bytemark.co.uk> <20090519093506.22242.59442.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue May 19 12:28:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6MYY-0000VS-VP
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 12:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbZESK1t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 06:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbZESK1t
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 06:27:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:42743 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbZESK1s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 06:27:48 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1M6MXv-000303-00; Tue, 19 May 2009 11:27:43 +0100
Content-Disposition: inline
In-Reply-To: <20090519093506.22242.59442.stgit@krank>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119512>

On 2009-05-19 11:35:48 +0200, David K=E5gedal wrote:

> +    opt('--set-tree', action =3D 'store_true',
> +        short =3D 'Push the patch with the original tree', long =3D =
"""
> +        Push the patches, but don't perform a merge. Instead, the
> +        resulting tree will be identical to the tree that the patch
> +        previously created. This can be useful when splitting a patc=
h

Paragraph break after "created"?

> +        by first popping the patch and creating a new patch with som=
e
> +        of the changes. Pushing the original patch with --set-tree
> +        will avoid conflicts and only the remaining changes will be =
in

The long description is fed to asciidoc, which will translate -- to an
en dash if I recall correctly. The long descriptions of other
commands' flags enclose flags in single quotes.

> +        the patch.
> +        """)

Unnecessary line break.

Apart from those nitpicks,

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
