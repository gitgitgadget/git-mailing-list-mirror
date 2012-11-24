From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Add documentation on how to integrate commands.
Date: Sat, 24 Nov 2012 10:23:09 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121124152309.GA31679@thyrsus.com>
References: <20121124122333.BAD7B4065F@snark.thyrsus.com>
 <20121124151127.GA24459@padd.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 16:25:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcHc9-0000SD-6t
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 16:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359Ab2KXPYC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Nov 2012 10:24:02 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:36220
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab2KXPYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2012 10:24:01 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 870324065F; Sat, 24 Nov 2012 10:23:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121124151127.GA24459@padd.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210324>

Pete Wyckoff <pw@padd.com>:
> Nice start.  A few other details; I recently did this for git-p4
> (python).
>=20
> .gitignore: ignore the auto-generated script, e.g. when
> git-foo.py is built into git-foo.
>=20
> INSTALL: note language requirements if odd (see python section)
>=20
> command-list.txt: categorization of commands for git(1) etc.
>=20
> RelNotes: Junio generally does this.
>=20
>=20
> Also please read Documentation/technical/api-builtin.txt to
> see how to add a built-in command.  It also has comments that
> are identical for both built-in and stand-alone command. =A0Could
> be that your text would better go near or with that one, as perhaps
> api-command.txt.

Good points.  I will submit a revised patch later today.
--=20
		<a href=3D"http://www.catb.org/~esr/">Eric S. Raymond</a>
