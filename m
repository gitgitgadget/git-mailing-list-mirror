From: Johannes Sixt <j.sixt@viscovery.net>
Subject: --first-parent plus path limiting
Date: Tue, 29 Jan 2008 09:29:57 +0100
Message-ID: <479EE405.1010001@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 09:30:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJlrW-0003Xb-Rf
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 09:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753199AbYA2IaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 03:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbYA2IaD
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 03:30:03 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:11704 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbYA2IaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 03:30:00 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JJlqi-0002xE-1a; Tue, 29 Jan 2008 09:29:44 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7E43F6D9; Tue, 29 Jan 2008 09:29:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71964>

While trying to find out when builtin-fetch.c was merged into master, I
noticed that this:

$ git log --first-parent --pretty=oneline -- builtin-fetch.c

lists b888d61c (Make fetch a builtin), which I did not expect. This one
doesn't list it, as expected:

$ git log --first-parent --pretty=oneline

-- Hannes
