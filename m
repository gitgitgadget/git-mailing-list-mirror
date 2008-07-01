From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [RFC/PATCH 7/7] Documentation formatting and cleanup
Date: Tue, 01 Jul 2008 15:09:32 +0200
Message-ID: <486A2C8C.5050204@free.fr>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu> <Pine.GSO.4.62.0806301730230.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jon Loeliger <jdl@jdl.com>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Tue Jul 01 15:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDfca-0005gu-S9
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 15:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175AbYGANJQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2008 09:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755137AbYGANJQ
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 09:09:16 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:42022 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753815AbYGANJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 09:09:15 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id D2C4A12B6B4;
	Tue,  1 Jul 2008 15:09:13 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 3B41012B6CE;
	Tue,  1 Jul 2008 15:09:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <Pine.GSO.4.62.0806301730230.7190@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87037>

Jonathan Nieder a =E9crit :
> [184 KB patch online at
> <http://home.uchicago.edu/~jrnieder/20080701-git-doc-style.txt>]
>=20
> Following what appears to be the predominant style, format
> names of commands and commandlines both as `teletype text`.
>=20
> While we're at it, add articles ("a" and "the") in some
> places, italicize the name of the command in the manual page
> synopsis line, and add a comma or two where it seems appropriate.
>=20
> Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
>=20
> 	1) I am using `teletype text` both for command names and
> 	   for command lines. Probably I should be using italics
> 	   for the command names.

You did a lot of:

> -replaced; you need to use a tool such as linkgit:git-diff[1] or the =
"pickaxe"
> +replaced; you need to use a tool such as `git-diff` or the "pickaxe"

Are those kind of changes really an improvement?

Also, in Documentation/gitdiffcore.txt, you did:

> -These are applied in sequence.  The set of filepairs git-diff-\*
> +These are applied in sequence.  The set of filepairs `git-diff-*`

but the file does not compile, now.

Olivier.
