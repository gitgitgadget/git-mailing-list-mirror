From: Max Kirillov <max@max630.net>
Subject: [PATCH v4 0/4] blame: allow blame --reverse --first-parent when it makes sense
Date: Mon, 26 Oct 2015 07:26:53 +0200
Message-ID: <1445837217-4252-1-git-send-email-max@max630.net>
References: <1445486859-21906-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 06:27:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqaJM-0000jZ-OH
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 06:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbbJZF1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 01:27:07 -0400
Received: from p3plsmtpa09-05.prod.phx3.secureserver.net ([173.201.193.234]:56576
	"EHLO p3plsmtpa09-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750883AbbJZF1G (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2015 01:27:06 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-05.prod.phx3.secureserver.net with 
	id ZhSy1r00P5B68XE01hT2vC; Sun, 25 Oct 2015 22:27:05 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1445486859-21906-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280172>

Change aproach - instead of assuming children content build them explicitly,
also accurately verifying that the specified range is along the first-parent chain

Max Kirillov (3):
  Add test to describe expectation of blame --reverse with branched
    history
  blame: extract find_single_final
  blame: allow blame --reverse --first-parent when it makes sense

 builtin/blame.c          | 61 +++++++++++++++++++++++++++++++++++++-----------
 t/t8009-blame-reverse.sh | 34 +++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 14 deletions(-)
 create mode 100755 t/t8009-blame-reverse.sh

-- 
2.3.4.2801.g3d0809b
