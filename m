From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: way to automatically add untracked files?
Date: Mon, 6 Aug 2007 06:58:33 +0200
Message-ID: <4AF672E9-5D0A-4CD0-BC01-D9BB79A5C8EA@zib.de>
References: <873ayymzc1.fsf@catnip.gol.com> <fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com> <20070805041320.GH9527@spearce.org> <200708051411.25238.johan@herland.net> <20070805161117.GE28263@thunk.org> <C3725674-7B33-4B2F-9386-704540D51C0E@zib.de> <Pine.LNX.4.64.0708060116590.14781@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Miles Bader <miles@gnu.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 06:58:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHufd-0003Bp-9x
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 06:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbXHFE6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 00:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbXHFE6R
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 00:58:17 -0400
Received: from mailer.zib.de ([130.73.108.11]:48478 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbXHFE6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 00:58:16 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l764vpgx014129;
	Mon, 6 Aug 2007 06:57:51 +0200 (CEST)
Received: from [192.168.178.32] ([77.177.251.214])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l764vh0J011079
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 6 Aug 2007 06:57:44 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0708060116590.14781@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55113>


On Aug 6, 2007, at 2:17 AM, Johannes Schindelin wrote:

> Hi,
>
> On Sun, 5 Aug 2007, Steffen Prohaska wrote:
>
>>
>> On Aug 5, 2007, at 6:11 PM, Theodore Tso wrote:
>>
>>> On Sun, Aug 05, 2007 at 02:11:24PM +0200, Johan Herland wrote:
>>>> $ hg addremove --help
>>>> hg addremove [OPTION]... [FILE]...
>>>>
>>>> add all new files, delete all missing files
>>>>
>>>>    Add all new files and remove all missing files from the  
>>>> repository.
>>>>
>>>>    New files are ignored if they match any of the patterns  
>>>> in .hgignore.
>>>> As
>>>>    with add, these changes take effect at the next commit.
>>>>
>>>> Adding a git-addremove command should not be much work, and it  
>>>> would be a
>>>> lot friendlier to people whose workflow is more aligned with #2  
>>>> than #1.
>>>
>>> Not much work at all:
>>>
>>> # git config --system --add alias.addremove "git add . ; git add -u"
>>
>> But how can I handle the [FILE]... from above?
>
> See
> http://git.or.cz/gitwiki/ 
> Aliases#head-714f0aa64cb53eda636d41e16bf2b99477588685

Thanks.

"Starting with version 1.5.3, git supports appending the
arguments to commands prefixed with "!", too. If you need
to perform a reordering, or to use an argument twice, you
can use this trick:

[alias]
         example = !sh -c "ls $1 $0"

NOTE: the arguments start with $0, not with $1 as you are
used from shell scripts." [cited from the link above]

should do the job.

	Steffen
