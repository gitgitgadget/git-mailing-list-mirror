From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: Re: I just pulled and built 'next'...
Date: Tue, 9 Jan 2007 18:35:01 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070109173501.GA3732@cepheus>
References: <E1H3uc2-0004m1-Ua@think.thunk.org> <7vvejhwa6g.fsf@assigned-by-dhcp.cox.net> <20070108210002.GA15121@thunk.org> <20070109032124.GA1904@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 18:35:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Ksm-00082s-1e
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 18:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbXAIRf3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 9 Jan 2007 12:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbXAIRf2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 12:35:28 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:57235 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932292AbXAIRf1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jan 2007 12:35:27 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H4Ksg-0006k7-Fa; Tue, 09 Jan 2007 18:35:26 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l09HZIbA020646;
	Tue, 9 Jan 2007 18:35:18 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l09HZ5o6020645;
	Tue, 9 Jan 2007 18:35:05 +0100 (MET)
To: "Shawn O. Pearce" <spearce@spearce.org>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070109032124.GA1904@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36379>

Hello,

Shawn O. Pearce wrote:
>   $ git rev-list v1.5.0-rc0..next | wc -l
>   687
>   $ git rev-list v1.4.4.4..next | wc -l
>   1051
>=20
> So what about doing Junio's suggestion of going by topology and
> coming up with the possible set of tags (v1.5.0-rc0 and v1.4.4.4
> right now), and if more than one is found compute the number of
> commits between each tag and the requested revision, and take the
> tag that has a smallest number of commits?
One scenario where this will fail is when a bugfix is commited on top o=
f
v1.4.4.4 and then is merged into v1.5.0-rc0+gabcdef.

Just my 0.02$.

Uwe

--=20
Uwe Kleine-K=F6nig

exit vi, lesson III:
: x ! <CR>

NB: may write current file
