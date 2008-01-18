From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with NO_MMAP
Date: Fri, 18 Jan 2008 08:53:44 +0100
Message-ID: <47905B08.4040302@viscovery.net>
References: <20080118035700.GA3458@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Charles Bailey <charles@hashpling.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 08:54:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFm3V-0006U9-Ds
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 08:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbYARHx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 02:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbYARHx4
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 02:53:56 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:9369 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbYARHxz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 02:53:55 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JFm2k-0005Z9-AC; Fri, 18 Jan 2008 08:53:38 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3E63E69F; Fri, 18 Jan 2008 08:53:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080118035700.GA3458@spearce.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70971>

Shawn O. Pearce schrieb:
>  This should do the trick.  I SOB'd the patch as I did test it with
>  NO_MMAP and I think its valid.  :-)

Thanks a lot. It works here on Windows, too.

-- Hannes
