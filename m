From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] filter-branch: Fix renaming a directory in the tree-filter
Date: Mon, 31 Mar 2008 10:03:54 +0200
Message-ID: <47F09AEA.50806@viscovery.net>
References: <C46D6D0D-44E1-4976-8956-1D84B6351535@yahoo.ca> <1206947655-20272-1-git-send-email-johannes.sixt@telecom.at> <1206947655-20272-2-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: =?UTF-8?B?SmVhbi1GcmFuw6dvaXMgVmVpbGxldHRl?= 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Mon Mar 31 10:05:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgF0k-0001w9-H8
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 10:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbYCaID6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 04:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbYCaID5
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 04:03:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8945 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbYCaID4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 04:03:56 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JgEym-0000Sx-U5; Mon, 31 Mar 2008 10:02:57 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 213126B7; Mon, 31 Mar 2008 10:03:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1206947655-20272-2-git-send-email-johannes.sixt@telecom.at>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78567>

Johannes Sixt schrieb:
> Commit d89c1dfac939623a269f60d4e27e3a2929dca29c replaced a
> 'ls-files | xargs rm' pipeline by 'git clean'. But since 'git clean' does

s/since//

> not recurse and remove directories by default. Now, consider a tree-filter
> that renames a directory.

-- Hannes
