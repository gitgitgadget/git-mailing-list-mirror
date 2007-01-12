From: Steven Grimm <koreth@midwinter.com>
Subject: Re: What's in git.git and announcing GIT v1.5.0-rc1
Date: Fri, 12 Jan 2007 10:39:50 -0800
Message-ID: <45A7D5F6.9020606@midwinter.com>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net> <200701121501.24642.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 19:39:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5RJE-0003Fd-3J
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 19:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbXALSjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 13:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbXALSjV
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 13:39:21 -0500
Received: from tater.midwinter.com ([216.32.86.90]:43584 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964851AbXALSjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 13:39:20 -0500
Received: (qmail 4254 invoked from network); 12 Jan 2007 18:39:20 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.130?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 12 Jan 2007 18:39:20 -0000
User-Agent: Mail/News 1.5.0.9 (Macintosh/20070108)
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200701121501.24642.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36691>

Andy Parkins wrote:
> For me, I'd prefer that they worked in subdirectories.  I do all almost all 
> development in "src/" and having to change up a directory just to run git 
> commands is inconvenient.
>   

I agree; I find that inconvenient too. The only catch I can see is that 
there might be an expectation that if you run, say, "git-pull" in the 
src directory, it will only update the files in src and will leave the 
ones in the other top-level directories alone. For example, "svn update" 
works that way.

But honestly I think touching files outside the current subdirectory is 
much less of an inconvenience (and it's something you only get surprised 
by once, if at all) than not working in subdirectories at all.

-Steve
