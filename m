From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2015, #01; Mon, 3)
Date: Mon, 03 Aug 2015 18:12:52 -0700
Message-ID: <xmqqsi7z6eln.fsf@gitster.dls.corp.google.com>
References: <xmqq38006mod.fsf@gitster.dls.corp.google.com>
	<CAPig+cQr6tZeYwH3W4NP9_6udD2qz7t6vFR7n4haqJLrNhM62w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 03:13:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMQmq-0006A2-Kn
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 03:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbbHDBM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 21:12:56 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34907 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144AbbHDBMz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 21:12:55 -0400
Received: by pasy3 with SMTP id y3so26700946pas.2
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 18:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=81IZX5GGujWe4FBdoILF/LfBI4Zi2Lq71SjZHrKUJfQ=;
        b=05PD7dZIsuDHell0jdQjB+QA2ZmXb0w+kSJndNAq/7fpLBt4F6xeffnLtQZCKUrcfQ
         ELKVrjUHfCi1ccWRn9OoIBjmKlY6jXuuLnB62qyLYALXFV0/XI7PB7Jlqzm/SKcPNGYk
         0BUvz1qzkLMz9tsObC38JGVUYijBRL+HZHzNfrSiS0oFXxrG+Ja2MT6E7DnEQ2Y93dKY
         RdHNRedAfwoecCeM+WUkVvAw+77z6Gzir8+fDFeKnoWQ6eYsZMyqNqBh2Dr73UV09Yrz
         h4sbfrRTHZNdQRCx51sa0Mafb9M7hRQmspgQHGkujgpPdoGfBswhbwf/3/BdMBqGsTan
         02mw==
X-Received: by 10.66.224.140 with SMTP id rc12mr2031183pac.34.1438650775241;
        Mon, 03 Aug 2015 18:12:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id l2sm9469955pdd.65.2015.08.03.18.12.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 18:12:53 -0700 (PDT)
In-Reply-To: <CAPig+cQr6tZeYwH3W4NP9_6udD2qz7t6vFR7n4haqJLrNhM62w@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 3 Aug 2015 18:41:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275234>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Aug 3, 2015 at 6:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I've kicked a few topics out of 'next' back to 'pu' for now.
>>  - I think es/worktree-add and es/worktree-add-cleanup are good
>>    shape overall, but we probably would want to make them into a
>>    single topic.
>
> Is there anything I need to do to move this along, or is it something
> you will be handling locally?

Unless you view this as a chance to rebuild the topic and want to
take advantage of it, e.g. "I'd like to reorder and replace 4-7 with
these two patches while it is outside 'next'", there is no need to
do anything on your part (this comment also applies to Paul).  I
just wanted to eyeball the result after I twiddled a few topics with
"maybe squash this in?" patches we saw recently before merging them
back into 'next'.

Thanks.
