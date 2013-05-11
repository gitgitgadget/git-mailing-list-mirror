From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v4 0/5] allow more sources for config values
Date: Sat, 11 May 2013 15:17:22 +0200
Message-ID: <20130511131721.GA17991@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 11 15:17:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub9gI-0001V0-8R
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 15:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648Ab3EKNRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 09:17:30 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:46325 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab3EKNRa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 09:17:30 -0400
X-Greylist: delayed 161780 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 May 2013 09:17:29 EDT
Received: from [213.221.117.228] (helo=book-mint)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Ub9fx-0002Nf-RD; Sat, 11 May 2013 15:17:25 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223964>

Hi,

all the comments to the last iteration[1] incorporated.

You can also find this on my github[2]. This is only for review. I will
resubmit this once 1.8.3 is out.

Cheers Heiko

[1] http://article.gmane.org/gmane.comp.version-control.git/223743
[2] https://github.com/hvoigt/git/commits/hv/strbuf_config_parsing-series4

Heiko Voigt (5):
  config: factor out config file stack management
  config: drop cf validity check in get_next_char()
  config: make parsing stack struct independent from actual data source
  teach config --blob option to parse config from database
  do not die when error in config parsing of buf occurs

 builtin/config.c       |  31 ++++++-
 cache.h                |   6 +-
 config.c               | 217 ++++++++++++++++++++++++++++++++++++++-----------
 t/t1307-config-blob.sh |  70 ++++++++++++++++
 4 files changed, 271 insertions(+), 53 deletions(-)
 create mode 100755 t/t1307-config-blob.sh

-- 
1.8.3.rc1.53.g0126843
