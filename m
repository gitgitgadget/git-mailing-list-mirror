From: Jake Goulding <goulding@vivisimo.com>
Subject: Re: [PATCH 2/3] Make has_commit non-static
Date: Tue, 03 Feb 2009 10:08:58 -0500
Message-ID: <49885E0A.4000707@vivisimo.com>
References: <1232979205-17161-1-git-send-email-goulding@vivisimo.com> <1232979205-17161-2-git-send-email-goulding@vivisimo.com> <alpine.DEB.1.00.0901261637300.25749@intel-tinevez-2-302> <7vk58fnp63.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 16:14:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUMww-0007Nf-Hu
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 16:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbZBCPLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 10:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbZBCPLF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 10:11:05 -0500
Received: from scalix.vivisimo.com ([207.97.211.28]:41607 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbZBCPLE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 10:11:04 -0500
Received: from mail.office.vivisimo.com (mail.office.vivisimo.com [206.210.75.84])
	by mail.vivisimo.com (Postfix) with ESMTP id E015B85088B;
	Tue,  3 Feb 2009 10:11:02 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.office.vivisimo.com (Postfix) with ESMTP id AC3062E68D6;
	Tue,  3 Feb 2009 10:11:02 -0500 (EST)
X-Virus-Scanned: amavisd-new at vivisimo.com
Received: from mail.office.vivisimo.com ([127.0.0.1])
	by localhost (mail.office.vivisimo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q5pflgqP9Xer; Tue,  3 Feb 2009 10:11:02 -0500 (EST)
Received: from [192.168.0.20] (jpg-melchior.vivisimo.com [192.168.0.20])
	by mail.office.vivisimo.com (Postfix) with ESMTP id B642C2E68D8;
	Tue,  3 Feb 2009 10:08:58 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7vk58fnp63.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108197>

Thanks for changing that for me - I lost track of this in other work!

-Jake

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Mon, 26 Jan 2009, Jake Goulding wrote:
>>
>>> Moving has_commit from branch to a common location in preparation for 
>>> using it in tag. Renaming it to commit_has_any_in_commit_list to be more 
>>> unique.
>> I feel like bike-shedding for a change, and I'd also like to prove that 
>> not all Germans like long names:
>>
>> 	is_ancestor_of_any()
> 
> I'll queue this after munging it to "is_descendant_of()".
> 
> Thanks.
