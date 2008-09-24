From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] Prepare for non-interactive merge-preserving rebase
Date: Wed, 24 Sep 2008 08:17:10 +0200
Message-ID: <48D9DB66.3010501@viscovery.net>
References: <48D95836.6040200@op5.se>	<20080923162211.d4b15373.stephen@exigencecorp.com>	<48D95FE1.30200@op5.se> <20080924001027.GA19264@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@fzi.de>
X-From: git-owner@vger.kernel.org Wed Sep 24 08:18:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiNhh-00061a-An
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 08:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbYIXGRQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Sep 2008 02:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbYIXGRQ
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 02:17:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53891 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYIXGRQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Sep 2008 02:17:16 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KiNgV-0007Es-Hx; Wed, 24 Sep 2008 08:17:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EF9604FB; Wed, 24 Sep 2008 08:17:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080924001027.GA19264@neumann>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96618>

SZEDER G=E1bor schrieb:
>   -A---B      master
>     \
>      C---M    topic
>       \ /
>        D
=2E..
> If I now execute 'git rebase -p master topic', I get the following:
>=20
>   -A---B            master
>     \   \
>      \   C'---M'    topic
>       \      /
>        C----D
>=20
> But I would rather like to have the following:
>=20
>   -A---B            master
>         \
>          C'---M'    topic
>           \  /
>            D'
>=20
> Would such a behaviour possible at all?

I think that rebase -i -p was meant to deal only with the situation whe=
re
the merged-in branch is from outside the topic branch. What you want is
called "git-sequencer". Search the archives.

-- Hannes
