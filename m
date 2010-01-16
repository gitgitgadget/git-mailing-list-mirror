From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 0/2] Show submodules as modified when they contain a dirty
 work tree
Date: Sat, 16 Jan 2010 18:39:55 +0100
Message-ID: <4B51F9EB.5090202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 18:40:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWCdq-00049Q-Rm
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 18:40:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079Ab0APRkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 12:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754832Ab0APRkv
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 12:40:51 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:45613 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab0APRku (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 12:40:50 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 45C7914C0952D;
	Sat, 16 Jan 2010 18:39:58 +0100 (CET)
Received: from [80.128.127.37] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NWCcu-0006Wv-00; Sat, 16 Jan 2010 18:39:56 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/W7X/hmSV2LY+oJT4/8y91JE3HusVfaRCoeRDZ
	SSBnhg7DXQP+5316NTxVeS6PTTNz/dXoOfKLnxmaW/rmv2c0GT
	gdzrjbx0eD7MI8BXtzdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137238>

Here is the updated version of the two patches.

This fixes all issues raised and passes the test suite.


Jens Lehmann (1):
  Show submodules as modified when they contain a dirty work tree

Junio C Hamano (1):
  Teach diff that modified submodule directory is dirty

 diff-lib.c                  |    8 +++-
 diff.c                      |    9 ++++-
 submodule.c                 |   49 +++++++++++++++++++++++++
 submodule.h                 |    1 +
 t/t4027-diff-submodule.sh   |   84 ++++++++++++++++++++++++++++++++++++++++++-
 t/t7506-status-submodule.sh |   83 ++++++++++++++++++++++++++++++++++--------
 6 files changed, 214 insertions(+), 20 deletions(-)
