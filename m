From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Questions about branches in git
Date: Fri, 29 Jan 2010 11:07:55 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1001291106140.25954@ds9.cixit.se>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com> <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Linck <mgl@absolute-performance.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 11:08:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nanlo-0003P2-1Q
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 11:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856Ab0A2KIA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 05:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756800Ab0A2KIA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 05:08:00 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:55029 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755946Ab0A2KH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 05:07:59 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o0TA7uFI028383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Jan 2010 11:07:56 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o0TA7uwd028379;
	Fri, 29 Jan 2010 11:07:56 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Fri, 29 Jan 2010 11:07:56 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138305>

Michael Witten:

> However, I've been thinking for a while that it would be useful to ha=
ve=20
> =FCbercommits (they don't exist) that are treated like single commits=
 but=20
> that actually encapsulate multiple continguous commits.

Your "=FCbercommits" can easily be faked by wrapping the project up in =
a git=20
submodule. The supermodule (which would just contain one entry -- the=20
project you are "=FCbercommit-tracking") would then contain one single =
commit=20
for each set of commits you wish to publish.

I'm not sure such a work-flow makes much sense, though. Annotated tags =
are=20
probably a better idea.

--=20
\\// Peter - http://www.softwolves.pp.se/
