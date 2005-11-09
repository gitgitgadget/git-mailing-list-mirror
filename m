From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 0/4] Add git-pack-intersect
Date: Wed, 09 Nov 2005 12:58:42 +0100
Message-ID: <4371E472.4030902@op5.se>
References: <43714EFB.5070705@etek.chalmers.se> <20051109111917.GB30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Nov 09 12:59:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZobK-00049l-6W
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 12:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbVKIL6p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 9 Nov 2005 06:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbVKIL6p
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 06:58:45 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:59780 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751395AbVKIL6o
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 06:58:44 -0500
Received: from [82.182.116.45] (1-2-9-7b.gkp.gbg.bostream.se [82.182.116.45])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 0C6D56BCFF
	for <git@vger.kernel.org>; Wed,  9 Nov 2005 12:58:43 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20051109111917.GB30496@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11397>

Petr Baudis wrote:
> Dear diary, on Wed, Nov 09, 2005 at 02:20:59AM CET, I got a letter
> where Lukas Sandstr=F6m <lukass@etek.chalmers.se> said that...
>=20
>>This patch series adds git-pack-intersect. It finds redundant packs
>>by calculating the union of all objects present in .git/objects/pack
>>and then computing the smallest set of packs which contain all the
>>objects in this union.
>=20
>=20
> Sounds nice, except the name - it does something else than what the n=
ame
> says, so perhaps something like 'git-pack-redundant' would be more
> appropriate.
>=20

It would be better if it was in git-prune or a default action for=20
git-repack. I can't imagine a scenario where keeping redundant packfile=
s=20
is useful.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
