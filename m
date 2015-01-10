From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 0/2] Documentation/githooks: mention pwd, $GIT_PREFIX
Date: Sat, 10 Jan 2015 18:11:41 -0500
Message-ID: <1420931503-22857-1-git-send-email-rhansen@bbn.com>
References: <54B0E1EE.2020301@kdbg.org>
Cc: git@vger.kernel.org, rhansen@bbn.com
To: 6t@kdbg.org
X-From: git-owner@vger.kernel.org Sun Jan 11 00:12:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA5CZ-0001yc-Na
	for gcvg-git-2@plane.gmane.org; Sun, 11 Jan 2015 00:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbbAJXL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 18:11:59 -0500
Received: from smtp.bbn.com ([128.33.1.81]:64280 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751028AbbAJXL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 18:11:58 -0500
Received: from socket.bbn.com ([192.1.120.102]:35761)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1YA5CF-0003hs-GN; Sat, 10 Jan 2015 18:11:55 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 1D6893FF91
X-Mailer: git-send-email 2.2.1
In-Reply-To: <54B0E1EE.2020301@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262281>

patch 1/2 is the same as v1
patch 2/2 has been reworked to incorporate Hannes's feedback (thank
you!)

-Richard


Richard Hansen (2):
  Documentation/githooks: mention pwd, $GIT_PREFIX
  t1020-subdirectory.sh: check hook pwd, $GIT_PREFIX

 Documentation/githooks.txt |  6 ++++++
 t/t1020-subdirectory.sh    | 23 +++++++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.2.1
