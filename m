From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 3/4] Convert git_id() to the new id format
Date: Mon, 14 Jul 2008 09:07:39 +0200
Message-ID: <20080714070739.GG20751@diana.vm.bytemark.co.uk>
References: <20080713113853.18845.37686.stgit@localhost.localdomain> <20080713114047.18845.34899.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 09:08:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIIAw-00019S-Lw
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 09:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbYGNHHq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 03:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbYGNHHq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 03:07:46 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1558 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628AbYGNHHp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 03:07:45 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KII9r-0005vF-00; Mon, 14 Jul 2008 08:07:39 +0100
Content-Disposition: inline
In-Reply-To: <20080713114047.18845.34899.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88390>

On 2008-07-13 12:40:48 +0100, Catalin Marinas wrote:

> @@ -67,8 +64,8 @@ def func(parser, options, args):
>                  rev =3D strip_suffix('/', rev)
>                  if rev.endswith('/'):
>                      rev =3D strip_suffix('/', rev)
> -                rev1 =3D rev + '//bottom'
> -                rev2 =3D rev + '//top'
> +                rev1 =3D rev + 'HEAD^'
> +                rev2 =3D rev + 'HEAD'

This looks bogus. You probably want to s/HEAD// here.

I guess the test suite doesn't cover this? :-(

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
