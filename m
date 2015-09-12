From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Git Deployment using existing multiple environments
Date: Sat, 12 Sep 2015 12:55:46 +0200
Organization: gmx
Message-ID: <8797177dd247d4ef903603cbe6c57d7d@dscho.org>
References: <BAY180-W16B5F49FFD3614D666B232C25F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sukhwinder Singh <php_programmer_india@hotmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 12 12:55:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaiTK-00024y-FE
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 12:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474AbbILKzu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Sep 2015 06:55:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:63774 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751325AbbILKzt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 06:55:49 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MfAog-1ZHZ3Q2rIw-00Or1m; Sat, 12 Sep 2015 12:55:46
 +0200
In-Reply-To: <BAY180-W16B5F49FFD3614D666B232C25F0@phx.gbl>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:TQnxfK9xGfczqtFtRwkDxYrMiEAPbcDlODFwpmkOgEQVvttHQQw
 vZKlx8kXM52UxS5sR/4SX5amnDPl6jFRxsKQVBs44hgLFcn3Nea4o+xeoRalE1gZ3aLd0s1
 gsJDxp2Dds1GGGkfzeK0haVL//SJMVGpzPxJMGcBCHwZj78VoaoOJX1wOgdb5Rc8vqDOPrw
 gLcOPAtnWr7jVYxNDdO3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vzuPiaMdKjU=:FU/L9//aIGW5aqnySrx/Dn
 KMbssGDRjI28kDpgjBTjBPNfAo3B9fRKu5nmO7t23taedjtGM2IK28fME++x3J5zgr/+3iS0j
 wl9VuNQ08MWk46QU9sgcPPzw+H2IsmCtnXZ2KSGEGos5OtajCXHeXXCK/rF/V7c1O6FsoDafi
 OzdkK93jK+7UI0CRn1/8oJeTeWBbQHVhLJif9KIHASHNgDFvwvp2pNhVFRRDiDL7KqFI1/udI
 n8EaxAT0rj6ALNYU/PJbij0KcUyF9ueYtHhi4CcE7ZAHIKbk8+mfwhR+9F86lBlGVWwg+jM+t
 42hphLZD9SugRVSKUAbHVG628NkdzQARVAg3q+bZo+FEvNiCrm55HkUyUJTg3b8TLyJV8EMGC
 BVxUAUjLPk0zIIkS1AqhRUaaVbDUAiuigdCoD9swR/H8DawJhAb9YG/APQh0fepTRLU6OsoT5
 qyk/js1g6J5JI269xeeMrNehxeBBq4p43hRY7uGQHmw21wLVfuDkl8fsTLfuUGfehwEwbMjZl
 eff1V2BN527zVvfImWBPAKaXWmrCnoFtokYmPhwzymc5lS2O3sOBhKI3ruzXFgy407ygNgh81
 aIHZa4S2xJxNdu+u/3ifgmyOEk7FOqLAG6t46zIbZD9WdFWB0Eaao3d0MW+tB1inJ4NrqA+Hd
 H82ZvOjtzaQlXQx5EYx0tYjjhC19EfepgzXAtNW9VL9Tl8Fosy6RigYtTsLOqT1LmqU9C2yOs
 v8XAD9iIInkND0Fdhy0OqyVQnc1gJ6Crug3JqQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277724>

Hi,

On 2015-09-12 08:31, Sukhwinder Singh wrote:

> We already have 3-4 environments setup on our Windows servers without=
 Git
> and each environment already has code which is different from each
> other.
>=20
> There are three environments
> Live
> UAT
> Test (has the latest code)
>=20
>=20
> And then developers have their local copies.
>=20
> We write and test the code locally and manually move each point from
> one environment to other using merging software and test at each
> environment.
> Now we want to use git because manually moving the code is a lengthy
> process. Also as the developers have local copies, it is very
> difficult to manage code.
>=20
> Code is written locally by the team and then after testing locally it
> is first merged with "Test" environment code, then "UAT" and then,
> finally with "Live".
> So we have two concerns:
>=20
> There is different code already existing on these environments.
> Testing the code on each environment using the web server.
>=20
> What is the best way to go about it?=C2=A0As I am new to git more det=
ails
> will be helpful, like commands to use.

It seems you are not only looking for commands to use, but for a proper=
 workflow in which Git supports your work best.

The key is to define the roles in your flow first, and then identify th=
e optimal commands.

In your case, I figure that there are three "merge lords" or "merge lad=
ies", one for "Test", one for "UAT", one for "Live". And each of them n=
eeds to be notified when changes are ready to be merged, then merge the=
 changes.

If I was walking in your shoes, I would set up four repositories that e=
ach are owned by one of the "merge lords/ladies", or the developers, re=
spectively. The code would move from one to the next repository, trigge=
red by a notification, then being pulled into the environment, then tes=
ted, and if everything is okay, pushed into the next repository.

(Actually, you could do without the repository corresponding to the "Li=
ve" version, but it would be a nice record.)

However, this is just one possible suggestion. I would highly recommend=
 buying and reading the book "Git for Teams", as it has extensive cover=
age of different work flows, their strengths and their weaknesses.

Ciao,
Johannes
