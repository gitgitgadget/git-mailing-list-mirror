From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [PATCH v3 2/2] Ensure consistent usage of mergetool.keepBackup
 in git
Date: Sat, 11 Apr 2009 21:41:48 +0200
Message-ID: <49E0F27C.8070203@pelagic.nl>
References: <f3d401fbaec1556ffbf8c13b83e58849af973a71.1239376248.git.ferry.huberts@pelagic.nl> <9a358c8b6275a7103eb036a2d1d6073bcf191e09.1239376248.git.ferry.huberts@pelagic.nl> <7vljq7dmg2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Aguilar <davvid@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:43:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsj6q-0001Ve-Lo
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbZDKTlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbZDKTlw
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:41:52 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:39724 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753155AbZDKTlw (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 15:41:52 -0400
Received: from [192.168.0.101] (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id BD91C58BD88;
	Sat, 11 Apr 2009 21:41:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vljq7dmg2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116338>

Junio C Hamano wrote:
> Ferry Huberts <ferry.huberts@pelagic.nl> writes:
> 
>> In several places merge.keepBackup is used i.s.o.
>> mergetool.keepBackup. This patch makes it all
>> consistent for git
> 
> A silly question.  The above makes it sound as if both merge.keepBackup
> and mergetool.keepBackup are valid, but the latter is preferred, and your
> patch makes things consistent even though without it there is nothing
> broken per-se.
> 
> Is that really is the case?
> 
> Otherwise, perhaps the title and the message should read like this:
> 
>     Fix misspelled mergetool.keepBackup
>     
>     In several places mergetool.keepBackup was misspelled as merge.keepBackup.
>     
>     Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>

feel free to change it :-)
imho there has been way too much discussion for such a simple patch.
