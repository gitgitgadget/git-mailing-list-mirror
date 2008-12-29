From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] t7500-commit.sh: do not call test_set_editor
	unnecessarily, it's confusing
Date: Mon, 29 Dec 2008 10:52:20 +0100
Message-ID: <20081229095220.GA26942@chistera.yi.org>
References: <1230542658-9758-1-git-send-email-dato@net.com.org.es> <7vmyefco11.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 10:53:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHEoi-0006Br-H7
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 10:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486AbYL2JwX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2008 04:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbYL2JwX
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 04:52:23 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:1192
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbYL2JwX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 04:52:23 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id A35F38027934;
	Mon, 29 Dec 2008 10:52:21 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LHEnM-00072i-L9; Mon, 29 Dec 2008 10:52:20 +0100
Content-Disposition: inline
In-Reply-To: <7vmyefco11.fsf@gitster.siamese.dyndns.org>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104092>

* Junio C Hamano [Mon, 29 Dec 2008 01:46:02 -0800]:

> Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> > I was reading this test case, and it took a small bit to figure out=
 the
> > editor was not being used at all. I hope there was no hidden reason=
 for
> > it to be there, and it can go away.

> That 'zort' came from 1320857 (builtin-commit: fix --signoff, 2007-11=
-11),
> and I _think_ it is trying to make sure that presense of "-F -" makes=
 the
> editor not to trigger.

Hm. Well, if that is true, then IMHO it should be in a /separate/ test
case, for clarity. Probably in "message from stdin" test from t7501.

That's of course just my opinion, and I'll accept if you prefer to
maintain it the way it is now. I also volunteer to move it to t7501 if
that's what you prefer, just let me know.

Thanks,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
                              Listening to: Justin Nozuka - I'm In Peac=
e
