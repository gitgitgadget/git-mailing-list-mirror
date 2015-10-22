From: Max Kirillov <max@max630.net>
Subject: [PATCH v2 0/2] blame: allow blame --reverse --first-parent when it makes sense
Date: Thu, 22 Oct 2015 06:51:10 +0300
Message-ID: <1445485872-21453-1-git-send-email-max@max630.net>
References: <1445400482-1977-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 05:51:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp6uU-0006fI-8U
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 05:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846AbbJVDvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 23:51:22 -0400
Received: from p3plsmtpa08-01.prod.phx3.secureserver.net ([173.201.193.102]:48106
	"EHLO p3plsmtpa08-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751618AbbJVDvV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2015 23:51:21 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-01.prod.phx3.secureserver.net with 
	id Y3rD1r00D5B68XE013rK0b; Wed, 21 Oct 2015 20:51:21 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1445400482-1977-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280031>

Fixed mistype in commit message.

Max Kirillov (2):
  Add test to describe expectation of blame --reverse with branched
    history
  blame: allow blame --reverse --first-parent when it makes sense

 builtin/blame.c          | 11 +++++++++--
 t/t8009-blame-reverse.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100755 t/t8009-blame-reverse.sh

-- 
2.3.4.2801.g3d0809b
