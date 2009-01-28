From: Zabre <427@free.fr>
Subject: Re: (beginner) git rm
Date: Wed, 28 Jan 2009 12:42:02 -0800 (PST)
Message-ID: <1233175322729-2234796.post@n2.nabble.com>
References: <1233137498146-2231416.post@n2.nabble.com> <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se> <1233140751523-2231622.post@n2.nabble.com> <49804385.908@dbservice.com> <1233144045221-2231849.post@n2.nabble.com> <49804D41.3010801@dbservice.com> <1233166992184-2233892.post@n2.nabble.com> <20090128201727.GD7503@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 21:45:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSHHx-0001h4-Uw
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 21:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467AbZA1UmH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jan 2009 15:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756300AbZA1UmG
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 15:42:06 -0500
Received: from kuber.nabble.com ([216.139.236.158]:57037 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756293AbZA1UmD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 15:42:03 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LSHEY-0001C6-Nn
	for git@vger.kernel.org; Wed, 28 Jan 2009 12:42:02 -0800
In-Reply-To: <20090128201727.GD7503@atjola.homenet>
X-Nabble-From: 427@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107573>



Bj=C3=B6rn Steinbrink wrote:
>=20
> The "git checkout -- d.txt" is also a valid command, but that restore=
s
> the file from the index.
>=20
> git checkout -- paths
> 	=3D=3D> Copy "paths" from the index to the working tree
>=20
> git checkout <tree-ish> -- paths
> 	=3D=3D> Copy "paths" from the tree-ish to the index and working tree
>=20
> So, for "rm d.txt", a plain "git checkout -- d.txt" would also do the
> trick, as d.txt is still in the index. But your "git rm d.txt" also
> removed the file from the index, and thus that checkout does nothing.
> But "git checkout HEAD -- d.txt" works, as it gets the file from HEAD
> and puts it into the index and working tree.
>=20

This is enlightening, thank you very much!
(I knew I would love git more and more)

Oh just one (probably stupid) thing : <tree-ish> does represent a direc=
tory
being the root of a tree of folders (which has been added to the index)=
,
does it?
This is the way I understand it at the moment. It must be a convention =
I
don't know just yet. (I need to investigate on this)
--=20
View this message in context: http://n2.nabble.com/%28beginner%29-git-r=
m-tp2231416p2234796.html
Sent from the git mailing list archive at Nabble.com.
