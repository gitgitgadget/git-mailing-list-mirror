From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GIT-GUI FIX)] git-gui: Restore ability to Stage Working
 Copy for conflicts.
Date: Tue, 09 Sep 2008 08:18:40 +0200
Message-ID: <48C61540.8070300@viscovery.net>
References: <200809082037.12173.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 08:19:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcwZq-00049L-Jl
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 08:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbYIIGSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 02:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753743AbYIIGSn
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 02:18:43 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30867 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647AbYIIGSn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 02:18:43 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KcwYj-0004Kc-7r; Tue, 09 Sep 2008 08:18:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DB66A69F; Tue,  9 Sep 2008 08:18:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200809082037.12173.angavrilov@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95337>

Alexander Gavrilov schrieb:
> Tools like rerere leave files marked as conflicts in the index,
> while actually resolving them in the working copy. Also, some
> people like to use an external editor to resolve conflicts.
> 
> This patch restores functionality previously removed in
> commit 617ceee653 by adding a new context menu item.
> It still ensures that the user does not stage conflicting files
> accidentally by clicking on the icon instead of the name.

Thanks! Works well here.

Tested-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes
