From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GIT-GUI,GITK) 6/8] gitk: Port new encoding logic from
 git-gui.
Date: Mon, 22 Sep 2008 11:18:36 +0200
Message-ID: <48D762EC.2030009@viscovery.net>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <200809221201.35507.angavrilov@gmail.com> <48D7554C.4020601@viscovery.net> <200809221302.52424.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 11:19:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khha7-0001xi-8F
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 11:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbYIVJSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 05:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbYIVJSj
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 05:18:39 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:37902 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbYIVJSi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 05:18:38 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KhhYz-0006vP-1a; Mon, 22 Sep 2008 11:18:37 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C57136EF; Mon, 22 Sep 2008 11:18:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200809221302.52424.angavrilov@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96467>

Alexander Gavrilov schrieb:
> You can also try applying this patch (originally made for git-gui). It may save
> additional 0.3 sec, especially for obscure legacy encodings.

Is this about startup time? Personally, I don't care about 0.3 sec startup
time. I close my primary gitk and git-gui Windows only once a week. ;-)

-- Hannes
