From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: Re: Global .git directory
Date: Wed, 28 Apr 2010 22:10:03 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004282204430.29101@bbs.intern>
References: <alpine.LFD.2.00.1004270705280.15197@bbs.intern>  <201004271159.34071.trast@student.ethz.ch>  <alpine.LFD.2.00.1004272144470.11216@bbs.intern>  <s2y40aa078e1004271326u3fbbd46au30f187bc3ca9c8c8@mail.gmail.com>  <alpine.LFD.2.00.1004280710380.27548@bbs.intern>
 <l2i81b0412b1004280101ga2335a58z37d97295ab6c88e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: kusmabite@gmail.com, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 22:11:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7DbE-00027t-S3
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 22:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171Ab0D1ULH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 16:11:07 -0400
Received: from chello084112167138.7.11.vie.surfer.at ([84.112.167.138]:52077
	"EHLO wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148Ab0D1ULF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 16:11:05 -0400
Received: from bbs.intern (localhost [127.0.0.1])
	by wiesinger.com (8.14.4/8.14.4) with ESMTP id o3SKA9s2030130;
	Wed, 28 Apr 2010 22:10:09 +0200
Received: from localhost (gerhard@localhost)
	by bbs.intern (8.14.4/8.14.4/Submit) with ESMTP id o3SKA3ln030007;
	Wed, 28 Apr 2010 22:10:03 +0200
In-Reply-To: <l2i81b0412b1004280101ga2335a58z37d97295ab6c88e7@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-MailScanner-Information-wiesinger-com: Please contact the ISP for more information
X-wiesinger-com-MailScanner-ID: o3SKA9s2030130
X-MailScanner-wiesinger-com: Found to be clean
X-MailScanner-SpamCheck-wiesinger-com: not spam, SpamAssassin (not cached,
	score=-4.36, required 4.5, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 0.04, BAYES_00 -2.60)
X-MailScanner-From: lists@wiesinger.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146012>

On Wed, 28 Apr 2010, Alex Riesen wrote:

> On Wed, Apr 28, 2010 at 07:33, Gerhard Wiesinger <lists@wiesinger.com> wrote:
>> On Tue, 27 Apr 2010, Erik Faye-Lund wrote:
>>> Please see Documentation/SubmittingPatches. It's difficult to
>>> comment on a non-inlined patch.
>>
>> Patch done on top of HEAD.
>
> The patches "done on top of HEAD" are usually useless for
> everyone, including the submitter. HEAD changes over time.
> for instance I wont be able to apply your patches on my HEAD,
> as I have a lot of changes in my Git repo.
>
> If you about to share your modifications, you better base your
> changes on stable points in history, like releases (marked by
> release tags, like "v1.7.1").
>

Patch is made on top of v1.7.1 (it was HEAD at the time of the last pull) 
according to git log.

>> BTW2:
>> Why is it necessary to do:
>
> It is so you can distinguish between the changes in progress and
> the changes ready to be submitted (prepared for commit).
>
>> # Displays only changed files
>> git diff
>
> To be exact: the changes not yet staged for commit.
>
>> # Displays only added files
>> git diff --cached
>
> No, it displays the changes ready to be committed (staged).
>
>> I would like to have a full diff of my changes:
>> git diff -a
>
> You wouldn't use it. It is very useful to separate the phases of workflow.
>
> BTW, try using "git status". It'll show you both lists of changed files.
> Also "git gui", and "gitk" make the lists visible ("git gui" is more like
> "git status", and you can commit from it).
>
>> (or better "git diff -a" should be the default behaviour, I think that's
>> very confusing for new users)
>
> Only to unwilling to learn. You'd be probably the first to suggest
> to combine the two stages of change. Usually people understand
> (or get a feeling of understanding) the index even before they send
> first mail to the mailing list.

Ok, as explained in previous mail, confusion was introduced from the 
tutorial at: http://git.or.cz/course/svn.html

Thnx for explaination so far.

Ciao,
Gerhard

--
http://www.wiesinger.com/
