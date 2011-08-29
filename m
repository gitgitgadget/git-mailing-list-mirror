From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/2] am: foreign patch support fixes
Date: Mon, 29 Aug 2011 18:44:05 +0200
Message-ID: <1314636247-26125-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 18:44:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy4ww-00009C-LZ
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 18:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab1H2Qoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 12:44:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39775 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab1H2Qod (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 12:44:33 -0400
Received: by wwf5 with SMTP id 5so5919990wwf.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gFXYjWjq0+u4CA1wjLMZSYmeW4WQsVquOoeCbilN6no=;
        b=B5ukboD1tqhT6yYtNjNbMoVbaH3VClFBwu2LCvcopJH5DDh4P1wcSIVLC60oWT8sEx
         zw6dF5I7TlCs1A/s+2UdHctKMf+VHFdWjeTfR+xllR99BixmL1J/5kloeyDEGdWFj3zZ
         DBkKqTymJFHnfO/eIC46O31sFlPUVYbZAGXg0=
Received: by 10.227.2.72 with SMTP id 8mr3917025wbi.99.1314636272421;
        Mon, 29 Aug 2011 09:44:32 -0700 (PDT)
Received: from localhost ([151.54.153.147])
        by mx.google.com with ESMTPS id fg5sm3885902wbb.23.2011.08.29.09.44.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 09:44:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.331.g25483.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180316>

Two small patches to fix/enhance support for foreign patchset.

The first patch adds support for hg patches, which have been detected
(but not supported) for a while. I've used it to import a couple of
patches successfully.

The second patch fixes a rather long-standing issue with stgit patches,
when Author was used instead of From. Apparently not many patches with
this format are encountered in the wild, since nobody had an issue with
it so far.

Giuseppe Bilotta (2):
  am: preliminary support for hg patches
  am: fix stgit patch mangling

 git-am.sh |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

-- 
1.7.7.rc0.331.g25483.dirty
