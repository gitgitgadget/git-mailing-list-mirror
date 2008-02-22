From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] Simple rename of top-most patch
Date: Fri, 22 Feb 2008 08:44:55 +0100
Message-ID: <20080222074455.GC6630@diana.vm.bytemark.co.uk>
References: <20080218140005.GA18668@diana.vm.bytemark.co.uk> <200802212242.51866.onno@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Onno Kortmann <onno@gmx.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 09:23:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSTC1-0000W0-P3
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 09:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbYBVIXG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 03:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbYBVIXF
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 03:23:05 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4104 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbYBVIXE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 03:23:04 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JSSaV-0001sP-00; Fri, 22 Feb 2008 07:44:55 +0000
Content-Disposition: inline
In-Reply-To: <200802212242.51866.onno@gmx.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74703>

On 2008-02-21 22:42:51 +0100, Onno Kortmann wrote:

> +    if len(args) =3D=3D 2:
> +        old, new=3Dargs
> +    elif len(args) =3D=3D 1:
> +        if not crt:
> +            raise CmdException, "No applied top patch to rename exis=
ts."
> +        old, [new]=3Dcrt, args

I think the style throughout StGit is to have spaces arond operators.
No biggie, though -- I'll fix it up.

> +    else: parser.error('incorrect number of arguments')

It looks strange without a line break here, especially since there are
line breaks in the if and elif branches. I'll fix this too if you
don't mind.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
