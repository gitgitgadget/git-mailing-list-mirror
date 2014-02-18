From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v2 0/3] Allow to configure cherry-pick's record origin
Date: Tue, 18 Feb 2014 22:27:39 +0100
Message-ID: <cover.1392758057.git.agx@sigxcpu.org>
References: <20140218192039.GC7855@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 22:28:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFsDH-0004wn-VW
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 22:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbaBRV2F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 16:28:05 -0500
Received: from xvm-169-183.ghst.net ([95.142.169.183]:44665 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbaBRV2D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 16:28:03 -0500
Received: from honk.sigxcpu.org (localhost [IPv6:::1])
	by photon.sigxcpu.org (Postfix) with ESMTPS id 24C32695
	for <git@vger.kernel.org>; Tue, 18 Feb 2014 22:28:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id ACA88FB04
	for <git@vger.kernel.org>; Tue, 18 Feb 2014 22:28:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s02xLpJtu5Hn for <git@vger.kernel.org>;
	Tue, 18 Feb 2014 22:27:59 +0100 (CET)
X-Mailer: git-send-email 1.9.0.rc3
In-Reply-To: <20140218192039.GC7855@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242356>

The main motivation is to be able to configure repos that are used for
maintaining backports/stable branches and not having to remember to use=
 a
special invocation of git cherry-pick.

Changes from last version:

* add --no-record-origin so scripts can make sure they'll never record
  a commit id
* add --record-origin for symmetry with config file option and
  --no-record-origin
* Add docs to git-config as well

Guido G=C3=BCnther (3):
  revert.c: Allow to specify -x via git-config
  revert.c: Add --record-origin
  revert.c Allow to override cherrypick.recordOrigin

 Documentation/config.txt          |  4 ++++
 Documentation/git-cherry-pick.txt | 13 +++++++++++++
 builtin/revert.c                  | 22 ++++++++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

--=20
1.9.0.rc3
