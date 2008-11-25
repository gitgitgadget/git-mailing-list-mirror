From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] rev-parse: Fix shell scripts whose cwd is a symlink into
 a git work-dir
Date: Tue, 25 Nov 2008 08:30:32 +0100
Message-ID: <492BA998.5050106@viscovery.net>
References: <cover.1226759762.git.marcel@oak.homeunix.org> <1227389614-10946-1-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 08:32:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4sOz-0005yb-Gz
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 08:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbYKYHau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 02:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbYKYHau
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 02:30:50 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35393 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYKYHat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 02:30:49 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L4sNV-0002fp-B3; Tue, 25 Nov 2008 08:30:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id ECF4169F; Tue, 25 Nov 2008 08:30:32 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1227389614-10946-1-git-send-email-marcel@oak.homeunix.org>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa01.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Marcel M. Cary schrieb: > * Change "git rev-parse --show-cdup"
	to print a full path instead of > a series of "../" when it prints anything
	http://thread.gmane.org/gmane.comp.version-control.git/88557/focus=88562
	[...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101651>

Marcel M. Cary schrieb:
> * Change "git rev-parse --show-cdup" to print a full path instead of
>   a series of "../" when it prints anything

http://thread.gmane.org/gmane.comp.version-control.git/88557/focus=88562

I don't see that you bring in any new arguments.

-- Hannes
