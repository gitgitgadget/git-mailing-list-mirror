From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH RFC v2 00/19] Enable options --signoff, --reset-author
 for pick, reword
Date: Wed, 09 Jul 2014 18:08:55 +0200
Message-ID: <53BD6917.7070700@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1404323078.git.bafain@gmail.com> <xmqqha2r8trc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 18:09:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4uQb-00066k-K5
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 18:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbaGIQJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 12:09:00 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:46361 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201AbaGIQI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 12:08:59 -0400
Received: by mail-wi0-f176.google.com with SMTP id n3so3035982wiv.9
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 09:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Jvq6qbs2FKJXFAQSe6TmBnWYrNNCkZx09EFL7Yo4uI4=;
        b=kTeTInU5WgLo9d/rVQJjhZZKop0i40aADcynhOrOpBcVqDIG/gAoett8yqYDJViAWv
         xfZmen2Yi8p30K5huU7+/WIKRQ9Sobnm4Aa2eHbFBtQXWUwLAByrbDpzIj3i3lcl9id2
         HBBB4lHOgKEmEJ1Tf8cKm2lGCm3p2YZFhuqnsU6BJWfyY5thcJC+hp52ZZueBnfxYhel
         IZjQhLx08K8snXaf9OW2WYMG1tXRviJYQqjh3HeyU3wi5ZRm9dSvPGYx3UwFbaZ0gMcT
         d7YsjyLYqrkYGCbkUjVfADHc6+KyeMQ59qklCzdXHAelM5vI7/0xhu0gL8+rynbVDmzQ
         i8pg==
X-Received: by 10.194.200.3 with SMTP id jo3mr13440576wjc.110.1404922138412;
        Wed, 09 Jul 2014 09:08:58 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id ev9sm20879705wic.24.2014.07.09.09.08.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Jul 2014 09:08:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqha2r8trc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253133>

On 07/08/2014 10:45 PM, Junio C Hamano wrote:
> Fabian Ruch <bafain@gmail.com> writes:
>> Fabian Ruch (19):
>>   rebase -i: Failed reword prints redundant error message
>>   rebase -i: reword complains about empty commit despite --keep-empty
>>   rebase -i: reword executes pre-commit hook on interim commit
>>   rebase -i: Teach do_pick the option --edit
>>   rebase -i: Implement reword in terms of do_pick
>>   rebase -i: Stop on root commits with empty log messages
>>   rebase -i: The replay of root commits is not shown with --verbose
>>   rebase -i: Root commits are replayed with an unnecessary option
>>   rebase -i: Commit only once when rewriting picks
>>   rebase -i: Do not die in do_pick
>>   rebase -i: Teach do_pick the option --amend
>>   rebase -i: Teach do_pick the option --file
>>   rebase -i: Prepare for squash in terms of do_pick --amend
>>   rebase -i: Implement squash in terms of do_pick
>>   rebase -i: Explicitly distinguish replay commands and exec tasks
>>   rebase -i: Parse to-do list command line options
>>   rebase -i: Teach do_pick the option --reset-author
>>   rebase -i: Teach do_pick the option --signoff
>>   rebase -i: Enable options --signoff, --reset-author for pick, reword
> 
> After "rebase -i:", some begin with lowercase and many begin with
> capital, which makes the short-log output look distracting.

The ones that begin with lower-case letters are the ones that begin with
the command name "reword". All first lines are typed in lower case now.

Sorry for the noise.

   Fabian
