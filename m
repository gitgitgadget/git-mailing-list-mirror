From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: Re: specify charset for commits
Date: Thu, 21 Dec 2006 20:11:41 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061221191141.GB27072@informatik.uni-freiburg.de>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de> <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de> <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 20:12:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxTKp-0006vX-Bz
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 20:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423039AbWLUTLr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 21 Dec 2006 14:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423040AbWLUTLr
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 14:11:47 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:59906 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423039AbWLUTLq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Dec 2006 14:11:46 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1GxTKS-0002Vk-P1; Thu, 21 Dec 2006 20:11:44 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id kBLJBfB2027486;
	Thu, 21 Dec 2006 20:11:41 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id kBLJBfwT027485;
	Thu, 21 Dec 2006 20:11:41 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35082>

Junio C Hamano wrote:
> Alexander Litvinov <litvinov2004@gmail.com> writes:
>=20
> > May we can add new header into commit with commit text encoding ?
>=20
> I do not think we want to change the commit header, nor we would
> want to re-encode, but I can see two possible improvements:
>=20
>  (1) git-am should default to -u; this was suggested on the list
>      long time ago, but is an incompatible change.  v1.5.0 we
>      can afford to be incompatible to make it more usable and
>      safer.
>=20
>  (2) update commit-tree to reject non utf-8 log messages and
>      author/committer names when i18n.commitEncoding is _NOT_
>      set, or set to utf-8.
>=20
>      Maybe later we can use encoding validation routines for
>      other encodings by checking i18n.commitEncoding, but at the
>      minimum the above would be safe enough for recommended UTF-8
>      only cases.
As I only want to use UTF-8 both suggestions are fine for me.

Is there a generic way to check an encoding?  (I don't know if there is
an encoding that can encode everything.  If so, we could use iconv -f
$enc -t superencoding.  Until now I thought UTF-8 can do, but in the
post Johannes pointed out, you (Junio) implyed that it cannot.)

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

dd if=3D/proc/self/exe bs=3D1 skip=3D1 count=3D3 2>/dev/null
