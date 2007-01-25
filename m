From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [PATCH] make --upload-pack option to git-fetch configurable
Date: Thu, 25 Jan 2007 05:53:35 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070125045335.GB11397@cepheus>
References: <20070116150259.GA2439@cepheus> <Pine.LNX.4.63.0701161614070.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070116162645.GA18894@informatik.uni-freiburg.de> <20070116200847.GB29100@spearce.org> <Pine.LNX.4.63.0701162129430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070117164410.GA5950@cepheus> <7vps9dsgn0.fsf@assigned-by-dhcp.cox.net> <20070118071723.GB3245@informatik.uni-freiburg.de> <20070125044539.GA11397@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 05:53:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9wcH-0005bc-MK
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 05:53:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933224AbXAYExj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 Jan 2007 23:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933226AbXAYExj
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 23:53:39 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:43171 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933224AbXAYExi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jan 2007 23:53:38 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1H9wcD-0001o0-9Y; Thu, 25 Jan 2007 05:53:37 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l0P4rY6e001370;
	Thu, 25 Jan 2007 05:53:34 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l0P4rYNY001369;
	Thu, 25 Jan 2007 05:53:34 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <20070125044539.GA11397@cepheus>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37706>

Hello,

> +if test -z "$exec"
> +then
> +	# No command line override and we have configuration for the remote=
=2E
> +	exec=3D"--upload-pack=3D$(get_uploadpack $1)"
> +fi
I forgot to mention that this needs the patches

	rename --exec to --upload-pack for fetch-pack and peek-remote
		(Message-ID: <20070123082017.GA10007@cepheus>)

and

	ls-remote and clone: accept --upload-pack=3D<path> as well.
		by Junio  (Message-ID: <7vlkjunlgk.fsf@assigned-by-dhcp.cox.net>)

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

dd if=3D/proc/self/exe bs=3D1 skip=3D1 count=3D3 2>/dev/null
