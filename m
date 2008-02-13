From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Using kdiff3 to compare two different revisions of a folder
Date: Wed, 13 Feb 2008 23:38:18 +0100
Message-ID: <200802132338.18449.robin.rosenberg.lists@dewire.com>
References: <b8bf37780802121744i62849a53rfa71cc0571aec3a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?iso-8859-1?q?Andr=E9_Goddard?= Rosa" <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 23:40:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPQGX-0001vD-SN
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 23:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759964AbYBMWiy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 17:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754059AbYBMWiy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 17:38:54 -0500
Received: from [83.140.172.130] ([83.140.172.130]:16750 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbYBMWix (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 17:38:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3C31C8006AD;
	Wed, 13 Feb 2008 23:38:51 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id itmCITq+Ka11; Wed, 13 Feb 2008 23:38:50 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 689CC80069F;
	Wed, 13 Feb 2008 23:38:50 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <b8bf37780802121744i62849a53rfa71cc0571aec3a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73823>

onsdagen den 13 februari 2008 skrev Andr=E9 Goddard Rosa:
> Hi, all!
>=20
>     I would like to use kdiff3 to compare some folder like "include"
> between two different revisions.
>     It would be something like "git diff v2.5:makefile HEAD:makefile"=
,
> but for an entire folder.
>=20
>     Kdiff3 give me a quick glance of its nice graphical output of the
> differences, without have to resort to looking/parsing 'git log'
> output.
>     For now, easiest way for me is to keep my tree replicated in two
> different folders pointing to different revisions then use it.
>=20
>     Is there a better way to do this kind of comparison?

Yes.
	git diff <whatever options> | kompare -

-- robin
