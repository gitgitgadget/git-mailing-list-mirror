From: Koosha Khajehmoogahi <koosha@posteo.de>
Subject: Re: [PATCH v3 3/5] Documentation: add git-log --merges= option and
 log.merges config. var
Date: Thu, 16 Apr 2015 00:27:35 +0200
Message-ID: <552EE5D7.9070703@posteo.de>
References: <1428938968-19013-1-git-send-email-koosha@posteo.de>	<1428938968-19013-3-git-send-email-koosha@posteo.de> <CAPig+cQG4NxxmtaQ49xsU3g6UwZb0RqE67PnQBeYrRv=2CGodw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 00:28:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiVnR-0004NN-HY
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 00:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbbDOW2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 18:28:33 -0400
Received: from mx02.posteo.de ([89.146.194.165]:37910 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103AbbDOW2c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 18:28:32 -0400
Received: from dovecot03.posteo.de (unknown [185.67.36.28])
	by mx02.posteo.de (Postfix) with ESMTPS id BA30F25A3DD8;
	Thu, 16 Apr 2015 00:28:30 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
	by dovecot03.posteo.de (Postfix) with ESMTPSA id 3lRyy56Njsz5vN0;
	Thu, 16 Apr 2015 00:28:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <CAPig+cQG4NxxmtaQ49xsU3g6UwZb0RqE67PnQBeYrRv=2CGodw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267244>



On 04/14/2015 08:42 AM, Eric Sunshine wrote:
> On Mon, Apr 13, 2015 at 11:29 AM, Koosha Khajehmoogahi <koosha@posteo.de> wrote:
>> From: Junio C Hamano <gitster@pobox.com>
>>
>> [kk: added documentation in git-log.txt]
>>
>> Signed-off-by: Koosha Khajehmoogahi <koosha@posteo.de>
>> ---
>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>> index f620ee4..88f152f 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -96,6 +96,23 @@ if it is part of the log message.
>>  --remove-empty::
>>         Stop when a given path disappears from the tree.
>>
>> +--merges={show|hide|only}::
>> +
>> +       Limit the output by type of commits.
>> +
>> +       `hide`;;
>> +               Hide merge commits from the output.
>> +
>> +       `only`;;
>> +               Hide non-merge commits from the output (i.e showing
>> +               only merge commits).
>> +
>> +       `show`;;
>> +               Do not hide either merge or non-merge commits. This
>> +               is primarily useful when the user has non-standard
>> +               setting of `log.merges` configuration variable that
>> +               needs to be overriden from the command line.
> 
> s/overriden/overridden/
> 
>>  --merges::
>>         Print only merge commits. This is exactly the same as `--min-parents=2`.
>>
>> --
>> 2.3.3.263.g095251d.dirty

Should I send a new reroll or wait for reviews on my other commits.
I have not received any review on other patches of this series yet.

-- 
Koosha
