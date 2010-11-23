From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: bug: unexpected output for "git st" + suggestion
Date: Tue, 23 Nov 2010 13:43:11 +0100
Message-ID: <1290516191.21750.17.camel@isis.agematis.loc>
References: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 13:43:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKsDi-0002KF-19
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 13:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab0KWMna convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 07:43:30 -0500
Received: from lo.gmane.org ([80.91.229.12]:56189 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab0KWMna convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 07:43:30 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PKsDY-0002DL-Py
	for git@vger.kernel.org; Tue, 23 Nov 2010 13:43:28 +0100
Received: from 82.138.94.34 ([82.138.94.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 13:43:28 +0100
Received: from sylvain by 82.138.94.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 13:43:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 82.138.94.34
In-Reply-To: <AANLkTimdKoGHapMTrA-bf_mEyMAEiiM0ALvLbZX8QJpv@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161951>

Hi,

"st" does not exist in git. You have to create an alias yourself by
doing this :

$ git config --global --add alias.st status

Regards

On Tue, 2010-11-23 at 13:23 +0100, Tarek Ziad=C3=A9 wrote:
> Hello,
>=20
> I am new to Git and I tried to run "git st"
>=20
> I have found one small bug: "status" is not listed in the help screen
> Git displays in that case.
>=20
> $ git st
> git: 'st' is not a git command. See 'git --help'.
>=20
> Did you mean one of these?
> 	reset
> 	stage
> 	stash
>=20
>=20
> I also have a suggestion: I was looking for the way to report that bu=
g
> by visiting http://git-scm.com/ and looking for the bug tracker.
> Someone eventually explained to me on the IRC channel that I had to
> post a mail here. I would suggest making it clear on how to report
> bugs on the project's website. Maybe under  "Got a question" /
> "Email".
>=20
> Cheers
> Tarek
>=20
