From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/4] Make httpd tests run v2
Date: Mon, 11 May 2015 13:54:16 +0200
Message-ID: <cover.1431344881.git.git@drmicha.warpmail.net>
References: <0727016B-E495-4577-A174-E0EA85910BD3@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 13:54:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrmIH-0004GE-CU
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 13:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbbEKLyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 07:54:25 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40555 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753199AbbEKLyW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 07:54:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id BFC7F20A30
	for <git@vger.kernel.org>; Mon, 11 May 2015 07:54:21 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 11 May 2015 07:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=VHb6KyzgyZiNBvrtjoY+42en4UY
	=; b=GEy3dlI1srkl8Q1I9cIr4g1ctQleIqg4nghIYt9ZBhPkVzRktrBBkm3lGFy
	aRSv7+OOggOuL9eoeCOm8e7Kn+YICENPOCXkTy1wL3smsa7LO4fCI1vCE5Ov85JR
	mwmXpXTg8vGH0eWMjJYRZ1hEVprpdJBOKyTTjnsujyQM8DM4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=VHb6
	KyzgyZiNBvrtjoY+42en4UY=; b=dUI+C2KQYN5IXkMhJjbMMnVhh/BA8nHURxcQ
	sfbdGl0CJlxKPgTIqidGlvWis+QBj9wFT6TZsMNDkl/HIhqNWsOpWYtW10ZAS+DB
	6R0xakCBFbYR/xyt4WbyxiZ/kN6xavXLeDvVuO346yQiWK7ljxc12EbBY0rqlWSy
	ArKkvdo=
X-Sasl-enc: IoVIRQfc0QYCKzlXov8Rz2RmJSykU8t5WyaO0bWYP8Hk 1431345261
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5185BC00018;
	Mon, 11 May 2015 07:54:21 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc3.332.g886447c
In-Reply-To: <0727016B-E495-4577-A174-E0EA85910BD3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268774>

v2 updates the commit messages as per the dicsussion after v1 and adds a
clean-up.

1/4, 2/4 are ready to go as discussed (commit messages updated).
3/4 is a new independent cleanup noted while being there.
4/4 is the old 3/3 and still WIP. Please hold back.

Michael J Gruber (4):
  t/lib-httpd: load mod_unixd
  t/lib-git-svn: check same httpd module dirs as lib-httpd
  t/t91*: donot say how to avoid the tests
  t/lib-git-svn: adjust config to apache 2.4 WIP

 t/lib-git-svn.sh                       | 17 +++++++++++++++--
 t/lib-httpd/apache.conf                |  3 +++
 t/t9100-git-svn-basic.sh               |  2 --
 t/t9158-git-svn-mergeinfo.sh           |  2 --
 t/t9160-git-svn-preserve-empty-dirs.sh |  1 -
 5 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.4.0.rc3.332.g886447c
