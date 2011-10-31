From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCHv2] Compile fix for MSVC
Date: Mon, 31 Oct 2011 20:12:41 +0100
Message-ID: <1320088364-25916-1-git-send-email-vfr@lyx.org>
Cc: kusmabite@gmail.com, ramsay@ramsay1.demon.co.uk,
	msysgit@googlegroups.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 20:13:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKxIN-00040U-EF
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 20:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079Ab1JaTNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 15:13:14 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60415 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1JaTNN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 15:13:13 -0400
Received: by eye27 with SMTP id 27so5598224eye.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 12:13:12 -0700 (PDT)
Received: by 10.14.11.4 with SMTP id 4mr1401386eew.79.1320088392459;
        Mon, 31 Oct 2011 12:13:12 -0700 (PDT)
Received: from localhost.localdomain (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id d6sm25272860eec.10.2011.10.31.12.13.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Oct 2011 12:13:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184512>

This is a re-roll of the patch series sent to the list 
on 21-10-2011.

This time the lines are not wrapped and the commit messages
are updated with changes from me and Junio.

[PATCH 1/3] Compile fix for MSVC: Do not include sys/resources.h
[PATCH 2/3] Compile fix for MSVC: Include <io.h>
[PATCH 3/3] MSVC: Remove unneeded header stubs
