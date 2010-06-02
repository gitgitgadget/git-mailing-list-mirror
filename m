From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 0/5] miscellaneous test suite fixes
Date: Tue,  1 Jun 2010 19:13:39 -0500
Message-ID: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 02:14:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJbbG-0007mc-Rk
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 02:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757353Ab0FBAOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 20:14:23 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50204 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488Ab0FBAOV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 20:14:21 -0400
Received: by mail.nrlssc.navy.mil id o520E3tV007893; Tue, 1 Jun 2010 19:14:03 -0500
X-OriginalArrivalTime: 02 Jun 2010 00:14:03.0068 (UTC) FILETIME=[81B9F7C0:01CB01E8]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148176>

Identified by testing on IRIX 6.5, Solaris 5.7, and 5.10

Brandon Casey (5):
  t/t5800: skip if python version is older than 2.5
  git-request-pull.sh: remove -e switch to shell interpreter which
    breaks ksh
  t/t5150: remove space from sed script
  t/t7006: ignore return status of shell's unset builtin
  t/aggregate-results: accomodate systems with small max argument list
    length

 git-request-pull.sh       |    2 +-
 t/Makefile                |    4 +++-
 t/aggregate-results.sh    |    2 +-
 t/t5150-request-pull.sh   |    4 ++--
 t/t5800-remote-helpers.sh |    4 ++--
 t/t7006-pager.sh          |   10 +++++-----
 t/test-lib.sh             |    9 +++++++++
 7 files changed, 23 insertions(+), 12 deletions(-)
