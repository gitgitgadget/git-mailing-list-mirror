From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/3] Fix $((...)) coding style
Date: Thu, 4 Feb 2016 13:01:39 +0100 (CET)
Message-ID: <cover.1454587284.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 13:01:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRIbf-0006iF-HF
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 13:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222AbcBDMBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 07:01:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:52056 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844AbcBDMBq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 07:01:46 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Llmcq-1ZsEpo40yO-00ZLBX; Thu, 04 Feb 2016 13:01:41
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:gPVPPzrbw9JJRgKG6cqYO8ny0owRPIBR2GhuUMnN4ADqC2jIlIj
 XV4PM8CN9s8OmyhTiuAevn8BbQL5RFWXeXNaIjHpnLFkMlZBDyfAJIEsKlx57juTUzX2mNi
 b0TxcuSrwoaZdLArB+W8AuDnUHRUEyq6CcWNCQjsnEbkrkWUyq4HBvwtT9i8W541Qp2bsDG
 Sf0reT7iVx5jPnFQrqp9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MXFZ+fWArwQ=:sVvLefmv6jQzMKvyPU1uZ4
 KaK5tcSLP3EGjcv/Hs5Q2DwFwsuV0LSk9u4jjEnb31WamuYffo2opblm1AyQsu/Imlt2hwwFp
 3bJ4L1WKEhusdRnbvsTlefFn9FOScpCMeL8SsQ3hSPfdds1H61gBGNdUgRKPmki/974hrZJzx
 Av/elfxivjSzhtVhMJZwwz0ZZrMO0fCumyLD151Kb1H67eP9SNQjmdZYPH+z8wIcTc+8mqqhZ
 ZqobkMftOteppnEV1xOJQhhBOwfch9aEJAdUipVnEHugvNojQH7cURsc1jJpCN2vYDYaHo8hb
 k4RrDF3YoxHgbsoSh2j6kyAPUHeWrvPoTDDfVTNussA9SEM2nBakCCY6DN5FHb/O1CMmnENe8
 g3Vg6Qk2Qu3Ay3tBvzVnqcDbcHZm/GQVNTXqqeIow08W7fcDHohsdN2tW23K1G1cbQqUXcHXo
 5FfXCLyVDiwZBhicaXTgdpIivxP61NJFdk/1qI2EweKFdvwq88s3bwTLw0HbM5fGCKblq34du
 kxcasoQL5O0ISN6cnV/iFBusdxzKUFTEOHVTV2v6ptvuwkpb7ZPHCbSvL2nAUy2dv1+u6FSSN
 1RWRBON9j3aR/V2F4MHt+G+YrE9KRiJkDJcPMn6IGYT4IgyKJzAMcUdwiODaK0DX7RdsqLbpA
 O3JiZxK+yDcYcEiINJDA+PQZOFkEcFJCUAzZ6Kx3kNvX6rQCj8YWYyGTEtoZLxWzy39DV5/vn
 tUal/N/DoQmdEcpDVEde89gdHxTzAmKf6RLcWcJw29YW4HdXPZFa1Q4m0CmQyLslKSGPzJjW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285456>

I noticed through a nearby patch series that was submitted by Elia that
some of the $((...)) expressions introduced in scripts that I introduced
to Git's source code did not match the existing code's convention:
previously these expressions did not contain any spaces, now *some* do.

This patch series tries to clean that up quickly before even more code
has to decide which one of the disagreeing coding conventions to use.

Note: For the sake of getting this patch series out, I skipped t/ and
contrib/. I do not care much about the latter, but t/ should probably be
fixed, too.


Johannes Schindelin (3):
  filter-branch: fix style of $((...) construct
  rebase--interactive: adjust the coding style of $((...))
  rebase --merge: adjust $((...)) coding style

 git-filter-branch.sh       | 8 ++++----
 git-rebase--interactive.sh | 4 ++--
 git-rebase--merge.sh       | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.7.0.windows.1.7.g55a05c8
