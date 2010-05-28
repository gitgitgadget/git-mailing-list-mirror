From: =?iso-8859-1?Q?Ren=E9_Moser?= <mail@renemoser.net>
Subject: cvs update vs. git pull
Date: Fri, 28 May 2010 11:21:12 +0200 (CEST)
Message-ID: <d876ae6b75ab8d9debe5b97f84a4386a.squirrel@resmo.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 28 11:21:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHvki-00009u-MT
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 11:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629Ab0E1JVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 05:21:12 -0400
Received: from host-194.50.176.240.colo-4.net ([194.50.176.240]:53241 "EHLO
	ns1.resmo.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893Ab0E1JVK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 05:21:10 -0400
Received: from resmo.ch (localhost.localdomain [127.0.0.1])
	by ns1.resmo.ch (Postfix) with ESMTP id 5806284679D
	for <git@vger.kernel.org>; Fri, 28 May 2010 11:21:12 +0200 (CEST)
Received: from 83.144.242.220
        (SquirrelMail authenticated user moserre)
        by resmo.ch with HTTP;
        Fri, 28 May 2010 11:21:12 +0200 (CEST)
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147920>

Hi

I use git since a while for my own projects (how surprise).

The company I work for still uses a CVS(nt), and this sucks, time to
changed that. We have a use case we often have problems with. If git wo=
uld
solve this problem, I would really have a good arg for the managers.

The codebase managed by CVS is quite huge and therefore we have daily a=
nd
nightly builds.

One problem we have is, that if there is a commit to cvs while the cvs
update of the build job is running (and this takes 20 minutes), then we
get some inconsistence, the build will fail.

So the question is, if we would use git, this inconsistence would not b=
e
possible because the git pull will get the state of the sha1. Right?

Thanks in advance for your clearification.

Regards
Ren=E9
