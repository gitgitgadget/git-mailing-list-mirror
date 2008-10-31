From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] t4030: Don't use echo -n
Date: Fri, 31 Oct 2008 01:02:45 -0400
Message-ID: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com>
References: <1225404776-51748-1-git-send-email-benji@silverinsanity.com> <20081030235215.GB18221@sys-0.hiltweb.site>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ian Hilt <Ian.Hilt@gmx.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 06:04:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvmB9-00062z-VD
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 06:04:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752388AbYJaFC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 01:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbYJaFC5
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 01:02:57 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:37728 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbYJaFC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 01:02:56 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 375271FFC18A; Fri, 31 Oct 2008 05:02:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.7-deb
Received: from [192.168.1.109] (cpe-69-205-127-75.rochester.res.rr.com [69.205.127.75])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id E6B1A1FFC186;
	Fri, 31 Oct 2008 05:02:38 +0000 (UTC)
In-Reply-To: <20081030235215.GB18221@sys-0.hiltweb.site>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99550>


On Oct 30, 2008, at 7:52 PM, Ian Hilt wrote:

> On Thu, Oct 30, 2008 at 06:12:56PM -0400, Brian Gernhardt wrote:
>> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
>
> No commit message???
>>

"Don't use echo -n" seemed simple enough to me, as it's the only thing  
it does.  And the reason is that echo -n isn't portable, as has been  
determined previously in git.  I'll update this and use the better  
replacement "printf" anyway.

> This doesn't apply for me.  My tip is up-to-date, but it doesn't  
> even have
> this file it t/.

This is based on next and is for a file that isn't in master.

~~ Brian
