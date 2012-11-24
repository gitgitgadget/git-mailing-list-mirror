From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] Add documentation on how to integrate commands.
Date: Sat, 24 Nov 2012 10:11:27 -0500
Message-ID: <20121124151127.GA24459@padd.com>
References: <20121124122333.BAD7B4065F@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 16:11:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcHOV-0007gi-Fa
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 16:11:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359Ab2KXPLc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Nov 2012 10:11:32 -0500
Received: from honk.padd.com ([74.3.171.149]:58657 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab2KXPLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2012 10:11:31 -0500
Received: from arf.padd.com (unknown [50.55.150.96])
	by honk.padd.com (Postfix) with ESMTPSA id 5AD3CE9A;
	Sat, 24 Nov 2012 07:11:30 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id ADAA9276F8; Sat, 24 Nov 2012 10:11:27 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20121124122333.BAD7B4065F@snark.thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210323>

esr@thyrsus.com wrote on Sat, 24 Nov 2012 07:23 -0500:
> +=3D=3D Integrating a command =3D=3D
> +
> +Here are the things you need to do when you want to merge a new=20
> +subcommand into the git tree.
> +
> +1. Append your command name to one of the variables BUILTIN_OBJS,
> +EXTRA_PROGRAMS, SCRIPT_SH, SCRIPT_PERL or SCRIPT_PYTHON.
> +
> +2. Drop its test in the t directory.
> +
> +That's all there is to it.

Nice start.  A few other details; I recently did this for git-p4
(python).

=2Egitignore: ignore the auto-generated script, e.g. when
git-foo.py is built into git-foo.

INSTALL: note language requirements if odd (see python section)

command-list.txt: categorization of commands for git(1) etc.

RelNotes: Junio generally does this.


Also please read Documentation/technical/api-builtin.txt to
see how to add a built-in command.  It also has comments that
are identical for both built-in and stand-alone command. =A0Could
be that your text would better go near or with that one, as perhaps
api-command.txt.

		-- Pete
