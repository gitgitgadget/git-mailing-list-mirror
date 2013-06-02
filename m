From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/6] Minor prompt, completion cleanups
Date: Sun,  2 Jun 2013 19:33:36 +0530
Message-ID: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 02 16:06:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uj8v6-0000mx-5Y
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 16:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab3FBOGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 10:06:00 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:60810 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab3FBOF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 10:05:58 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so4478292pbb.6
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=soVE+xTJ4770L4hFD4Srfqaz6hKk96NJA7KQc4f4RLI=;
        b=U55mfQH8sbNmk466LN4DYlSjeMrUKTb7LYiQ59h49H55PTh6wZLToUkso9HqbrhSnJ
         C5XbckW/vK01waOWQ6z0JOx/fq/5t3mnuDhfmejJXfndjowoZlIYJfhtpfnLCUYEhGCO
         /h2xhfc7OxivTgJO0C3vk/506z0OWLZCvlzCYyVf6Z97DBVnaVv8hKwfSdRRPG1/Z4qP
         WaPNSUkWENEYfZfZ3NLzzrTbE3+jZkkWZbxhN04uAyEDuMM9BdgdGxIgIXjcW/Q1Ld8W
         /n1YVe4huEwnwlZGTfAh2H/+APQwL8/LYEdiGG+fwWchuS5wmrWGw/LIsqknvV6dsGGb
         sP9w==
X-Received: by 10.68.197.66 with SMTP id is2mr20355443pbc.175.1370181958248;
        Sun, 02 Jun 2013 07:05:58 -0700 (PDT)
Received: from localhost.localdomain ([122.164.162.188])
        by mx.google.com with ESMTPSA id aj2sm55150689pbc.1.2013.06.02.07.05.56
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 07:05:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.457.g2410d5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226151>

Another lazy Sunday afternoon.  All of these are trivial.

Thanks.

Ramkumar Ramachandra (6):
  prompt: don't scream continuation state
  completion: add common options for rev-parse
  completion: add common options for blame
  completion: correct completion for format-patch
  completion: clarify difftool completion
  completion: clarify ls-tree, archive, show completion

 contrib/completion/git-completion.bash | 37 +++++++++++++++++++++++++---------
 contrib/completion/git-prompt.sh       | 18 ++++++++---------
 2 files changed, 36 insertions(+), 19 deletions(-)

-- 
1.8.3.457.g2410d5e
