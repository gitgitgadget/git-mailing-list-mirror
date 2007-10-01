From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/5] fork/exec removal series
Date: Mon, 01 Oct 2007 09:07:51 +0200
Message-ID: <47009CC7.70300@viscovery.net>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0709302212160.28395@racer.site> <200709302334.37129.johannes.sixt@telecom.at> <Pine.LNX.4.64.0709302242100.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 09:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcFNu-0005Sl-7L
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 09:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbXJAHH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 03:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbXJAHH6
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 03:07:58 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:23880 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbXJAHH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 03:07:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IcFNf-0008Ss-Vl; Mon, 01 Oct 2007 09:07:52 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 14E1B546; Mon,  1 Oct 2007 09:07:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709302242100.28395@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59582>

Johannes Schindelin schrieb:
> On Sun, 30 Sep 2007, Johannes Sixt wrote:
>> These cases I hope to be able to treat as "coroutine":
>>
>> - sideband demultiplexer in builtin-fetch-pack.c
>> - internal rev-list in upload-pack
>> - the two-way pipe handling in convert.c and builtin-upload-archive.c
>>
>> There are probably more in daemon.c and imap-send.c.
>>
>> BTW, the convert.c case (apply_filter) is most interesting for me, since I 
>> have a real-world use-case for a clean-filter.
> 
> Calling it coroutine is interesting... But yes, I agree that these three 
> cases cannot be handled otherwise.

Suggestions for a better name are appreciated!

-- Hannes
