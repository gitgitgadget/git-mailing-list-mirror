From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: push instead of
Date: Fri, 30 Apr 2010 19:24:01 +0200
Message-ID: <4BDB1231.9090600@dbservice.com>
References: <z2gb42431c81004300256ke7248f40y7bce060d52cfa943@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 19:25:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7txw-0001lc-2J
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 19:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808Ab0D3RYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 13:24:10 -0400
Received: from office.neopsis.com ([78.46.209.98]:55530 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932819Ab0D3RYG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 13:24:06 -0400
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Fri, 30 Apr 2010 19:24:01 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <z2gb42431c81004300256ke7248f40y7bce060d52cfa943@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146035>

On 4/30/10 11:56 AM, Mahesh Vaidya wrote:
> I am facing problem at pushInsteadIOf. I would like pull from
> "pullhost" and push to "pushhost" as my pullhost as pre-receive
> trigger which not accepting pushes.
>
> However when I do git push it still hits pull host. I have following config.
>
> [remote "origin"]
>          fetch = +refs/heads/*:refs/remotes/origin/*
>          url = gitosis@pull_host:repos.git
	pushurl = gitosis@PUSH_host:repos.git

tom
