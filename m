From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Thu, 23 Oct 2008 15:03:31 +0200
Message-ID: <49007623.1060606@viscovery.net>
References: <gdok16$vh2$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 15:04:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kszrr-0003Hu-Fd
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 15:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbYJWNDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 09:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbYJWNDe
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 09:03:34 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:6701 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbYJWNDd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 09:03:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kt1im-0001K8-FP; Thu, 23 Oct 2008 17:03:32 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8CED4AFCC; Thu, 23 Oct 2008 15:03:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <gdok16$vh2$1@ger.gmane.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98960>

Giuseppe Bilotta schrieb:
> Zit will create a directory .zit.file to hold a git repository
> tracking the single file .zit.file/file, which is just a hard link to
> file.

git breaks hard links, mind you! (Just in case you check out older
versions and you wonder why your "real" file is not updated).

But there's a recent patch by Dscho floating around that takes care of the
hard link case.

-- Hannes
