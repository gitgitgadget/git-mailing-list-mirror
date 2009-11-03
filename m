From: Milos Jakubicek <xjakub@fi.muni.cz>
Subject: Re: using merge subtree and move it..
Date: Mon, 2 Nov 2009 18:57:15 -0800 (PST)
Message-ID: <1257217035802-3936273.post@n2.nabble.com>
References: <ga4fho$5ib$1@ger.gmane.org> <48C61E1F.6000907@viscovery.net> <48C64911.4020202@posdata.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 03:57:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N59aY-00013T-VH
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 03:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595AbZKCC5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2009 21:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757616AbZKCC5L
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 21:57:11 -0500
Received: from kuber.nabble.com ([216.139.236.158]:37684 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757584AbZKCC5L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2009 21:57:11 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1N59a7-0005De-Q1
	for git@vger.kernel.org; Mon, 02 Nov 2009 18:57:15 -0800
In-Reply-To: <48C64911.4020202@posdata.co.kr>
X-Nabble-From: Milos Jakubicek <xjakub@fi.muni.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131941>




SungHyun Nam wrote:
>=20
>=20
> BTW, I have no idea how I can push 'local changes in subtree' to remo=
te.
> The 'Additional tips' in using-merge-subtree.txt said it is
> possible using subtree. But don't know how? Could someone show me
> a sample command/setup sequence?
>=20

I found out:=20
edit your .git/config file and in the [remote "remotename"]=C2=A0sectio=
n, copy
the "fetch =3D" line as "push =3D" line (with same content after "=3D")=
=2E Then by
"git push remotename" you'll just push the relevant subtree.
--=20
View this message in context: http://n2.nabble.com/using-merge-subtree-=
and-move-it-tp1076542p3936273.html
Sent from the git mailing list archive at Nabble.com.
