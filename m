From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] t3502: Disambiguate between file and rev by adding --
Date: Mon, 5 Nov 2007 20:17:27 -0500
Message-ID: <2DC3CFEE-ACA0-448F-9957-EB98F299D812@silverinsanity.com>
References: <20071104153126.GA61398@173.242.249.10.in-addr.arpa> <20071105222530.GA4208@steel.home>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 02:17:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpD4d-0007P7-Fp
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 02:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbXKFBRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 20:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755514AbXKFBRc
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 20:17:32 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:58773 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755486AbXKFBRb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 20:17:31 -0500
Received: from [192.168.1.5] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id B2EC11FFC12F;
	Tue,  6 Nov 2007 01:17:29 +0000 (UTC)
In-Reply-To: <20071105222530.GA4208@steel.home>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63608>


On Nov 5, 2007, at 5:25 PM, Alex Riesen wrote:

> Brian Gernhardt, Sun, Nov 04, 2007 16:31:26 +0100:
>> This test failed because git-diff didn't know if it was asking for  
>> the
>> file "a" or the branch "a".  Adding "--" at the end of the ambiguous
>> commands allows the test to finish properly.
>
> To be precise: this is ambiguous only on case-challenged filesystems

Oh.  I just saw the ambiguous error.  Should I re-post with a more  
correct commit message?

~~B
