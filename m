From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2015, #04; Tue, 25)
Date: Wed, 26 Aug 2015 09:21:38 -0700
Message-ID: <xmqqfv36uijx.fsf@gitster.dls.corp.google.com>
References: <xmqqegirvtg5.fsf@gitster.dls.corp.google.com>
	<CA+P7+xph-EtxL1sB71uF5qH=VmTM1YwZF9+Y3ez0-VmpWWjytw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 18:21:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUdSL-0002ab-GT
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 18:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671AbbHZQVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 12:21:41 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34621 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbHZQVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 12:21:40 -0400
Received: by pabzx8 with SMTP id zx8so74716122pab.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TprT2v98/GX0hmbQD8XmDryokpVxwSZ8Xt0rOqNLpgM=;
        b=VOLuuweTEZ2/bYgFUqCC8rrkASvxO9fivyf6dGvWduuCUT0wddnrHQHIYhmjtxNUBc
         50foyQnyPgsqyFYU4YK8FgvlS9d1GKUTdRThR7ZUt/8Fu+obPdn+abqpAOFpa4uHUXNU
         uoxTHtOH5x52hxd77FZ41iS/DyWkYIq34LBVV1ZJ+c5UifuQ2VnlUKCc+95EwMBsLYo/
         0tY6DBYBi9ViW5Duui5xu0hznv9UFdgbIjCIMDf6LA5mTuk57Rx7LdZUQIYV10ION6pu
         58Strs5mQdr4+1XxfUFhg4ejYfd6eG3+4Wqn6IlTipw9sGbHM17mSDMJty1O6zjPjnWi
         ejXw==
X-Received: by 10.68.116.142 with SMTP id jw14mr71737911pbb.147.1440606099700;
        Wed, 26 Aug 2015 09:21:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id gx11sm25173146pbd.82.2015.08.26.09.21.38
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 09:21:38 -0700 (PDT)
In-Reply-To: <CA+P7+xph-EtxL1sB71uF5qH=VmTM1YwZF9+Y3ez0-VmpWWjytw@mail.gmail.com>
	(Jacob Keller's message of "Tue, 25 Aug 2015 16:38:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276617>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Aug 25, 2015 at 4:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> * jk/notes-merge-config (2015-08-17) 6 commits
>>  - notes: teach git-notes about notes.<name>.mergeStrategy option
>>  - notes: add notes.mergeStrategy option to select default strategy
>>  - notes: add tests for --commit/--abort/--strategy exclusivity
>>  - notes: extract parse_notes_merge_strategy to notes-utils
>>  - notes: extract enum notes_merge_strategy to notes-utils.h
>>  - notes: document cat_sort_uniq rewriteMode
>>
>>  "git notes merge" can be told with "--strategy=<how>" option how to
>>  automatically handle conflicts; this can now be configured by
>>  setting notes.merge configuration variable.
>>
>>  I think this is ready for 'next', but did I miss comments that need
>>  to be addressed before it happens?
>
> I believe I got all the comments fixed in the most recent series. I
> was not aware of any other comments so if someone has them letting me
> know would be helpful as I had no plans to re-roll anything at
> present.

Thanks.
