From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: push instead of
Date: Sat, 01 May 2010 00:11:48 +0200
Message-ID: <4BDB55A4.7000801@dbservice.com>
References: <z2gb42431c81004300256ke7248f40y7bce060d52cfa943@mail.gmail.com>	 <4BDB1231.9090600@dbservice.com> <p2nb42431c81004301124l6744553csbe5abdeda0d48e67@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 01 00:12:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7yRE-00022W-6A
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 00:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759398Ab0D3WLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 18:11:54 -0400
Received: from office.neopsis.com ([78.46.209.98]:42958 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758607Ab0D3WLx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 18:11:53 -0400
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sat, 1 May 2010 00:11:49 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <p2nb42431c81004301124l6744553csbe5abdeda0d48e67@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146067>

On 4/30/10 8:24 PM, Mahesh Vaidya wrote:
> No Luck, it still hits  readonly url ;

Maybe your git version is too old. pushurl was introduced in v1.6.4

>
> On Fri, Apr 30, 2010 at 10:54 PM, Tomas Carnecky<tom@dbservice.com>  wrote:
>> On 4/30/10 11:56 AM, Mahesh Vaidya wrote:
>>>
>>> I am facing problem at pushInsteadIOf. I would like pull from
>>> "pullhost" and push to "pushhost" as my pullhost as pre-receive
>>> trigger which not accepting pushes.
>>>
>>> However when I do git push it still hits pull host. I have following
>>> config.
>>>
>>> [remote "origin"]
>>>          fetch = +refs/heads/*:refs/remotes/origin/*
>>>          url = gitosis@pull_host:repos.git
>>
>>         pushurl = gitosis@PUSH_host:repos.git
