From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-gui: Help identify aspell version on Windows too
Date: Fri, 26 Sep 2008 17:06:53 +0200
Message-ID: <48DCFA8D.7080905@viscovery.net>
References: <1222378282-21757-1-git-send-email-hendeby@isy.liu.se> <48DC815C.6030401@viscovery.net> <48DCA5F3.4090009@isy.liu.se> <48DCAC08.9060004@viscovery.net> <20080926143119.GX3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Gustaf Hendeby <hendeby@isy.liu.se>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 17:08:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjEvP-0002CW-Um
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 17:08:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923AbYIZPG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 11:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbYIZPG6
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 11:06:58 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57581 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbYIZPG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 11:06:58 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KjEuE-0007IM-BK; Fri, 26 Sep 2008 17:06:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0C5E26B7; Fri, 26 Sep 2008 17:06:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080926143119.GX3669@spearce.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96864>

Shawn O. Pearce schrieb:
> Johannes Sixt <j.sixt@viscovery.net> wrote:
>> My situation is this: I fire up git-gui, and because I have some stale
>> .git/GITGUI_MSG file, the commit message box is not empty. Aspell begins
>> its work, and git-gui correctly marks spelling mistakes in the first line.
>> Even if I type new text, delete old text, or change the whole text by
>> clicking "Amend", no new spelling mistakes are marked for the whole session.
> 
> Hmm.  Sounds to me like aspell crashes and dies after a while.
> 
> When aspell terminates on its own git-gui doesn't try to restart it.
> I've never seen it abort on my Mac, or my Linux systems.  Or even
> on Windows when I was using the Cygwin version of aspell.

No, it does not abort. It's still running, but sitting there idly.

-- Hannes
