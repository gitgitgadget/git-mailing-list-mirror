From: Max Kirillov <max@max630.net>
Subject: [PATCH v5 0/3] blame: allow blame --reverse --first-parent when it makes sense
Date: Fri, 30 Oct 2015 07:01:50 +0200
Message-ID: <1446181313-15094-1-git-send-email-max@max630.net>
References: <1445837217-4252-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 06:02:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zs1pQ-0004We-Po
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 06:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbbJ3FCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 01:02:04 -0400
Received: from p3plsmtpa07-01.prod.phx3.secureserver.net ([173.201.192.230]:51724
	"EHLO p3plsmtpa07-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751157AbbJ3FCD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2015 01:02:03 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-01.prod.phx3.secureserver.net with 
	id bH1u1r0075B68XE01H1zfP; Thu, 29 Oct 2015 22:02:01 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1445837217-4252-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280478>

Update the test:
* Fix style notes in tests
* Remove the non-first-parent case, because it's more like fature request, and is not fixed in this batch
* Rewrite the commit message, hopely now it answers better to "why"

Max Kirillov (3):
  blame: add test to describe use of blame --reverse --first-parent
  blame: extract find_single_final
  blame: allow blame --reverse --first-parent when it makes sense

 builtin/blame.c                   | 61 ++++++++++++++++++++++++++++++---------
 t/t8009-blame-vs-topicbranches.sh | 36 +++++++++++++++++++++++
 2 files changed, 83 insertions(+), 14 deletions(-)
 create mode 100755 t/t8009-blame-vs-topicbranches.sh

-- 
2.3.4.2801.g3d0809b
