From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Allow renaming of the top-most branch by just calling stg rename <new-patch-name>
Date: Mon, 18 Feb 2008 15:00:05 +0100
Message-ID: <20080218140005.GA18668@diana.vm.bytemark.co.uk>
References: <200802172203.55533.onno@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Onno Kortmann <onno@gmx.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 15:01:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR6YG-0007qt-1P
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 15:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbYBROAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Feb 2008 09:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbYBROAZ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 09:00:25 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4803 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbYBROAY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 09:00:24 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JR6XN-0005mC-00; Mon, 18 Feb 2008 14:00:05 +0000
Content-Disposition: inline
In-Reply-To: <200802172203.55533.onno@gmx.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74290>

This is a good idea, I think.

On 2008-02-17 22:03:55 +0100, Onno Kortmann wrote:

> instead of stg rename <old> <new>. This is for example helpful for
> those people who always have a typo or two in their patch names.

Please follow the commit message conventions. That is, first one short
summary line, then a blank line and the rest of the commit message.
And a sign-off.

(Read git's Documentation/SubmittingPatches if you want the details.)

> +        args=3D[crt]+args
> +        out.start('Renaming top-most patch "%s" to "%s"' % (args[0],=
=20
> args[1]))

Please consider storing the patch names in two suitably named
variables, like this:

  if len(args) =3D=3D 1:
     old, [new] =3D crt, args
  elif len(args) =3D=3D 2:
     old, new =3D args

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
