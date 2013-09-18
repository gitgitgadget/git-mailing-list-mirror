From: Marek Vasut <marex@denx.de>
Subject: [BUG] git clone -q ends with early EOF
Date: Wed, 18 Sep 2013 14:44:18 +0200
Message-ID: <201309181444.19070.marex@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 14:44:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMH7I-0006xy-De
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 14:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab3IRMoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 08:44:20 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:35220 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab3IRMoU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 08:44:20 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cg18y6vn0z4KK2N
	for <git@vger.kernel.org>; Wed, 18 Sep 2013 14:44:18 +0200 (CEST)
X-Auth-Info: 8KSX+Zu1Pn1A8pspaCS+zFpmhLauBsHxanFkrhFUZe0=
Received: from chi.localnet (unknown [195.140.253.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3cg18y5LZszbbhq
	for <git@vger.kernel.org>; Wed, 18 Sep 2013 14:44:18 +0200 (CEST)
User-Agent: KMail/1.13.7 (Linux/3.10-2-amd64; KDE/4.8.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234964>

Hello,

I am trying to clone a repository and I am getting the following output:

$ git clone -q git://kernel.ubuntu.com/ubuntu/linux.git
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed

The "fatal:" lines usually appear a few minutes after running the clone. Of 
course, the clone does not finish successfully. Interestingly, when I drop the 
'-q' option from the git clone commandline, the clone finishes correctly.

My git version is:

$ git --version
git version 1.8.4.rc3

Is this a known issue?

Thank you!

Best regards,
Marek Vasut
