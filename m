From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 16:07:46 -0700
Message-ID: <48ADF542.9010105@zytor.com>
References: <48ACB29C.7000606@zytor.com> <48ADE2FF.4080704@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Federico Lucifredi <flucifredi@acm.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 01:09:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWJHE-0004eN-51
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 01:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759691AbYHUXHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 19:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759669AbYHUXHt
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 19:07:49 -0400
Received: from terminus.zytor.com ([198.137.202.10]:43185 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758711AbYHUXHt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 19:07:49 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7LN7lAt005330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Aug 2008 16:07:47 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7LN7l0G028962;
	Thu, 21 Aug 2008 16:07:47 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7LN7ki6025117;
	Thu, 21 Aug 2008 16:07:46 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <48ADE2FF.4080704@acm.org>
X-Virus-Scanned: ClamAV 0.93.3/8069/Thu Aug 21 10:36:55 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93222>

Federico Lucifredi wrote:
> Hello HP,
>  I have seen this in (funnily enough) a project I manage myself, which 
> has subcommands structured similarly to Git.
> 
>  I have looked at options, but so far the current behavior (man foo-bar) 
> seems the best option for foo's subcommand bar. The alternative, also 
> acceptable, is a large page with subsections for each command. Sections 
> (man 1) are used for chapter-like page groupings, not for subsections on 
> a single command - those would have to be implemented as an additional 
> layer.
> 
>  But, as another participant in the thread has commented, that would not 
> port to other platforms very quickly (although it would get to Linux and 
> OS-X promptly, and may eventually make its way into other platforms).
> 
>  I am open to ideas, but so far the two options above are better than 
> anything else that has been so far suggested...
> 

One option would be to support "man foo bar" showing the page labelled 
foo-bar.  That way you'd get at least a modicum of bass-ackwards 
compatibility.

However, at some point we have to be willing to do things other 
platforms won't, or we'll never do anything new...

	-hpa
