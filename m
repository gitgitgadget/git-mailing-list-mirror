From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 0/8] Doc updates to config, format-patch, show-branch
Date: Thu, 23 Apr 2009 02:37:54 -0700
Message-ID: <1240479482-31366-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 11:39:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwvPI-0000xq-SY
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbZDWJiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbZDWJiI
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:38:08 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:7604 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbZDWJiG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:38:06 -0400
Received: by rv-out-0506.google.com with SMTP id f9so392313rvb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 02:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=3aajRYPb6ZI25w4jMeqRjZ0Rp4C766wG8NOkpFNrmBs=;
        b=cCFI33M4o75XbRAzSgNBcaG9fiqv1r9FURC3wEp8WYt3gk0Ls7XdK25gSH2aSKOOvf
         3h7yXRNwNSxddyZwV/ZvquSo3an3xnT+6Wz/Ua7d3GT+3xfU2FV5hvAuVMSNA8HbvUnR
         74Nnd5jVP0pW+opZwS1lhfXd2Q9+U8RCgyOzE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=G4coYxdf4SxOAMwtT1Y80fIRWvMIe/DKYILvXSeyxwmn29rCAmphJGfKxg5bTlgYdu
         AECmzjC/BVj28Bh8/G7lcZjdwlwIg5H70uOBkfjZEbDap7rywiiKHhPzZlaQUjCqH0di
         j5jQHxJPW1XmRlEZNO8n87eBQbQvDWIqeCcCE=
Received: by 10.141.37.8 with SMTP id p8mr265875rvj.35.1240479485951;
        Thu, 23 Apr 2009 02:38:05 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id g31sm2921351rvb.19.2009.04.23.02.38.03
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 02:38:05 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 23 Apr 2009 02:38:02 -0700
X-Mailer: git-send-email 1.6.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117315>

I've tried to order these from least to most controversial.

The first 3 are small fixups. The fourth patch is a quoting fixup. The
fifth patch is a patch I sent a few weeks ago which flew under the radar.
The last 3 patches are some updates to the config.txt documentation.
I've split them up into seperate patches so they can easily be left out
if not wanted.

Stephen Boyd (8):
  config.txt: remove pointer to SubmittingPatches
  config.txt: add missing format.{subjectprefix,cc,attach} variables
  Documentation: use lowercase for shallow and deep threading
  git-show-branch.txt: cleanup example description
  git-format-patch.txt: general rewordings and cleanups
  config.txt: add missing 'the's and make words plural
  config.txt: clarify sentences in the configuration and syntax sections
  config.txt: Make configuration paragraph more consistent

 Documentation/config.txt           |   68 +++++++++++++++++++++--------------
 Documentation/git-format-patch.txt |   42 +++++++++++-----------
 Documentation/git-show-branch.txt  |    7 ++--
 3 files changed, 66 insertions(+), 51 deletions(-)
