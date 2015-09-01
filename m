From: Thomas Koch <thomas@koch.ro>
Subject: Re: Git Deployment Multiple Existing Environments
Date: Tue, 1 Sep 2015 10:34:11 +0200
Message-ID: <201509011034.11257.thomas@koch.ro>
References: <BAY180-W4617CD6AE98F64442A918BC26A0@phx.gbl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sukhwinder Singh <php_programmer_india@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 10:34:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWh1L-0000Si-Kv
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 10:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256AbbIAIeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 04:34:18 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:45855 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754735AbbIAIeO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 04:34:14 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id 5F8B742526;
	Tue,  1 Sep 2015 10:34:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id 5-xE7MUXR8FY; Tue,  1 Sep 2015 10:34:12 +0200 (CEST)
User-Agent: KMail/1.13.7 (Linux/3.16.0-0.bpo.4-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <BAY180-W4617CD6AE98F64442A918BC26A0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276972>

On Tuesday, September 01, 2015 09:50:45 AM Sukhwinder Singh wrote:
> Hello,
> I am kind of new to Git and I have a question regarding using Git for a
> website. I have searched a lot but haven't found a solution yet. We
> already have 3-4 environments setup on our Windows servers without Git and
> each environment already has code which is different from each other.
> 
> There are three environments
> Live
> UAT
> Test (has the latest code)
> 
> 
> And then developers have their local copies.
> 
> We write and test the code locally and manually move each point from one
> environment to other using merging software and test at each environment.
> Now we want to use git because manually moving the code is a lengthy
> process. Also as the developers have local copies, it is very difficult to
> manage code.
> 
> Code is written locally by the team and then after testing locally it is
> first merged with "Test" environment code, then "UAT" and then, finally
> with "Live". So we have two concerns:
> 
> There is different code already existing on these environments.
> Testing the code on each environment using the web server.
> 
> What is the best way to go about it? As I am new to git more details will
> be helpful, like commands to use.
> 
> Thanks, 		 	   		  --

There are douzends of different git deployment scripts on github from minimal 
to multi-data-center-enterprise-grade. I wrote this one for my workplace:

https://github.com/comsolit/comsolit_deploy

The README contains links to alternative solutions.

Thomas Koch
