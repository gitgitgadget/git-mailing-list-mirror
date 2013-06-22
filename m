From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/4] t9903: add tests for git-prompt pcmode
Date: Sat, 22 Jun 2013 15:06:04 +0200
Message-ID: <20130622130604.GK20052@goldbirke>
References: <cover.1371780085.git.erdavila@gmail.com>
 <3dd104f19a995081d8c8bf89bc9e33052077e052.1371780085.git.erdavila@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	artagnon@gmail.com, s.oosthoek@xs4all.nl, gitster@pobox.com
To: "Eduardo R. D'Avila" <erdavila@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 15:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqNWO-00067z-IJ
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 15:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327Ab3FVNGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Jun 2013 09:06:08 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:64937 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674Ab3FVNGH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 09:06:07 -0400
Received: from localhost6.localdomain6 (f051195150.adsl.alicedsl.de [78.51.195.150])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MUTsx-1UhtCp2CTz-00R0bS; Sat, 22 Jun 2013 15:06:04 +0200
Content-Disposition: inline
In-Reply-To: <3dd104f19a995081d8c8bf89bc9e33052077e052.1371780085.git.erdavila@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:IFG8V18UyM2ZfKBtvNdVWESf31CUYiGmV22lMPbAR4x
 USL2jRdXfXar9H9B0+bmBQyQ6SBeuR38dKPEPVQBr9W4qbUEay
 xy1s6v+citwxKv7iFvBGrd6Nxq/phvhGawJhuLmFIZXH+zdCV+
 V48BAVre9W2/cV+hqL1X8gndmL4M/WhhZcQfKeE1P7l27z/mis
 tmpgWNymaZVWb5QKfnQOW590m01sjyzlQRM4R5FMnsocCZwQZs
 W7b9es7sU4BJeTOpOkqztj7q6OhTEDefmIHn2fZolWPAbhMgGg
 jBxaTnvinrgMxXmFfBO1abG0AGeyqDaTBvvrBCTqXgiDyx1TqJ
 VD1tDuZzqVg8TckeKiHJp7WlaxlXRfQNO+vPad3Cw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228705>

Hi,

On Thu, Jun 20, 2013 at 11:25:26PM -0300, Eduardo R. D'Avila wrote:
> git-prompt.sh lacks tests for PROMPT_COMMAND mode.
>=20
> Add tests for:
> * pcmode prompt without colors
> * pcmode prompt with colors for bash
> * pcmode prompt with colors for zsh
>=20
> Having these tests enables an upcoming refactor in
> a safe way.
>=20
> Signed-off-by: Eduardo R. D'Avila <erdavila@gmail.com>

I doubt the value of separate tests for zsh.  They might make sense as
long as there are different code paths for doing coloring for the two
shells, but after your refactorization in 2/4 there is only one common
block of if statements, which is already thoroughly excercised by your
tests for bash, making the separate tests for zsh redundant.


G=E1bor
