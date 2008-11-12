From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Cached the git configuration, which is now noticibly
 faster on windows.
Date: Tue, 11 Nov 2008 16:50:17 -0800
Message-ID: <7vzlk5u5rq.fsf@gitster.siamese.dyndns.org>
References: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
 <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
 <7vr65kagvm.fsf@gitster.siamese.dyndns.org> <200811101046.01543.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Han-Wen Nienhuys" <hanwen@google.com>,
	John Chapman <thestar@fussycoder.id.au>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Wed Nov 12 01:52:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L03y2-0002Th-7M
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 01:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800AbYKLAvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 19:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753637AbYKLAvE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 19:51:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbYKLAvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 19:51:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8745996398;
	Tue, 11 Nov 2008 19:51:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BF95F9638A; Tue,
 11 Nov 2008 19:50:19 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FA13A230-B053-11DD-B09F-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100704>

Simon Hausmann <simon@lst.de> writes:

> On Sunday 09 November 2008 Junio C Hamano, wrote:
>> These are patches to fast-import/git-p4, which you two seem to in charge
>> of.
>>
>>     From:	John Chapman <thestar@fussycoder.id.au>
>>     Subject: [PATCH 1/2] Added support for purged files and also optimised
>> memory usage. Date:	Sat,  8 Nov 2008 14:22:48 +1100
>>     Message-Id: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
>>
>>     From:	John Chapman <thestar@fussycoder.id.au>
>>     Subject: [PATCH 2/2] Cached the git configuration, which is now
>> noticibly faster on windows. Date:	Sat,  8 Nov 2008 14:22:49 +1100
>>     Message-Id: <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
>>
>> It was unfortunately not immediately obvious from the Subject: line what
>> these patches are about, and I am guessing you missed them because of that.
>
> Ack on both patches. The second one could be done better, as suggested
> in the follow-ups, but both are clearly an improvement :)

Thanks, both of you.  Will apply.
