From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GIT-GUI) 1/8] git-gui: Don't allow staging files with
 conflicts.
Date: Mon, 08 Sep 2008 14:10:06 +0200
Message-ID: <48C5161E.3020402@viscovery.net>
References: <200808310052.21595.angavrilov@gmail.com> <200808310054.19732.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 14:12:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcfaI-00077E-NB
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 14:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbYIHMKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 08:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbYIHMKE
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 08:10:04 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30569 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbYIHMKD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 08:10:03 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KcfZ9-0007ht-JT; Mon, 08 Sep 2008 14:09:59 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6E0166B7; Mon,  8 Sep 2008 14:09:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200808310054.19732.angavrilov@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95242>

Alexander Gavrilov schrieb:
> Prevent staging files with conflict markers by clicking
> on the icon in the 'Unstaged Changes' list. Instead, pretend
> that the user clicked the name, and show the diff.
> 
> Originally it made some sense to allow staging conflicting
> files, because git-gui did not provide any tools to resolve
> them from within the GUI. But now that I'm adding mergetool
> capabilities, it is more likely to cause accidental and
> non-undoable errors.

I know I'm a bit late... I just got the first impression of the
consequences of this patch. And I don't like them.

I did a merge with conflicts, and the result was resolved to my liking by
rerere. (And even if rerere did not kick in - I'd have resolved the
conflicts in an external editor anyway.) Now I want to stage the file -
but I can't. :-(

No, I can't "Run merge tool", because I don't have one.
No, I don't want to "Use remote version" or "Use local version" or "Revert
to base".
Yes, I want to stage the file _as_is_!!

Please help.

-- Hannes
