From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-clean: Fix error message if clean.requireForce is
 not  set.
Date: Mon, 12 Nov 2007 09:41:03 +0100
Message-ID: <4738119F.2030901@viscovery.net>
References: <47380E77.9040205@viscovery.net> <20071112083352.GA20482@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 09:41:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrUrL-0001sw-OT
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 09:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbXKLIlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 03:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbXKLIlN
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 03:41:13 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56841 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbXKLIlM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 03:41:12 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IrUqT-000882-IP; Mon, 12 Nov 2007 09:40:38 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7298E54D; Mon, 12 Nov 2007 09:41:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071112083352.GA20482@artemis.corp>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64577>

Pierre Habouzit schrieb:
> On Mon, Nov 12, 2007 at 08:27:35AM +0000, Johannes Sixt wrote:
>> It was distracting to see this error message:
>>
>>     clean.requireForce set and -n or -f not given; refusing to clean
>>
>> even though clean.requireForce was not set at all. This patch 
>> distinguishes
>> the cases and gives a different message depending on whether the
>> configuration variable is not set or set to true.
> 
>   Note that your patch won't apply to next as is :)

You mean because of the builtinification of git-clean? I was hoping that 
Shawn (Bohrer) is listening and will update his patch. ;) It has the same 
problem.

-- Hannes
