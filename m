From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/8] Sequencer Foundations
Date: Wed, 11 May 2011 13:30:14 +0530
Message-ID: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 11 18:29:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKCI8-0000mR-1w
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544Ab1EKQ3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 12:29:17 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:10429 "EHLO
	smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756065Ab1EKQ3O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 12:29:14 -0400
X-IronPort-AV: E=Sophos;i="4.64,351,1301875200"; 
   d="scan'208";a="77409706"
Received: from smtp-in-1105.vdc.amazon.com ([10.140.9.24])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 May 2011 08:01:50 +0000
Received: from ramkum.desktop.amazon.com (ramkum.desktop.amazon.com [172.25.205.64])
	by smtp-in-1105.vdc.amazon.com (8.13.8/8.13.8) with ESMTP id p4B81n65024888;
	Wed, 11 May 2011 08:01:49 GMT
Received: by ramkum.desktop.amazon.com (Postfix, from userid 272482)
	id 85C27754832; Wed, 11 May 2011 13:30:22 +0530 (IST)
X-Mailer: git-send-email 1.7.5.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173408>

Hi,

I've not attempted to add anything new in this series -- It merely
fixes all the mistakes in the previous iteration.  I've tried to
integrate the improvements suggested by all the previous reviews.

The format of the instruction sheet hasn't changed yet, but will soon
change to the one suggested by Chistian.  There are some nits I'm not
happy with in certain patches -- I've sprinkled those comments into
the individual patches.  All tests pass in all patches, and I hope no
stray lines have travelled b/w the patches during the rebase.

Thanks for reading.

Ramkumar Ramachandra (8):
  revert: Improve error handling by cascading errors upwards
  revert: Make "commit" and "me" local variables
  revert: Introduce a struct to parse command-line options into
  revert: Separate cmdline argument handling from the functional code
  revert: Catch incompatible command-line options early
  revert: Introduce head, todo, done files to persist state
  revert: Implement parsing --continue, --abort and --skip
  revert: Implement --abort processing

 advice.c         |   14 ++
 advice.h         |    1 +
 builtin/revert.c |  578 +++++++++++++++++++++++++++++++++++++++---------------
 3 files changed, 437 insertions(+), 156 deletions(-)

-- 
1.7.5.GIT
