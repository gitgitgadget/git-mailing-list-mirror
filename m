From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] revisions.txt: language improvements
Date: Thu, 31 Mar 2011 14:19:07 +0200
Message-ID: <4D94713B.5090603@drmicha.warpmail.net>
References: <cover.1301569271.git.git@drmicha.warpmail.net>	<48111612952115ce454de0766e3537da92e141ac.1301569271.git.git@drmicha.warpmail.net> <AANLkTikofGHcJtHMAqhAM7ofD=f2jybPAiJTnV=4ciu7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 14:22:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Gtg-0005KZ-AF
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 14:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757379Ab1CaMWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 08:22:38 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59772 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752232Ab1CaMWi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 08:22:38 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B5EE920694;
	Thu, 31 Mar 2011 08:22:37 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 31 Mar 2011 08:22:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=hDu5aDrxGGjs/FyIWkYeAgTtS9A=; b=evFB+RfOFkqvIvBirxZgqwYKH0akxwQ092quA2smk8TsNAZGw++E1F+YiL8GcbblVrdY4ovk+BwWYmGyrAv2CNcH1eTgb90imbRdKE5G5HvAYxNTwp7YEEuD0ygwWOV/0eoEG7z1Uoo1qSr5wq/cr6IXri8gphJv3q7nQcoPyic=
X-Sasl-enc: FWHn9C9RyuHBqBhFmrwGjJXcL97aL9qYkSbCmc6gHhKa 1301574157
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 20954408350;
	Thu, 31 Mar 2011 08:22:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTikofGHcJtHMAqhAM7ofD=f2jybPAiJTnV=4ciu7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170481>

Bert Wesarg venit, vidit, dixit 31.03.2011 14:19:
> On Thu, Mar 31, 2011 at 13:03, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  Documentation/revisions.txt |   68 +++++++++++++++++++++---------------------
>>  1 files changed, 34 insertions(+), 34 deletions(-)
>>
>> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
>> index fa399df..288fa6e 100644
>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
>> @@ -27,30 +27,30 @@ blobs contained in a commit.
>>   When ambiguous, a '<name>' is disambiguated by taking the
>>   first match in the following rules:
>>
>> -  . if '$GIT_DIR/<name>' exists, that is what you mean (this is usually
>> +  . If '$GIT_DIR/<name>' exists, that is what you mean (this is usually
>>     useful only for 'HEAD', 'FETCH_HEAD', 'ORIG_HEAD', 'MERGE_HEAD'
>>     and 'CHERRY_PICK_HEAD');
>>
>> -  . otherwise, 'refs/<name>' if exists;
>> +  . otherwise, 'refs/<name>' if it exists;
>>
>> -  . otherwise, 'refs/tags/<refname>' if exists;
>> +  . otherwise, 'refs/tags/<refname>' if it exists;
>>
>> -  . otherwise, 'refs/heads/<name>' if exists;
>> +  . otherwise, 'refs/heads/<name>' if it exists;
>>
>> -  . otherwise, 'refs/remotes/<name>' if exists;
>> +  . otherwise, 'refs/remotes/<name>' if it exists;
>>
>> -  . otherwise, 'refs/remotes/<name>/HEAD' if exists.
>> +  . otherwise, 'refs/remotes/<name>/HEAD' it if exists.
> 
> s/it if/if it/

Uh, thanks. Waiting for more feedback before a re-roll.

> 
>>  +
>> -'HEAD' names the commit your changes in the working tree is based on.
>> -'FETCH_HEAD' records the branch you fetched from a remote repository
>> +'HEAD' names the commit on which you based the changes in the working tree.
>> +'FETCH_HEAD' records the branch which you fetched from a remote repository
>>  with your last `git fetch` invocation.
>> -'ORIG_HEAD' is created by commands that moves your 'HEAD' in a drastic
>> +'ORIG_HEAD' is created by commands that move your 'HEAD' in a drastic
>>  way, to record the position of the 'HEAD' before their operation, so that
>> -you can change the tip of the branch back to the state before you ran
>> -them easily.
>> -'MERGE_HEAD' records the commit(s) you are merging into your branch
>> +you can easily change the tip of the branch back to the state before you ran
>> +them.
>> +'MERGE_HEAD' records the commit(s) which you are merging into your branch
>>  when you run `git merge`.
>> -'CHERRY_PICK_HEAD' records the commit you are cherry-picking
>> +'CHERRY_PICK_HEAD' records the commit which you are cherry-picking
>>  when you run `git cherry-pick`.
>>  +
>>  Note that any of the 'refs/*' cases above may come either from
