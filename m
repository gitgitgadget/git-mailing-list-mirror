From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Introduce 'git-format-patch --suffix=patch'
Date: Wed, 17 Jan 2007 15:08:24 -0500
Message-ID: <6B51EBBF-1499-4E9B-856C-39DA5B8C4CC7@silverinsanity.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com> <Pine.LNX.4.63.0701171446410.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v4pqpsbre.fsf_-_@assigned-by-dhcp.cox.net> <45AE7710.40503@shadowen.org> <7vzm8hqws4.fsf@assigned-by-dhcp.cox.net> <D085A8A2-F1EC-47EC-8D96-B8A06E483BDB@silverinsanity.com> <7vps9dqvdq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 21:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7H5F-0004C3-DJ
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 21:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbXAQUIa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 15:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbXAQUIa
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 15:08:30 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:46396 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675AbXAQUI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 15:08:29 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 15AF71FFC02B;
	Wed, 17 Jan 2007 20:08:28 +0000 (UTC)
In-Reply-To: <7vps9dqvdq.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37035>


On Jan 17, 2007, at 2:57 PM, Junio C Hamano wrote:

> Brian Gernhardt <benji@silverinsanity.com> writes:
>
>> I think that the best form of DWIM is that if the suffix is "", then
>> you simply skip the entire sprintf.  Then any suffix has to have the
>> '.', but no suffix doesn't have it.  Additional DWIMMmery could
>> remove an initial '.' from the suffix so that users expecting it to
>> be there don't get ".." in their file.
>
> I think it is generally accepted on this list that that kind of
> DWIMmery is bad.

The first part seems like the easiest way to allow --suffix=""  
actually remove the suffix while removing the "Huh?" factor you  
mentioned.  In fact, having --suffix="" add a suffix of "." is  
somewhat confusing all on it's own.

The second just seems like an easy way to keep stupid mistakes from  
occurring, but isn't needed.

I'll still post the patch, but not add the extra DWIMmery.  I think  
it's a better alternative than having to choose between putting "."  
in all the suffixes and always having "." on the file.

~~ Brian
