From: Josef Wolf <jw@raven.inka.de>
Subject: Re: Problems using perl's Git.pm module
Date: Fri, 3 Dec 2010 09:27:01 +0100
Message-ID: <20101203082701.GC26070@raven.wolf.lan>
References: <20101202114003.GA26070@raven.wolf.lan>
 <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 09:30:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POR25-0000Wv-Lp
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 09:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758436Ab0LCIaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 03:30:14 -0500
Received: from quechua.inka.de ([193.197.184.2]:43535 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243Ab0LCIaN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 03:30:13 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1POR1v-00035U-L6; Fri, 03 Dec 2010 09:30:11 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 6735976337; Fri,  3 Dec 2010 09:27:01 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162772>

On Thu, Dec 02, 2010 at 02:23:32PM +0100, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
> On Thu, Dec 2, 2010 at 12:40, Josef Wolf <jw@raven.inka.de> wrote:
> > I am trying to use perl's Git.pm module, but for some reason, it ke=
eps
> > bailing out:
> Why are you using it?

1. It is always available whenever git is available, so I don't need to
   search/install additional packages just to hack some scripts. If you
   have to support multiple distros/OS'es, it starts getting a PITA to
   find out what/how to install those additional packages.

2. Since it is used by the core developers, I assumed that it would be
   more robust than some third-party wrappers.

3. Since it is bundled with git, I'd not expect any version mismatches.
   With a third-party wrapper, version mismatches are much more likely.

> Couldn't you use one of the Perl Git wrappers on the CPAN?

Which one would you suggest?
