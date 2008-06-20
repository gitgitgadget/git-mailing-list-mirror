From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-gui: Fix accidental staged state toggle when clicking
 top pixel row
Date: Fri, 20 Jun 2008 17:26:48 +0200
Message-ID: <485BCC38.1000403@viscovery.net>
References: <1213973895-10264-1-git-send-email-richard.quirk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Richard Quirk <richard.quirk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 17:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9iWi-0003uC-9A
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 17:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156AbYFTP0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 11:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755972AbYFTP0v
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 11:26:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:65411 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754887AbYFTP0u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 11:26:50 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K9iVl-0001yL-4b; Fri, 20 Jun 2008 17:26:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C44934FB; Fri, 20 Jun 2008 17:26:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1213973895-10264-1-git-send-email-richard.quirk@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85652>

Richard Quirk schrieb:
> If a text widget is asked the index at x,y with y == 0 or y == 1 it will
> always return 1.0 as the nearest index, regardless of the x position.
> 
> This means that clicking the top 2 pixels of the Unstaged/Staged Changes
> lists caused the state of the file there to be toggled. This patch
> checks that the pixel clicked is greater than 1, so there is less chance
> of accidentally staging or unstaging changes.

Ah, that would explain why it sometimes happened that a file was staged
even though the mouse pointer was no where near the icon!

-- Hannes
