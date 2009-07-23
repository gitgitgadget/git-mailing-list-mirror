From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 19:23:23 -0500
Message-ID: <20090723002323.GA23021@saturnine>
References: <20090722235914.GA13150@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 02:23:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTm5y-0007Hw-1M
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 02:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbZGWAXb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 20:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbZGWAXb
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 20:23:31 -0400
Received: from francis.fzi.de ([141.21.7.5]:1729 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751815AbZGWAXa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 20:23:30 -0400
Received: from localhost.localdomain ([141.21.16.6]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Jul 2009 02:23:26 +0200
Content-Disposition: inline
In-Reply-To: <20090722235914.GA13150@Pilar.aei.mpg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 23 Jul 2009 00:23:27.0165 (UTC) FILETIME=[CC3ED6D0:01CA0B2B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123814>

Hi,


On Thu, Jul 23, 2009 at 01:59:14AM +0200, Carlos R. Mafra wrote:

> I don't know why .git/refs/heads/stern does not exist and why it take=
s
> so long with it. That branch is functional ('git checkout stern' succ=
eeds),
> as well as all the others. But strangely .git/refs/heads/ contains on=
ly
>=20
> [mafra@Pilar:linux-2.6]$ ls .git/refs/heads/
> dev-private  master  sparse
>=20
> which, apart from "master", are the last branches that I created.
>=20
> I occasionally run 'git gc --aggressive --prune" to optimize the repo=
,
> but other than that I don't do anything fancy, just 'pull' almost
> every day and 'bisect' (which is becoming a rare event now :-)
>=20
> So I would like to ask what should I do to recover the missing files
> in .git/refs/heads/ (which apparently is the cause for my issue) and
> how I can avoid losing them in the first place.

have a look at .git/packed-refs and 'git pack-refs'.


Best,
G=E1bor
