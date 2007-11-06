From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3502: Disambiguate between file and rev by adding --
Date: Mon, 05 Nov 2007 17:20:11 -0800
Message-ID: <7vabpskw50.fsf@gitster.siamese.dyndns.org>
References: <20071104153126.GA61398@173.242.249.10.in-addr.arpa>
	<20071105222530.GA4208@steel.home>
	<2DC3CFEE-ACA0-448F-9957-EB98F299D812@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 02:20:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpD7O-0007x0-90
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 02:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756740AbXKFBUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 20:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756730AbXKFBUT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 20:20:19 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47095 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756713AbXKFBUS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 20:20:18 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2B23B2F0;
	Mon,  5 Nov 2007 20:20:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 60F3992A93;
	Mon,  5 Nov 2007 20:20:35 -0500 (EST)
In-Reply-To: <2DC3CFEE-ACA0-448F-9957-EB98F299D812@silverinsanity.com> (Brian
	Gernhardt's message of "Mon, 5 Nov 2007 20:17:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63609>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On Nov 5, 2007, at 5:25 PM, Alex Riesen wrote:
>
>> Brian Gernhardt, Sun, Nov 04, 2007 16:31:26 +0100:
>>> This test failed because git-diff didn't know if it was asking for
>>> the
>>> file "a" or the branch "a".  Adding "--" at the end of the ambiguous
>>> commands allows the test to finish properly.
>>
>> To be precise: this is ambiguous only on case-challenged filesystems
>
> Oh.  I just saw the ambiguous error.  Should I re-post with a more
> correct commit message?

This is what I wrote but haven't pushed out (I will have to tend
other topics first):

commit 9f12bec4386fc96e5b617268822cbb75e4c76101
Author: Brian Gernhardt <benji@silverinsanity.com>
Date:   Sun Nov 4 10:31:26 2007 -0500

    t3502: Disambiguate between file and rev by adding --
    
    On a case insensitive file system, this test fails because git-diff
    doesn't know if it is asking for the file "A" or the tag "a".
    
    Adding "--" at the end of the ambiguous commands allows the test to
    finish properly.
    
    Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
