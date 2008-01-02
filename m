From: =?ISO-8859-1?Q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>
Subject: Re: Git and securing a repository
Date: Wed, 02 Jan 2008 07:04:09 -0300
Message-ID: <477B6199.6070601@advancedsl.com.ar>
References: <477B39B5.5010107@advancedsl.com.ar> <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>,
	git@vger.kernel.org
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Jan 02 10:03:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9zV6-000332-R1
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 10:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753088AbYABJCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 04:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbYABJCV
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 04:02:21 -0500
Received: from echunga.terra.com ([66.119.66.230]:51464 "EHLO
	echunga.terra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbYABJCU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 04:02:20 -0500
Received: from feluga.terra.com (feluga.terra.com [66.119.66.183])
	by echunga.terra.com (Postfix) with ESMTP id A8DC59540CD;
	Wed,  2 Jan 2008 04:02:19 -0500 (EST)
X-Terra-Karma: 0%
X-Terra-Hash: 5b899ef6120b051a92057c3d060cc6d6
Received-SPF: none (feluga.terra.com: 66.119.66.183 is neither permitted nor denied by domain of advancedsl.com.ar) client-ip=66.119.66.183; envelope-from=ggarra@advancedsl.com.ar; helo=[192.168.1.3];
Received: from [192.168.1.3] (unknown [201.255.33.238])
	(authenticated user ggarra@advancedsl.com.ar)
	by feluga.terra.com (Postfix) with ESMTP id 9179B2E293D;
	Wed,  2 Jan 2008 04:02:18 -0500 (EST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69463>

=46elipe Balbi wrote:
>=20
> it's easy on the full repository case, create different groups and
> share git repositories by groups, after that chmod o-rwx -R
> /path/to/repository.git.
>=20

Thanks.  I'll admit what you describe is somewhat discouraging, as what=
=20
you are just describing is just managing user accounts or groups on the=
=20
underlying OS.  That does not extend well to placing code on the net an=
d=20
has a bunch of administrative headaches.

I was really looking for a permission based system that was part of git=
=20
itself (and thus more portable and easier to admin), and not the OS.=20
Something akin to what perforce or even CVS can do.


--=20
Gonzalo Garramu=F1o
ggarra@advancedsl.com.ar

AMD4400 - ASUS48N-E
GeForce7300GT
Xubuntu Gutsy
