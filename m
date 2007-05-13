From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT PATCH v2] Document patch syntax.
Date: Sun, 13 May 2007 15:03:54 +0200
Message-ID: <20070513130354.GG16903@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070512185919.26101.3956.stgit@gandelf.nowhere.earth> <20070512204352.GE28039@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun May 13 15:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnDlC-0000bZ-Kv
	for gcvg-git@gmane.org; Sun, 13 May 2007 15:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759603AbXEMNFI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 09:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759605AbXEMNFI
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 09:05:08 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:34053 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759603AbXEMNFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 09:05:06 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1E7C85EFB9;
	Sun, 13 May 2007 15:05:04 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 091341F161; Sun, 13 May 2007 15:03:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070512204352.GE28039@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47146>

On Sat, May 12, 2007 at 10:43:52PM +0200, Karl Hasselstr=F6m wrote:
> On 2007-05-12 20:59:30 +0200, Yann Dirson wrote:
>=20
> > Acked-by: Karl Hasselstr?m <kha@treskal.com>
>=20
> Your mail headers say
>=20
>   Content-Type:   text/plain; charset=3Dutf-8
>   Content-Transfer-Encoding: QUOTED-PRINTABLE
>=20
> but the body contains
>=20
>   Acked-by: Karl Hasselstr=3DF6m <kha@treskal.com>
>=20
> which is QP-encoded latin1, not utf8. (It's an illegal utf8 byte
> sequence, which is why it showed up as a question mark in my MUA.)

Right, I have seen that in gitk as well.  My LC_CTYPE is "french",
which is an iso8859-1 locale.  I have not touched i18n.commitEncoding,
which should then default to utf-8.  Shouldn't a conversion to utf8
have happenned ?  Things may be made different from standard git,
since this commit was handled by stgit - we may have something to fix
here :)


> s/refered/referred/. I missed this the first time -- sorry.

OK

Jeff wrote:
>Karl's version is more correct (but your version might be used by many
>native speakers). The second half of the sentence is correct because
>'must' conjugates the same for singular and plural use; however, it
>might be more clear to say "...short name, each of which must be uniqu=
e
>in the stack."

OK as well

Best regards,
--=20
Yann.
