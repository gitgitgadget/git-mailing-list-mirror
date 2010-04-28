From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: Re: Global .git directory
Date: Wed, 28 Apr 2010 22:03:20 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004282148310.26569@bbs.intern>
References: <alpine.LFD.2.00.1004270705280.15197@bbs.intern>  <201004271159.34071.trast@student.ethz.ch>  <alpine.LFD.2.00.1004272144470.11216@bbs.intern> <s2y40aa078e1004271326u3fbbd46au30f187bc3ca9c8c8@mail.gmail.com> <alpine.LFD.2.00.1004280710380.27548@bbs.intern>
 <4BD7D412.5020603@dbservice.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: kusmabite@gmail.com, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 22:04:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7DUe-0006pP-DW
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 22:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986Ab0D1UEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 16:04:16 -0400
Received: from chello084112167138.7.11.vie.surfer.at ([84.112.167.138]:51950
	"EHLO wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787Ab0D1UEP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 16:04:15 -0400
Received: from bbs.intern (localhost [127.0.0.1])
	by wiesinger.com (8.14.4/8.14.4) with ESMTP id o3SK3Ku7029009;
	Wed, 28 Apr 2010 22:03:20 +0200
Received: from localhost (gerhard@localhost)
	by bbs.intern (8.14.4/8.14.4/Submit) with ESMTP id o3SK3KWu029005;
	Wed, 28 Apr 2010 22:03:20 +0200
In-Reply-To: <4BD7D412.5020603@dbservice.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-MailScanner-Information-wiesinger-com: Please contact the ISP for more information
X-wiesinger-com-MailScanner-ID: o3SK3Ku7029009
X-MailScanner-wiesinger-com: Found to be clean
X-MailScanner-SpamCheck-wiesinger-com: not spam, SpamAssassin (not cached,
	score=-4.359, required 4.5, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 0.04, BAYES_00 -2.60)
X-MailScanner-From: lists@wiesinger.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146010>




--
http://www.wiesinger.com/


On Wed, 28 Apr 2010, Tomas Carnecky wrote:

> On 4/28/10 7:33 AM, Gerhard Wiesinger wrote:
>> BTW: The tutorial on http://git-scm.com/ is IHMO wrong:
>> git --version
>> git version 1.6.2.5
>> git commit -m 'Explain what I changed'
>> =>
>> git commit -a -m 'Explain what I changed'
>> => Otherwise changed files are not committed, only added ones.
>> => Therefore that are 2 commit ...
>
> If you mean the snippets right on the front page, it assumes that you add all 
> edited files.

OK, I assumed that the tutorial at
http://git.or.cz/course/svn.html
when switching from svn to git is correct, but it isn't. I unterstand now, 
that git is basically a patch management system where you add or remove 
(rm) files to a patch/commit set (adding in svn means adding or removing 
a file). So this is very different from svn and other SCM systems.

Homepage:
git add (files)
=>
git add (all edited and added files)
would clarify this, too.

>> BTW2:
>> Why is it necessary to do:
>> # Displays only changed files
>> git diff
>> # Displays only added files
>> git diff --cached
>> 
>> I would like to have a full diff of my changes:
>> git diff -a
>> (or better "git diff -a" should be the default behaviour, I think that's
>> very confusing for new users)
>
> What are 'your' changes? Between HEAD and the working tree (aka. git diff 
> HEAD)?

git diff HEAD
# no output.

Ciao,
Gerhard
