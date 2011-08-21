From: =?iso-8859-1?Q?Ma=EFeul_Rouquette?= <maieul@maieul.net>
Subject: Re: Merging one file only
Date: Sun, 21 Aug 2011 23:35:38 +0200
Message-ID: <6EE456FC-9671-4CAF-9067-743AE2526717@maieul.net>
References: <1313958819073-6709333.post@n2.nabble.com> <CAMOZ1BvY13ynmtCkhFNU9Dc8PqwVQUrp8ham5zHrdq2vbMY5JQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Aug 21 23:35:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvFgQ-0005sG-03
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 23:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760Ab1HUVfp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Aug 2011 17:35:45 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34501 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527Ab1HUVfp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 17:35:45 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 8A073A804B
	for <git@vger.kernel.org>; Sun, 21 Aug 2011 23:35:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter4-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id qb3xKU9b4aHy for <git@vger.kernel.org>;
	Sun, 21 Aug 2011 23:35:42 +0200 (CEST)
X-Originating-IP: 86.68.70.155
Received: from 155.70.68.86.rev.sfr.net (155.70.68.86.rev.sfr.net [86.68.70.155])
	(Authenticated sender: maieul@maieul.net)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1AD3CA8068
	for <git@vger.kernel.org>; Sun, 21 Aug 2011 23:35:38 +0200 (CEST)
In-Reply-To: <CAMOZ1BvY13ynmtCkhFNU9Dc8PqwVQUrp8ham5zHrdq2vbMY5JQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179816>


Le 21 ao=FBt 2011 =E0 23:32, Michael Witten a =E9crit :

> On Sun, Aug 21, 2011 at 20:33, Ma=EFeul <maieul@maieul.net> wrote:
>> Hello,
>>=20
>> my problem is :
>> - I have 2 branches : "master" and "sty"
>> - In the branch sty, I have commit that i don't want to merge on the=
 branch
>> master. The only file that I want merge are the *dtx files.
>>=20
>> My question is : how can i do to merge *dtx files from "sty" to "mas=
ter",
>> and have log of commit on the *dtx ? Is it possible ?
>=20
> There are a number of ways to do this, some more general than others.
>=20
> Do you know all of the names of the files for which you don't want
> associated commits? Do the files that you don't want get changed in
> some of the commits that you do want?
I found the solution "git merge hashofcommit". My commits one the file =
are only on the file, so the solution is very simple !
Thank for helping :)-
