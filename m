From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: who's on first? - following first parent and merge-management
Date: Fri, 09 Mar 2012 13:05:38 +0100
Message-ID: <4F59F212.6030701@ira.uka.de>
References: <jj6s47$m98$1@dough.gmane.org> <7vwr6woo8p.fsf@alter.siamese.dyndns.org> <7vty1zfwmd.fsf@alter.siamese.dyndns.org> <20120308071403.GE7643@sigill.intra.peff.net> <4F5867D4.1010904@viscovery.net> <7vpqcndmpa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 13:05:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5yZk-0005Ht-Oy
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 13:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab2CIMF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 07:05:26 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:40525 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754456Ab2CIMFH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 07:05:07 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1S5yYu-0004gb-4R; Fri, 09 Mar 2012 13:04:59 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1S5yYt-00034G-Va; Fri, 09 Mar 2012 13:04:44 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <7vpqcndmpa.fsf@alter.siamese.dyndns.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1331294699.131471000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192713>

On 08.03.2012 18:30, Junio C Hamano wrote:
> Johannes Sixt<j.sixt@viscovery.net>  writes:
>> To avoid the situation,...
>> This would not be necessary if the order of the merge parents could be
>> specified, e.g.:
>>
>>     # on topic
>>     git merge --into master
>
> I think the underlying mechanism needed to implement the above
> shares a lot with what Jeff called "crazy idea", but where you would
> want to be after such a merge may be different in these two cases.

I don't think there is much question that you should still be in the 
same branch. Not because you necessarily want to be in that branch. But 
because it would be surprising if git-merge changed your branch 
sometimes and most times not.
