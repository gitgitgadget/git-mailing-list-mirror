From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: Documentation/user-manual.txt, asciidoc and "--" escapes
Date: Wed, 12 Nov 2008 01:04:45 +0100
Message-ID: <20081112000445.GB17662@diku.dk>
References: <ddb82bf60811061904t5defc492m80cd1b759674eb6@mail.gmail.com> <ddb82bf60811061909m6f8a7b72o4b03ebcde8b9d188@mail.gmail.com> <ddb82bf60811090044l43eb4bb1ga5a16718a4176c29@mail.gmail.com> <2c6b72b30811091052k77200785j722c8aed2beb7684@mail.gmail.com> <ddb82bf60811092338m3aad8041w20de23f18aa7d56e@mail.gmail.com> <20081110100757.GA12868@diku.dk> <ddb82bf60811100214j4246cf25yc1263c2ae8cd10fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Piotr Findeisen <piotr.findeisen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 01:06:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L03FI-00040V-Pm
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 01:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbYKLAEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Nov 2008 19:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbYKLAEt
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 19:04:49 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:50919 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881AbYKLAEt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 19:04:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id EF8BD52C365;
	Wed, 12 Nov 2008 01:04:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xZnBJ59+yMNO; Wed, 12 Nov 2008 01:04:45 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 9879B52C364;
	Wed, 12 Nov 2008 01:04:45 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 595E76DFD0A; Wed, 12 Nov 2008 01:02:59 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 7D95B39A355; Wed, 12 Nov 2008 01:04:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ddb82bf60811100214j4246cf25yc1263c2ae8cd10fc@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100698>

Piotr Findeisen <piotr.findeisen@gmail.com> wrote Mon, Nov 10, 2008:
> > This would also fix the usage of "--" in the manpages, e.g.
> >
> >        You've now initialized the working directory--you may notice=
 ...
> >
> > in gittutorial(7). On my setup, with "--" replaced with "=E2=80=94"=
, I get the
> > following nroff code:
>=20
> On my machine, make gittutorial.7 produces manpage that displays "--"
> in this place :)

At least you don't loose anything compared to the current behavior. ;)

> >        You've now initialized the working directory\(emyou may noti=
ce
>=20
> Anyway, this may be a good idea to use unambiguous "=E2=80=94" (thoug=
h people
> writing docs may be used to using "--" as a punctuation). I can run
> through the Documentation replacing "\w--\w" with m-dash, if you want=
=2E

I would like to see such a patch.

--=20
Jonas Fonseca
