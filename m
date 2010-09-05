From: Gelonida <gelonida@gmail.com>
Subject: Re: create easy to parse list of added / ,odified files
Date: Sun, 05 Sep 2010 23:50:14 +0200
Message-ID: <i613am$uet$2@dough.gmane.org>
References: <i5q524$9fc$1@dough.gmane.org> <20100903063917.GA13519@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 23:55:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsNBL-0003xy-N2
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 23:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704Ab0IEVzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 17:55:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:39453 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754488Ab0IEVzI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 17:55:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OsNB2-0003q6-7y
	for git@vger.kernel.org; Sun, 05 Sep 2010 23:55:04 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 23:55:04 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 23:55:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 ""
In-Reply-To: <20100903063917.GA13519@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155494>

Hi Jonathan,

On 09/03/2010 08:39 AM, Jonathan Nieder wrote:
> Gelonida wrote:
> 
>> for a pre-commit trigger I would like to retrieve the list of modified
>> files, such, that I could analyze the contents prior to commit.
>>
>> what would be the best command for this
>>
>>
>> I thought about using "git status", but wondered, which other command
>> might return a nicer to parse list.
> 
> If you look at the git(1) man page, you will find a number of such
> "low-level (plumbing) interrogation commands" listed.  For example:
> 
>  . git diff-index
>  . git diff-files
>  . git update-index
>  . git status --porcelain
> 

Thanks for your answer.

I'm currently using
git diff-index HEAD --cached

This seems to do what I was looking for.

git status --porcelain
doesn't exist on my old cygwin git (I assume it's proably a little too old)
