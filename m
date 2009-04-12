From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [PATCH v3 2/2] Ensure consistent usage of mergetool.keepBackup
 in git
Date: Sun, 12 Apr 2009 09:04:02 +0200
Message-ID: <49E19262.7090802@pelagic.nl>
References: <f3d401fbaec1556ffbf8c13b83e58849af973a71.1239376248.git.ferry.huberts@pelagic.nl> <9a358c8b6275a7103eb036a2d1d6073bcf191e09.1239376248.git.ferry.huberts@pelagic.nl> <7vljq7dmg2.fsf@gitster.siamese.dyndns.org> <49E0F27C.8070203@pelagic.nl> <49E0F33B.8070806@pelagic.nl> <7v4owvdju6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Aguilar <davvid@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 09:08:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LstnM-0004g9-Iz
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 09:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbZDLHEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 03:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbZDLHEH
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 03:04:07 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:50814 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754609AbZDLHEG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Apr 2009 03:04:06 -0400
Received: from [192.168.0.101] (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id E859358BD9F;
	Sun, 12 Apr 2009 09:04:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7v4owvdju6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116369>

Junio C Hamano wrote:
> "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl> writes:
> 
>> Ferry Huberts (Pelagic) wrote:
>>> Junio C Hamano wrote:
>>>> Ferry Huberts <ferry.huberts@pelagic.nl> writes:
>>>>
>>>>> In several places merge.keepBackup is used i.s.o.
>>>>> mergetool.keepBackup. This patch makes it all
>>>>> consistent for git
>>>> A silly question.  The above makes it sound as if both merge.keepBackup
>>>> and mergetool.keepBackup are valid, but the latter is preferred, and your
>>>> patch makes things consistent even though without it there is nothing
>>>> broken per-se.
>>>>
>>>> Is that really is the case?
>>>>
>>>> Otherwise, perhaps the title and the message should read like this:
>>>>
>>>>     Fix misspelled mergetool.keepBackup
>>>>     
>>>>     In several places mergetool.keepBackup was misspelled as merge.keepBackup.
>>>>     
>>>>     Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>
>>> feel free to change it :-)
> 
> Notice that I didn't follow the discussion closely, and I am asking if
> this is a "bugfix" or "changing for consistency even though there is no
> breakage".
> 

it's the latter.
summary: docs say mergetool.keepBackup. code does merge.keepBackup
