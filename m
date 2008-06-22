From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 4/4] Remove the applied/unapplied commands
Date: Sun, 22 Jun 2008 18:13:41 +0200
Message-ID: <20080622161341.GD4468@diana.vm.bytemark.co.uk>
References: <20080619214023.27794.97039.stgit@localhost.localdomain> <20080619214233.27794.98487.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 18:15:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KASDk-00017h-6z
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 18:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbYFVQNt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jun 2008 12:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbYFVQNt
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 12:13:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1568 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbYFVQNs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 12:13:48 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KASCD-0001Oj-00; Sun, 22 Jun 2008 17:13:41 +0100
Content-Disposition: inline
In-Reply-To: <20080619214233.27794.98487.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85786>

On 2008-06-19 22:42:33 +0100, Catalin Marinas wrote:

> This patch moves the applied/unapplied functionality to the 'series'
> command via the corresponding options.

Nice.

>             make_option('-a', '--all',
>                         help =3D 'show all patches, including the hid=
den ones',
>                         action =3D 'store_true'),
> +           make_option('--applied',
> +                       help =3D 'show the applied patches only',
> +                       action =3D 'store_true'),
> +           make_option('--unapplied',
> +                       help =3D 'show the unapplied patches only',
> +                       action =3D 'store_true'),
>             make_option('--hidden',
>                         help =3D 'show the hidden patches only',
>                         action =3D 'store_true'),

Maybe some logic to prohibit the use of more than one of these at
once? The current logic is kind of arbitrary.

Also, we should perhaps invent good single-letter abbreviations for
these presumably rather common flags. -a is taken; -A and -U perhaps?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
