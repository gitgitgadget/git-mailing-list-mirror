From: Johannes Sixt <j.sixt@viscovery.net>
Subject: git -p does not detect a bare repository
Date: Wed, 13 Aug 2008 15:51:21 +0200
Message-ID: <48A2E6D9.5000609@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 15:52:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTGm4-0001zN-Ua
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 15:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751861AbYHMNv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 09:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbYHMNv0
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 09:51:26 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:14095 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbYHMNvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 09:51:25 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KTGl0-0007ZA-0z; Wed, 13 Aug 2008 15:51:22 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C7A7C4FB; Wed, 13 Aug 2008 15:51:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92216>

If $PWD is a bare repository, is it expected behavior that

  $ git diff-tree master^ master

works as expected, but

  $ git -p diff-tree master^ master

errors out:

  fatal: ambiguous argument 'master^': unknown revision or path blabla...

-- Hannes
