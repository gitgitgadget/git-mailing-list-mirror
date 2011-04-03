From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 0/3] Document diff and filter drivers in config
Date: Sun,  3 Apr 2011 19:55:19 +0530
Message-ID: <1301840722-24344-1-git-send-email-artagnon@gmail.com>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Helped-by: Michael J Gruber" <git@drmicha.warpmail.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 03 16:26:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6OGI-0002X3-Et
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 16:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab1DCO0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 10:26:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51170 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1DCO0g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 10:26:36 -0400
Received: by iyb14 with SMTP id 14so5118848iyb.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 07:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=B5CMvqgZDR3GHE4HP+y8TkcNme7TAVB38xVR7hKXbNw=;
        b=lqIUPUgQ/BvI956AHuCm1uzbKC5bquMpyAJ85Ljlx7faLGHTfu2aQtIRoST9CbF7/i
         dNvxfd4ZS1KMib9/LPmho+yLW0itr8bIEzyFhG44n/B++eK+TjwFUgJrWU542IrJTgHP
         YKuNpX7XIovqS2wC2FHQweam3zsmBMKEb4NbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=q4d3Ma47hrICogumkt9HGeRfSJ2FoclEaeV4bEl9oCtWcIpGxuKpyTfI3zMLKDCQZ/
         ouL7TI/zbVg/74EIRWZXI8sRhqf1yF3GKQfu28yItgwri+Jtgm+1ZQJ3Yt3vbsv+oKee
         yXS/rwsz3AjBqrOrGhT3fel7RTjTvy+Io7PEw=
Received: by 10.43.53.6 with SMTP id vo6mr8843778icb.387.1301840795552;
        Sun, 03 Apr 2011 07:26:35 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id i3sm3011074iby.40.2011.04.03.07.26.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 07:26:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170692>

What changed since v2:
- I decided to move the diff.* configuration options into a dedicated
  diff-config.txt, corresponding to merge-config.txt.
- The placeholder <driver> is much less confusing than <tool> (see
  difftool.* family) -- thanks to Michael for that.
- Language is much nicer now- thanks to Michael again.
- The deprecated `funcname` is excluded now. Thanks to Jakub.
- There's one extra patch; a small inconsistency that I happened to
  come across while comparing diff-config.txt with merge-config.txt.

Thanks for reading.

-- Ram

Ramkumar Ramachandra (3):
  Documentation: Add filter.<driver>.* to config
  Documentation: Add diff.<driver>.* to config
  Documentation: Allow custom diff tools to be specified in 'diff.tool'

 Documentation/config.txt      |   73 +++++---------------------------
 Documentation/diff-config.txt |   93 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/diff-config.txt

-- 
1.7.4.rc1.7.g2cf08.dirty
