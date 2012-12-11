From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v7 0/3] submodule update: add --remote for submodule's upstream
 changes
Date: Tue, 11 Dec 2012 13:58:14 -0500
Message-ID: <cover.1355251862.git.wking@tremily.us>
References: <20121204001717.GA17375@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiV2h-0005tH-NL
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 19:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab2LKS6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 13:58:42 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:56118 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736Ab2LKS6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 13:58:41 -0500
Received: from odin.tremily.us ([unknown] [72.68.110.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MEV00FTNRDAXW10@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 11 Dec 2012 12:58:23 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 1FC3D71B42D; Tue,
 11 Dec 2012 13:58:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1355252302; bh=SrjVEI2scIbUBhfz9xxqHY4a5xyOeDQD44aumyB2QQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nIedU0Bu+jN+th8ALfzSS9vnxF+qBsUKbTYiaEATzxTVuH4bpKPj/IIJskjzEjhsk
 b9H4S4ka6b8OwTJbZaWjhCu9cx2V/hKki4UPLU4oaHy6CWSnyH31oFHbWeZjM9PrUP
 QpVCdRds4PHNv0DQEYBhF1K/PzhiTfOUJbnWWnKk=
X-Mailer: git-send-email 1.7.8.6
In-reply-to: <20121204001717.GA17375@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211293>

From: "W. Trevor King" <wking@tremily.us>

I see that this series has dropped out of "what's cooking?".
Hopefully this reroll gets it back in ;).

Changes since v6 (both in response to Junio's comments):

* Fix style in get_submodule_config definition.
* Drop the submodule.<name>.remote config option (v6's patch 4).

W. Trevor King (3):
  submodule: add get_submodule_config helper funtion
  submodule update: add --remote for submodule's upstream changes
  submodule add: If --branch is given, record it in .gitmodules

 Documentation/config.txt        |  7 +++++-
 Documentation/git-submodule.txt | 27 ++++++++++++++++++++-
 Documentation/gitmodules.txt    |  5 ++++
 git-submodule.sh                | 52 ++++++++++++++++++++++++++++++++++++++++-
 t/t7400-submodule-basic.sh      |  1 +
 t/t7406-submodule-update.sh     | 31 ++++++++++++++++++++++++
 6 files changed, 120 insertions(+), 3 deletions(-)

-- 
1.8.0
