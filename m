From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 02/16] t0050: perl portability fix
Date: Thu, 13 Mar 2008 08:38:06 +0100
Message-ID: <47D8D9DE.1050901@viscovery.net>
References: <cover.1205356737.git.peff@peff.net> <20080312213010.GC26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 08:38:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZi1Z-0008Bw-Gn
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 08:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbYCMHiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 03:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYCMHiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 03:38:09 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:4304 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbYCMHiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 03:38:08 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZi0A-0000tj-DF; Thu, 13 Mar 2008 08:37:22 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C7C8E6B7; Thu, 13 Mar 2008 08:38:06 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080312213010.GC26286@coredump.intra.peff.net>
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77048>

Jeff King schrieb:
> Older versions of perl (such as 5.005) don't understand -CO, nor
> do they understand the "U" pack specifier. Instead of using perl,
> let's just printf the binary bytes we are interested in.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Yay! We need this on Windows with MSYS's perl, too. Works great:

Tested-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes
