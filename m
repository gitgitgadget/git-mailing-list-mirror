From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH - todo] Changes to e-mailed patch handling in v1.5.0
Date: Thu, 18 Jan 2007 10:13:07 -0500
Message-ID: <00691964-B639-4EEA-968D-A6BB65DC3DC8@silverinsanity.com>
References: <7vk5zlqqum.fsf@assigned-by-dhcp.cox.net> <7vwt3lp97c.fsf_-_@assigned-by-dhcp.cox.net> <7vhcupp81v.fsf_-_@assigned-by-dhcp.cox.net> <200701180818.12372.andyparkins@gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 18 16:13:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Yx4-0006p0-Ej
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbXARPNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbXARPNP
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:13:15 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:59012 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443AbXARPNO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:13:14 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id DD7911FFC02B;
	Thu, 18 Jan 2007 15:13:12 +0000 (UTC)
In-Reply-To: <200701180818.12372.andyparkins@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37103>


On Jan 18, 2007, at 3:18 AM, Andy Parkins wrote:

> On Wednesday 2007 January 17 23:06, Junio C Hamano wrote:
>
>> I am neutral about changing the default suffix from .txt to .patch;
>> comments?
>
> I'm in favour.  The extension indicates file type, and gives  
> guidance on the
> tool that can read it. Though .patch is stored in text it's more  
> than that
> (c.f. .html) - the text inside it has meaning beyond just the text.
>
> To me, .txt would implies that the file format is in human-language  
> format
> (i.e. words, sentences, and paragraphs).

Ditto.

Also, Vim nicely detects the From <SHA1> line at the top and thinks  
that it's an mbox file.  With the patch extension it ignores that and  
gives me my diff coloring again.

~~ Brian
