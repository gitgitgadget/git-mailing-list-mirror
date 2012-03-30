From: Daniel Pocock <daniel@pocock.com.au>
Subject: Re: git-svn: cloning an SVN repo with sub-branches and sub-tags
Date: Fri, 30 Mar 2012 13:16:19 +0100
Message-ID: <4F75A413.409@pocock.com.au>
References: <4F7467E1.3090004@pocock.com.au> <92FA9CF9-7E8E-4DE6-8524-030A0AD33C9E@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dave Zarzycki <zarzycki@apple.com>
X-From: git-owner@vger.kernel.org Fri Mar 30 14:23:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDar4-00040r-Qu
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 14:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760785Ab2C3MWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 08:22:52 -0400
Received: from mail1.trendhosting.net ([195.8.117.5]:42773 "EHLO
	mail1.trendhosting.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760773Ab2C3MWr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 08:22:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail1.trendhosting.net (Postfix) with ESMTP id EFF7715782;
	Fri, 30 Mar 2012 13:22:43 +0100 (BST)
Received: from mail1.trendhosting.net ([127.0.0.1])
	by localhost (thp003.trendhosting.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id oahTrnQf-E0w; Fri, 30 Mar 2012 13:22:29 +0100 (BST)
Received: from [192.168.5.2] (thp001.trendhosting.net [195.8.117.3])
	by mail1.trendhosting.net (Postfix) with ESMTP id 7C1FB15765;
	Fri, 30 Mar 2012 13:22:29 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.20) Gecko/20110804 Lightning/1.0b2 Thunderbird/3.1.12
In-Reply-To: <92FA9CF9-7E8E-4DE6-8524-030A0AD33C9E@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194351>

On 29/03/2012 15:40, Dave Zarzycki wrote:
> You can make this work, but it is very fragile, doesn't scale well, and it only works on recent versions of git. For example, from the LLVM clang project:

...

> branches = cfe/branches/Apple/*:refs/remotes/svn/misc/Apple/*
> branches = cfe/branches/Apple/Necropolis/*:refs/remotes/svn/misc/AppleNecropolis/*


In the first line, (Apple/*), can it accidentally think that Necropolis 
is a branch, when it actually appears to be a directory containing branches?

Or does it consider all the lines in the file together?
