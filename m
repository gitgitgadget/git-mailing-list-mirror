From: Ben Tebulin <nntp.20.jexpert@spamgourmet.com>
Subject: Re: Git commit error: fatal: Repository has been updated, but unable
 to write new_index file.
Date: Tue, 27 Mar 2012 13:51:48 +0200
Message-ID: <jks9k9$c35$1@dough.gmane.org>
References: <34E530A4-A792-42AC-8C19-5F7CB71FA46C@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 13:52:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCUwV-00082m-5h
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 13:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab2C0Lv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 07:51:59 -0400
Received: from plane.gmane.org ([80.91.229.3]:56681 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566Ab2C0Lv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 07:51:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SCUwK-0007qg-LP
	for git@vger.kernel.org; Tue, 27 Mar 2012 13:51:52 +0200
Received: from 217.6.238.194 ([217.6.238.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 13:51:52 +0200
Received: from nntp.20.jexpert by 217.6.238.194 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 13:51:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 217.6.238.194
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <34E530A4-A792-42AC-8C19-5F7CB71FA46C@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194040>

> fatal: Repository has been updated, but unable to write new_index
> file. Check that disk is not full or quota is not exceeded, and then
> "git reset HEAD" to recover.
>
> Here is the command which IDE executes to make a commit:
>
> # git commit --only -F<message file>  -- <several files chosen to
> commit>

I can confirm this issue. I saw this error more than once. And I'm 
working with cygwin Git on the command line - but having an IDE (VS in 
this case) opened in parallel.

I don't think the issue is about two parallel Git operations in 
parallel. I only started one. But more that some file of the working 
copy is in access. And Git seems to be much more sensible about those 
than i.e. subversion. (No file was "locked")

Sorry - but I cannot tell anything more except that I've experienced 
this issue too. Maybe this is a  windows specific issue? As a windows 
user I had some of them...
