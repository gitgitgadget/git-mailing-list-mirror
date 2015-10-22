From: Max Kirillov <max@max630.net>
Subject: [PATCH v3 0/2] blame: allow blame --reverse --first-parent when it makes sense
Date: Thu, 22 Oct 2015 07:07:37 +0300
Message-ID: <1445486859-21906-1-git-send-email-max@max630.net>
References: <1445485872-21453-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 06:08:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp7Ax-0000kp-VZ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 06:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbbJVEIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 00:08:19 -0400
Received: from p3plsmtpa06-02.prod.phx3.secureserver.net ([173.201.192.103]:36490
	"EHLO p3plsmtpa06-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750989AbbJVEHr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Oct 2015 00:07:47 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa06-02.prod.phx3.secureserver.net with 
	id Y47h1r0025B68XE0147lf7; Wed, 21 Oct 2015 21:07:47 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
In-Reply-To: <1445485872-21453-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280036>

Fix indentation.

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
