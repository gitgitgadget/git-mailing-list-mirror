From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] prompt: fix show upstream with svn and zsh
Date: Wed, 22 May 2013 01:36:17 +0200
Message-ID: <20130521233617.GG30969@goldbirke>
References: <1369169667-25166-1-git-send-email-t.gummerer@gmail.com>
 <20130521224119.GF30969@goldbirke>
 <CAMP44s1cbO-xzUAHR4THz4MPdqxY6SHG7uf_da_OM8YCDbTi+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 01:36:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uew6g-0006td-G4
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 01:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab3EUXge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 May 2013 19:36:34 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:55042 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972Ab3EUXge (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 19:36:34 -0400
Received: from localhost6.localdomain6 (f051105197.adsl.alicedsl.de [78.51.105.197])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MgaVX-1Urwdp1wQh-00Niis; Wed, 22 May 2013 01:36:18 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s1cbO-xzUAHR4THz4MPdqxY6SHG7uf_da_OM8YCDbTi+A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:4aPE9sfjHXak7kcOsY66XTjPT0UWLXMYe7V/OD1vGEa
 LTMJ2cF8p0c3fn2JJJyg4vaQ75241oaBxQKBxQyvAVNLzYOlYK
 ImJ5VlDeS4N5JgLljP8SToNiXTq8T1XTfFY8KolcK01LL+S12d
 ib5VOiZANILykrStJmJ+D60BqcZebW0t/gGoILIqQ+lJlHDuBI
 RQFy8E4Gk5E5FcYKx1jKsdYymRJY1VNhMM0yaW3gwHxNa4IDI5
 10uakp37Iwu6xxEXovHZvnySg8CX07tjYewC4gs1I3AHPp1t1t
 bpbM3GUKRbueAj6tnWrm75CTbsUHNKsRc4UZd55glqPymuSIui
 +ueJl4CS6YNH6TkmLbObewOpjsxGRhrn4K3spb4vo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225096>

On Tue, May 21, 2013 at 06:04:35PM -0500, Felipe Contreras wrote:
> On Tue, May 21, 2013 at 5:41 PM, SZEDER G=E1bor <szeder@ira.uka.de> w=
rote:
>=20
> > On Tue, May 21, 2013 at 10:54:27PM +0200, Thomas Gummerer wrote:
> >> Currently the __git_ps1 git prompt gives the following error with =
a
> >> repository converted by git-svn, when used with zsh:
> >>
> >>          __git_ps1_show_upstream:19: bad pattern: svn_remote[
> >>
> >> This was introduced by 6d158cba (bash completion: Support "diverge=
nce
> >> from upstream" messages in __git_ps1), when the script was for bas=
h
> >> only.  Make it compatible with zsh.
> >
> > What is the actual cause of this problem/incompatibility and how/wh=
y do
> > these changes fix it?
>=20
> I think the commit message makes that very clear.

If that were the case I wouldn't have asked in the first place.

Hth,
G=E1bor
