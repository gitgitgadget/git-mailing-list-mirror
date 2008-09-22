From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GIT-GUI)] git-gui: Reenable staging unmerged files by
 clicking the icon.
Date: Mon, 22 Sep 2008 09:31:03 +0200
Message-ID: <48D749B7.9030305@viscovery.net>
References: <200809201219.18630.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 09:32:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khfu4-00006t-EN
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 09:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbYIVHbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 03:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbYIVHbG
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 03:31:06 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:29947 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbYIVHbF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 03:31:05 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Khfss-0001uu-Jj; Mon, 22 Sep 2008 09:31:02 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 609136EF; Mon, 22 Sep 2008 09:31:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200809201219.18630.angavrilov@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96452>

Alexander Gavrilov schrieb:
> This restores functionality of the file icon for unmerged files.
> Safety is enforced by loading the diff and checking for lines
> that look like conflict markers. If such lines are found, or
> the conflict involves deletion and/or symlinks, a confirmation
> dialog is presented. Otherwise, the icon immediately stages the
> working copy version of the file.
> 
> Includes a revert of 2fe5b2ee42897a3acc78e5ddaace3775eb2713ca
> (Restore ability to Stage Working Copy for conflicts)

Thanks, works fine after a brief test:

Tested-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes
