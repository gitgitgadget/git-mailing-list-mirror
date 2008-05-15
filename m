From: Kevin Ballard <kevin@sb.org>
Subject: Re: Problems cloning on Mac OS
Date: Thu, 15 May 2008 01:39:25 -0400
Message-ID: <D5F3E168-4A47-4FFA-8EC5-20D5202E009E@sb.org>
References: <Pine.LNX.4.64.0805150618570.23917@ds9.cixit.se>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu May 15 07:40:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwWCQ-0008Bo-Vv
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 07:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbYEOFj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 01:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbYEOFj3
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 01:39:29 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:36222 "EHLO
	randymail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751514AbYEOFj2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2008 01:39:28 -0400
Received: from [192.168.0.203] (c-24-91-11-245.hsd1.ma.comcast.net [24.91.11.245])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a4.g.dreamhost.com (Postfix) with ESMTP id CC9E1195A42;
	Wed, 14 May 2008 22:39:26 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0805150618570.23917@ds9.cixit.se>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82181>

On May 15, 2008, at 1:22 AM, Peter Karlsson wrote:

> Hi!
>
> I am having problems cloning with git running on Mac OS X (installed
> from macports). I am cloning from a Linux box:
>
> $ git clone ssh://peter@server/path localpath
> Initialized empty Git repository in /Users/peter/tmp/localpath/.git/
> percent_expand: NULL replacement
> fatal: The remote end hung up unexpectedly
> fetch-pack from 'ssh://server/path' failed.
>
> $ git --version
> git version 1.5.5.1
>
>
> Any ideas what is wrong? I successfully cloned from that repository to
> a Windows (msysgit) install yesterday, over ssh.
>
> Git on the Linux box I'm cloning from:
> $ git --version
> git version 1.5.4.2
>
> (installed from Debian package version 1:1.5.4.2-1~bpo40+2)

Read http://github.com/guides/percent_expand-null-replacement-bug

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
