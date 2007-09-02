From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 02 Sep 2007 16:36:35 -0700
Message-ID: <46DB4903.6060100@midwinter.com>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>	<87hcmcfzo9.fsf@morpheus.local> <87d4x0fzky.fsf@morpheus.local> <7vveasode8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?RGF2aWQgS8OlZ2VkYWw=?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 01:36:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRyzv-0005u5-3B
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 01:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442AbXIBXgi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 19:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbXIBXgi
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 19:36:38 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:39126 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754474AbXIBXgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 19:36:37 -0400
Received: (qmail 24647 invoked from network); 2 Sep 2007 23:36:37 -0000
Received: from c-76-21-16-80.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.16.80)
  by tater.midwinter.com with SMTP; 2 Sep 2007 23:36:36 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <7vveasode8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57404>

Junio C Hamano wrote:
> It's a tricky balancing act.  Not everybody is the end user who
> is only interested in using Porcelain.  The release note for a
> new release somehow needs to mention changes that would affect
> only plumbing users as well.
>   

No argument there, of course; it needs to be documented. But maybe not 
as the very first item at the top of the release notes, which people 
might expect to be organized in a "most user-visible first" order. I 
usually expect to see general descriptions of new features and critical 
bugfixes at the top of a program's release notes, with the option to 
keep reading if I want the low-level details.

Barring that, or even in addition to that, would it make sense to have 
separate "porcelain" and "plumbing" sections of the release notes? 
Obviously some changes straddle the two, but there are a lot that are 
pretty clear-cut one way or the other. Then end users can ignore the 
plumbing section and porcelain writers can jump straight to it.

-Steve
