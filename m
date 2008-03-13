From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 01/16] tr portability fixes
Date: Thu, 13 Mar 2008 08:32:37 +0100
Message-ID: <47D8D895.4030309@viscovery.net>
References: <cover.1205356737.git.peff@peff.net> <20080312212957.GB26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 08:33:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZhwG-000717-1I
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 08:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbYCMHcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 03:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbYCMHcl
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 03:32:41 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:3790 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924AbYCMHck (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 03:32:40 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZhuq-0000fJ-TI; Thu, 13 Mar 2008 08:31:53 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4ECFF6B7; Thu, 13 Mar 2008 08:32:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080312212957.GB26286@coredump.intra.peff.net>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77045>

Jeff King schrieb:
> We can mostly get around this by just using the bracket form
> for both sets, as in:
> 
>   tr '[A-Z] '[a-z]'
> 
> in which case POSIX interpets this as "'[' becomes '['",
> which is OK.
> 
> However, this doesn't work with multiple sequences, like:
> 
>   # rot13
>   tr '[A-Z][a-z]' '[N-Z][A-M][n-z][a-m]'

Not that it matters a lot, but I wonder whether

   tr '[A-M][N-Z][a-m][n-z]' '[N-Z][A-M][n-z][a-m]'

would have done the trick.

-- Hannes
