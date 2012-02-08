From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv4] tag: add --points-at list option
Date: Wed,  8 Feb 2012 12:12:51 -0800
Message-ID: <1328731972-13137-1-git-send-email-tmgrennan@gmail.com>
References: <20120208185750.GA22220@sigill.intra.peff.net>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 21:13:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvDtC-00013L-CX
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 21:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845Ab2BHUNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 15:13:07 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:42112 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750716Ab2BHUNG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2012 15:13:06 -0500
Received: by obcva7 with SMTP id va7so1247905obc.19
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 12:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=M4ECdsVtyGdVH/SIUz7P0mjGon5QSbsw5GVCDeR1+NY=;
        b=e5DTGgZryRgL0jZrg53VWwqK6VH4q6FJ9kF4YF5IrID1hfPexJEoSJ2kynUAgH5akL
         gj1nIkdrC0hBlJ9NAXxgHhIocd9V58v9qAbrjDmWrCu+lM8Fw6CfAMlianii12VFgZrz
         FL/oQE8siEPasump/5W9ozRvQ+k6An6snOvaU=
Received: by 10.182.160.5 with SMTP id xg5mr27382136obb.53.1328731985243;
        Wed, 08 Feb 2012 12:13:05 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id s2sm611463obx.1.2012.02.08.12.13.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Feb 2012 12:13:04 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <20120208185750.GA22220@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190252>

Please see the following patch that I hoped is the last version of the
"points-at" feature.  Thank you for your patience.

Tom Grennan (1):
  tag: add --points-at list option

 Documentation/git-tag.txt |    5 +++-
 builtin/tag.c             |   52 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 53 insertions(+), 4 deletions(-)

-- 
1.7.8
