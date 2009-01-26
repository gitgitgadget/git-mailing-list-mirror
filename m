From: Jake Goulding <goulding@vivisimo.com>
Subject: Re: [PATCH 2/3] Make has_commit non-static
Date: Mon, 26 Jan 2009 14:20:30 -0500
Message-ID: <497E0CFE.4080702@vivisimo.com>
References: <1232979205-17161-1-git-send-email-goulding@vivisimo.com> <1232979205-17161-2-git-send-email-goulding@vivisimo.com> <alpine.DEB.1.00.0901261637300.25749@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 20:23:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRX1y-0005ST-Cw
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbZAZTUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZAZTUd
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:20:33 -0500
Received: from scalix.vivisimo.com ([207.97.211.28]:40822 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbZAZTUc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 14:20:32 -0500
Received: from mail.office.vivisimo.com (mail.office.vivisimo.com [206.210.75.84])
	by mail.vivisimo.com (Postfix) with ESMTP id A4D378525FA;
	Mon, 26 Jan 2009 14:20:31 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 70C9B2E68D0;
	Mon, 26 Jan 2009 14:20:31 -0500 (EST)
X-Virus-Scanned: amavisd-new at vivisimo.com
Received: from mail.office.vivisimo.com ([127.0.0.1])
	by localhost (mail.office.vivisimo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VPNhdLqDTW0n; Mon, 26 Jan 2009 14:20:30 -0500 (EST)
Received: from [192.168.0.20] (jpg-melchior.vivisimo.com [192.168.0.20])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 779602E68CF;
	Mon, 26 Jan 2009 14:20:30 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0901261637300.25749@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107253>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 26 Jan 2009, Jake Goulding wrote:
> 
>> Moving has_commit from branch to a common location in preparation for 
>> using it in tag. Renaming it to commit_has_any_in_commit_list to be more 
>> unique.
> 
> I feel like bike-shedding for a change, and I'd also like to prove that 
> not all Germans like long names:
> 
> 	is_ancestor_of_any()
> 
> Hmm?

I assume that this means that the rest of the code/logic is fine? :-D

I'll change this (I don't have any attachment to one name or the other),
then it should be good to go!

-Jake
