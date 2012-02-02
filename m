From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: rebase -i reword converts to pick on pre-commit non-zero exit
Date: Thu, 02 Feb 2012 10:21:56 -0600
Message-ID: <4F2AB824.2030609@gmail.com>
References: <jgcaoh$d9q$1@dough.gmane.org> <4F29AE8E.6070109@gmail.com> <4F2A0D4B.6000001@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 17:22:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RszQA-0004kJ-Lg
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 17:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab2BBQV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 11:21:57 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:43297 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751778Ab2BBQV4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 11:21:56 -0500
Received: by obcva7 with SMTP id va7so2984366obc.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=LIoENy1zLiFZVT69wZkKkaUJRozMOITjK6GV342mZOg=;
        b=a7wdEbxKtSpcFR+QJGh7Db0DKeO+eKocYdE/GGodhfOisFtEO5ndGcMOboCK67R/yM
         5xpJVzDJxw0e0cota15AwBhAAWkdLhxId06HiuujQqBa31WO/3ddQGQsNO3/qfL+7wob
         urjSz5+z9CWQQkId91iwemHWr7k84wE7NXXZ4=
Received: by 10.182.10.103 with SMTP id h7mr3183559obb.3.1328199715689;
        Thu, 02 Feb 2012 08:21:55 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id ml8sm1835665obc.0.2012.02.02.08.21.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 08:21:54 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.26) Gecko/20120129 Thunderbird/3.1.18
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4F2A0D4B.6000001@sohovfx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189654>

On 2/1/2012 10:12 PM, Andrew Wong wrote:
> On 12-02-01 4:28 PM, Neal Kreitzinger wrote:
>> Instead of picking commit (a) when the pre-commit hook exits
>> non-zero on the reword command, shouldn't interactive rebase learn
>> to edit commit (a) and tell the user that because the pre-commit
>> hook exited non-zero they need to either remedy the pre-commit hook
>> violations and run git commit --amend or run git commit --amend
>> --no-verify to bypass the pre-commit hook?
>
> Yup, I've submitted a patch to address this issue a while ago. This
> new behavior should be in v.1.7.8.2 and later.

I now see that this 1.7.8.2 release note applies:

  * When a "reword" action in "git rebase -i" failed to run "commit 
--amend",
    we did not give the control back to the user to resolve the
situation, and
    instead kept the original commit log message.

thanks!

v/r,
neal
