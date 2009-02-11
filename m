From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Disable filemode rebase tests in t3400-rebase.sh if no
 	filesystem mode support
Date: Wed, 11 Feb 2009 12:30:13 +0100
Message-ID: <4992B6C5.3010609@viscovery.net>
References: <81b0412b0902110151x35fbbb4esb9efefae2e1fe90a@mail.gmail.com>	 <4992A3DF.4010707@viscovery.net> <81b0412b0902110253g2288419eha4037f22f6286ea4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 12:32:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXDJt-00017d-NM
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 12:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbZBKLab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 06:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753870AbZBKLaa
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 06:30:30 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:49249 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbZBKLaa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 06:30:30 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LXDIH-0001z1-6v; Wed, 11 Feb 2009 12:30:24 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 833B06EF; Wed, 11 Feb 2009 12:30:13 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <81b0412b0902110253g2288419eha4037f22f6286ea4@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109410>

Alex Riesen schrieb:
> 2009/2/11 Johannes Sixt <j.sixt@viscovery.net>:
>> Alex Riesen schrieb:
>>> I'm honestly sorry for my contributions. They seem to be exclusively
>>> in the "make Git work in Windows" area.  Depressing.
>>>
>>>  t/t3400-rebase.sh |    5 +++++
>>>  1 files changed, 5 insertions(+), 0 deletions(-)
>> Very interesting. This test works unmodified here. On the other hand, I
>> have to skip the entire t4129-apply-samemode.sh.
>>
> 
> hmm... These seem to work here. I have to use Cygwin. Do you use the
> native port?

Yes. And the reason why the test does not fail here is because the mode
change is outright ignored, and the test doesn't check whether the result
meets the expectations.

-- Hannes
