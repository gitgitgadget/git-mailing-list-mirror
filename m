From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] rebase -i continue: Don't skip submodule only commits
Date: Wed, 11 Apr 2012 20:23:16 +0200
Message-ID: <4F85CC14.6060106@web.de>
References: <1333794053-22226-1-git-send-email-john@keeping.me.uk> <7vpqbgtv4l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 20:23:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI2CR-0004mX-MA
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 20:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932782Ab2DKSXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 14:23:18 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:38494 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932709Ab2DKSXS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 14:23:18 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate04.web.de (Postfix) with ESMTP id A7A7975C70D3
	for <git@vger.kernel.org>; Wed, 11 Apr 2012 20:23:16 +0200 (CEST)
Received: from [192.168.178.48] ([91.3.193.239]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LlWVj-1RhsEV1VCh-00bGlH; Wed, 11 Apr 2012 20:23:16
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <7vpqbgtv4l.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:jX5xJ2EEG5RGh/Zp+09138bGP6OZP/ek6wad6DGpT74
 gty3yXsCYJTGbdcdzafIuGKBY1D8zpZz48HGdCYVvzfOBL0LUi
 uOVqUMEaRQRboU/8rKOlFPOb47tBZWy/u8McqP4E71VQ5lbF+o
 bG7yP2OPr5i1XFqXHwWsHm1x+1JSFoT2ufRsEKha8byqP+rvmq
 VVnf5yop8qbx3BK57scmw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195231>

Am 10.04.2012 00:09, schrieb Junio C Hamano:
> John Keeping <john@keeping.me.uk> writes:
> 
>> When git-rebase--interactive stops due to a conflict and the only change
>> to be committed is in a submodule, the test for whether there is
>> anything to be committed ignores the staged submodule change.  This
>> leads rebase to skip creating the commit for the change.
>>
>> While unstaged submodule changes should be ignored to avoid needing to
>> update submodules during a rebase, it is safe to remove the
>> --ignore-submodules option to diff-index because --cached ensures that
>> it is only checking the index.  This was discussed in [1] and a test is
>> included to ensure that unstaged changes are still ignored correctly.
>>
>> [1] http://thread.gmane.org/gmane.comp.version-control.git/188713
>>
>> Signed-off-by: John Keeping <john@keeping.me.uk>
>> ---
> 
> Very well explained and sensible.

An obvious Ack from me and many thanks to John for providing the test
cases I didn't find the time to write!
