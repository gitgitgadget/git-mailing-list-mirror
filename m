From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] Update bash completions to prevent unbound variable
	errors.
Date: Mon, 12 Jan 2009 21:40:30 +0100
Message-ID: <20090112204030.GA23327@chistera.yi.org>
References: <496BA0E4.2040607@tedpavlic.com> <200901121435.35547.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 21:42:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMTbl-0008K1-7D
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 21:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066AbZALUke convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 15:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754641AbZALUke
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 15:40:34 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3713
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbZALUkd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 15:40:33 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 728A7801C078;
	Mon, 12 Jan 2009 21:40:31 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LMTaI-00066y-J9; Mon, 12 Jan 2009 21:40:30 +0100
Content-Disposition: inline
In-Reply-To: <200901121435.35547.bss@iguanasuicide.net>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105378>

* Boyd Stephen Smith Jr. [Mon, 12 Jan 2009 14:35:35 -0600]:

> >The attached patch replaces things like

> >         if [ -z "$1" ]

> >with

> >         if [ -z "${1-}" ]

> That looks ugly to me.  Any reason we shouldn't just "set +u" at the =
top of=20
> the script?

`set +u` affects the shell globally, not just to the sourced file. If
you do that, you must be aware that you'll be preventing people from
running their shell in `set -u` mode. (Merely stating a fact here, not
giving any opinion.)

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
The problem I have with making an intelligent statement is that some
people then think that it's not an isolated occurrance.
                -- Simon Travaglia
