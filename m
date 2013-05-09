From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3 0/5] allow more sources for config values
Date: Thu, 9 May 2013 18:16:36 +0200
Message-ID: <20130509161636.GB3526@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 09 18:25:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaTem-0002T9-Jb
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 18:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab3EIQZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 12:25:19 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:52904 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375Ab3EIQZS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 12:25:18 -0400
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1UaTWL-0004sj-MV; Thu, 09 May 2013 18:16:42 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223743>

Hi,

I fixed all the issues I know of so this should be ready for master.

This is an update with the comments of the second iteration[1] incorporated.

[1] http://thread.gmane.org/gmane.comp.version-control.git/217811

Heiko Voigt (5):
  config: factor out config file stack management
  config: drop cf validity check in get_next_char()
  config: make parsing stack struct independent from actual data source
  teach config --blob option to parse config from database
  do not die when error in config parsing of buf occurs

 builtin/config.c       |  39 +++++++--
 cache.h                |   6 +-
 config.c               | 216 ++++++++++++++++++++++++++++++++++++++-----------
 t/t1307-config-blob.sh |  75 +++++++++++++++++
 4 files changed, 281 insertions(+), 55 deletions(-)
 create mode 100755 t/t1307-config-blob.sh

-- 
1.8.3.rc1.40.gba374ae
