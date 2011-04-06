From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: blobs (once more)
Date: Wed, 6 Apr 2011 18:42:35 +0200
Message-ID: <20110406164235.GB17662@jpl.local>
References: <BANLkTim3kg1ycGkgWsqaZiqMY9LTKV6DBw@mail.gmail.com>
 <vpqmxk3prki.fsf@bauges.imag.fr>
 <41F80411E3CC644A844E6BED6E472FD91196D0CD30@ESESSCMS0363.eemea.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andrey Devyatkin <andrey.devyatkin@ericsson.com>
To: Peter =?iso-8859-1?Q?J=F6nsson?= P <peter.p.jonsson@ericsson.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 19:09:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7WEO-0002UQ-Fd
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 19:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab1DFRJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 13:09:19 -0400
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:60005 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab1DFRJS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 13:09:18 -0400
X-Greylist: delayed 1600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Apr 2011 13:09:18 EDT
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 36127EB4E6
	for <git@vger.kernel.org>; Wed,  6 Apr 2011 18:42:37 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmgWAPqWnE1T46eEPGdsb2JhbACJE48ajUoLAQEBATcyiHm5K4VsBA
X-IronPort-AV: E=Sophos;i="4.63,311,1299452400"; 
   d="scan'208";a="180206285"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb1.telenor.se with ESMTP; 06 Apr 2011 18:42:36 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id AC69E422D0; Wed,  6 Apr 2011 18:42:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <41F80411E3CC644A844E6BED6E472FD91196D0CD30@ESESSCMS0363.eemea.ericsson.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170991>

On Wednesday, April 06, 2011 at 13:12 CEST,
     Peter J=F6nsson P <peter.p.jonsson@ericsson.com> wrote:

> How about using Google's repo-tool instead of submodules? Is that
> a better solution if one really needs to keep binaries together
> (in some way) with the source code?

I don't know if Repo vs. submodules is the most interesting choice;
they're both relying on plain gits for the storage. We stored large
binaries in gits for a while too, but for us the major hassle was
that it was killing our servers. When too many of the few hundreds of
developers were fetching multi-GB repos the 8-16 core 24 GB RAM server
(don't know the exact specs at the time) was really down on its knees.
Now, we were using JGit (via Gerrit) and I'm sure tuning could've helpe=
d
-- as well as just replicating the data and spreading the load across
multiple servers -- but don't forget this factor when choosing the tool=
=2E

> We are starting to prototype Git and since we need to distribute
> cross-compilers with the code it would be nice to keep it in a
> separate repo. Currently we are _heavy_ ClearCase users (oh the
> horror) with many bad old habits that we are trying to break :)

We've been there too.

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
