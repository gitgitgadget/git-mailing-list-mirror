From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v8 0/9] connect: various cleanups
Date: Fri, 27 May 2016 11:27:47 +0900
Message-ID: <20160527022756.22904-1-mh@glandium.org>
Cc: git@vger.kernel.org, tboegi@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 27 04:28:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b67Vf-0005Gz-Bw
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 04:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbcE0C2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 22:28:05 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40422 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932267AbcE0C2C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 22:28:02 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1b67VE-0005yF-He; Fri, 27 May 2016 11:27:56 +0900
X-Mailer: git-send-email 2.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295713>

Changes from v7:
- Fixed comments.

Mike Hommey (9):
  connect: document why we sometimes call get_port after
    get_host_and_port
  connect: call get_host_and_port() earlier
  connect: re-derive a host:port string from the separate host and port
    variables
  connect: make parse_connect_url() return separated host and port
  connect: group CONNECT_DIAG_URL handling code
  connect: make parse_connect_url() return the user part of the url as a
    separate value
  connect: change the --diag-url output to separate user and host
  connect: actively reject git:// urls with a user part
  connect: move ssh command line preparation to a separate function

 connect.c             | 235 +++++++++++++++++++++++++++++---------------------
 t/t5500-fetch-pack.sh |  42 ++++++---
 2 files changed, 170 insertions(+), 107 deletions(-)

-- 
2.8.3
