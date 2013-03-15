From: Joydeep Bakshi <joydeep.bakshi@infoservices.in>
Subject: Re: building git ; need suggestion
Date: Fri, 15 Mar 2013 18:22:47 +0530
Message-ID: <00107242-04EB-423F-90FE-A6DCDEE7E262@infoservices.in>
References: <868B103B-690E-477B-BF75-8F954F893E6F@infoservices.in> <20130315124415.GA23122@paksenarrion.iveqy.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 13:53:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGU8P-0008Li-DG
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 13:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280Ab3COMwy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 08:52:54 -0400
Received: from static.88-198-19-49.clients.your-server.de ([88.198.19.49]:45766
	"EHLO zimbra.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754221Ab3COMwy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 08:52:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra.infoservices.in (Postfix) with ESMTP id 33442F02FCF;
	Fri, 15 Mar 2013 18:22:53 +0530 (IST)
X-Virus-Scanned: amavisd-new at zimbra.infoservices.in
Received: from zimbra.infoservices.in ([127.0.0.1])
	by localhost (zimbra.infoservices.in [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eCMDlu1GW8ar; Fri, 15 Mar 2013 18:22:51 +0530 (IST)
Received: from [192.168.1.116] (unknown [122.176.30.116])
	by zimbra.infoservices.in (Postfix) with ESMTPSA id E54FAF02F20;
	Fri, 15 Mar 2013 18:22:50 +0530 (IST)
In-Reply-To: <20130315124415.GA23122@paksenarrion.iveqy.com>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218242>


On 15-Mar-2013, at 6:14 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:

> On Fri, Mar 15, 2013 at 05:54:05PM +0530, Joydeep Bakshi wrote:
>> [1] the server will have different git repo with branches
>> [2] there will be a web-based GUI which must be flexible to show jus=
t a specific branch of a repo based on user authentication
>> [3] the web-based GUI should also have the flexibility to show a sin=
gle repo based on the authentication
>> [4] the web-based GUI should have an admin account to supervise and =
configure all repos along with their branches
>> [3] there must be a control mechanism in the repo/web based GUI whic=
h have ACL on branches i.e.
>> some specific users should see some specific/ or just a branch and a=
ble to commit there only.
>>=20
>> based on the above scenario could anyone suggest the best available =
solution ?
>> There are many like gitolike/github etc=85. but don't know whig one =
has much finer granular
>> control/ACL/web-based GUI=85
>=20
> gitolite have a more fine ACL. Check it out. However it doesn't reall=
y
> meet your needs with web-interface (and I'm not even sure about the A=
CL
> thing is fine enough for you). You can read more about ACL in the git
> book: http://git-scm.com/book/ch7-4.html
>=20
> The webgui that's most populair is cgit and git-web. They don't do AC=
L
> afaik.
>=20
> Why would you need ACL? Why not don't share the branches that are goi=
ng
> to be secret? Or are you looking for some branches to be read only?

Actually the branches have to be dedicated to a group of users.
 developer branch ---> developers
bug fixed branch --- > bug fixer=20

and specific group don't need to RW permission on other branch.
Obviously the admin must have the full permission on all these branches
and merge as per requirement.

The web-interface is required for checking the history by the users the=
mselves
and for code review. I don't know any web interface which can show repo=
/branch=20
based on authentication. I have tried gitweb but it can handle a single=
 repo or multiple
repo with single authentication. NO ACL
 