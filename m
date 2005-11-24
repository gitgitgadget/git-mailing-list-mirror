From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 4/9] remove git wrapper dependency
Date: Thu, 24 Nov 2005 09:20:48 +0100
Message-ID: <438577E0.30109@op5.se>
References: <20051112092336.GA16218@Muzzle> <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com> <20051124074605.GA4789@mail.yhbt.net> <20051124074739.GB4789@mail.yhbt.net> <20051124074857.GC4789@mail.yhbt.net> <20051124075027.GD4789@mail.yhbt.net> <20051124075133.GE4789@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Nov 24 09:23:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfCLj-0008Am-QG
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 09:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030621AbVKXIUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 03:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030622AbVKXIUu
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 03:20:50 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:47764 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030621AbVKXIUu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 03:20:50 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 325516BCBE
	for <git@vger.kernel.org>; Thu, 24 Nov 2005 09:20:49 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git list <git@vger.kernel.org>
In-Reply-To: <20051124075133.GE4789@mail.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12693>

Eric Wong wrote:
> use git-diff-files instead of git diff-files so we don't rely on the
> wrapper being installed (some people may have git as GNU interactive
> tools :)
> 

This one should do
	git --exec-path

first to get the proper path to git-diff-files. Fall back to it being in 
the path if finding out fails.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
