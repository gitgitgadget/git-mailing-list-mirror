From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] git-am: Add --ignore-date option
Date: Fri, 23 Jan 2009 14:17:11 +0100
Message-ID: <20090123131711.GA11507@chistera.yi.org>
References: <7vwscm1nic.fsf@gitster.siamese.dyndns.org> <7vljt26fp9.fsf@gitster.siamese.dyndns.org> <46d6db660901221441q60eb90bdge601a7a250c3a247@mail.gmail.com> <20090123094529.6117@nanako3.lavabit.com> <20090123172646.6117@nanako3.lavabit.com> <alpine.DEB.1.00.0901231336080.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>,
	Christian MICHON <christian.michon@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 14:18:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQLvm-0007w3-KE
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 14:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759063AbZAWNRR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jan 2009 08:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759025AbZAWNRQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 08:17:16 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3275
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758966AbZAWNRO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 08:17:14 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 20630801BF94;
	Fri, 23 Jan 2009 14:17:13 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LQLuJ-00036W-EO; Fri, 23 Jan 2009 14:17:11 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901231336080.3586@pacific.mpi-cbg.de>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106881>

* Johannes Schindelin [Fri, 23 Jan 2009 13:38:34 +0100]:

> FWIW I have that problem in one of my workflows, and I do this:
> 	grep -v "^Date:" < $MBOX | git am

> Of course, this assumes that none of my commit messages has the strin=
g=20
> "Date:" at the beginning of the line...

In case you're interested:

    % formail -I 'Date' -s < $MBOX | git am

is robust against your assumption being wrong. (I realize ^Date: is not
very likely in commit messages, but I thought I'd mention nevertheless.=
)

Cheers,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
- Are you sure we're good?
- Always.
                -- Rory and Lorelai
