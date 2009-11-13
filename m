From: "michele" <michele@mailc.net>
Subject: send an email with logs after push
Date: Fri, 13 Nov 2009 09:46:39 +0100
Message-ID: <1258101999.17624.1345023113@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 09:46:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8ro0-0003xf-IA
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 09:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbZKMIqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 03:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbZKMIqe
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 03:46:34 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:37800 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754168AbZKMIqd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Nov 2009 03:46:33 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BBBC8C0CB4
	for <git@vger.kernel.org>; Fri, 13 Nov 2009 03:46:39 -0500 (EST)
Received: from kvm1.messagingengine.com ([10.202.2.121])
  by compute2.internal (MEProxy); Fri, 13 Nov 2009 03:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:mime-version:content-transfer-encoding:content-type:subject:date; s=smtpout; bh=sIz93f4jLlIldTVuz5YK6UnPcbA=; b=Mu+OzKM6GKO0uUvyU0jh880+NmLBhgV70f9Ti0RHc5Ti+Da84IEcInrbrKOx4f4MBfWZReP2z2n9nsNb0v3UqKPbeh60luYbYiKHAWnSPsuz4EN9XE9j3S4LImhQzpZHwYa088ELnAzwH2eFX2QelO17WT4nZ4921aytvIbquzE=
Received: by kvm1.messagingengine.com (Postfix, from userid 99)
	id D02903E8; Fri, 13 Nov 2009 03:46:39 -0500 (EST)
X-Sasl-Enc: rPzH4nkFh3qsxpPXmi1iirPw6bCJgjnM3uiGLS2LaCzH 1258101999
X-Mailer: MessagingEngine.com Webmail Interface
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132822>

Hi guys, I'm using git for a collaborative development and I'm trying to
implement a notification system. I want to automatically send an email
containing the log of each commit after a push. The email should contain
the titles of the commits done between the previous and the last push.
The push action publish the repository on a public_html directory in one
other machine.

Do you have any suggestion to implement this?

Thanks
