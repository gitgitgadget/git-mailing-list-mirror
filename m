From: Johannes Sixt <j.sixt@viscovery.net>
Subject: git-clean buglet
Date: Wed, 23 Jan 2008 16:14:52 +0100
Message-ID: <479759EC.4010002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 16:15:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHhK5-000551-FZ
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 16:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYAWPO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 10:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbYAWPOz
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 10:14:55 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62362 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbYAWPOz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 10:14:55 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JHhJK-0005m6-Jj
	for git@vger.kernel.org; Wed, 23 Jan 2008 16:14:42 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP id 4140E54D
	for <git@vger.kernel.org>; Wed, 23 Jan 2008 16:14:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71544>

Try this in your favorite git repo:

    git clean -n /

Here, it responds with:

    fatal: oops in prep_exclude

I don't know what the expected behavior should be, but certainly not this.
Maybe just do nothing like 'git ls-files /'.

I'm not familiar with either builtin-clean.c nor dir.c; perhaps someone
else can fix this?

-- Hannes
