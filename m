From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.5.0
Date: Mon, 27 Jul 2015 14:54:47 -0700
Message-ID: <xmqqd1zdgtaw.fsf@gitster.dls.corp.google.com>
References: <xmqqtwspgusf.fsf@gitster.dls.corp.google.com>
	<CAHYJk3S-gSg3bbbv5JoxoRfkCLi9p_rOM8Z3v3njdcRYgS4cCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 23:55:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJqML-0003PT-85
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 23:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbbG0Vyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 17:54:53 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33508 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbbG0Vyw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 17:54:52 -0400
Received: by padck2 with SMTP id ck2so57712725pad.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 14:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wOKmcwLN67/SCIMNtVePPx8hIKCL0DjF2T0amQrKj/c=;
        b=k/52FOO5jDa895yVnS8+lVDY3txMzM9vhnzJoiS5gpOA5tFSSslouiEm7ozrsaSP3c
         DifZiG0wSGgLNZQPWGEy4bOAsKzULFpR+KhZhc+IQDqOaQ+1LVG1iXjl3VS4waOOZQDE
         vlGqw2N5klV548NWAH2ErItIg79uZMT3ggxV5f8Lat98mL3X+xfnVyyXyr+G7JCvrf7K
         sghpUymccR+78qmgV/nmMeOru4tZdBOQCCD4nNdcSmV9xvvzOr4+/JaCdlA0o70wfzJN
         H3H/Xk9YjLY+HMpvZRxV7ryQmWC3Zwm35wx+joM4VbZOZbUKRM7StxCT9RwBTphnlmG4
         8s1Q==
X-Received: by 10.66.168.229 with SMTP id zz5mr69967654pab.41.1438034092115;
        Mon, 27 Jul 2015 14:54:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2496:725d:b368:d039])
        by smtp.gmail.com with ESMTPSA id z4sm31246119pdo.88.2015.07.27.14.54.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 14:54:48 -0700 (PDT)
In-Reply-To: <CAHYJk3S-gSg3bbbv5JoxoRfkCLi9p_rOM8Z3v3njdcRYgS4cCA@mail.gmail.com>
	(Mikael Magnusson's message of "Mon, 27 Jul 2015 23:39:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274716>

Mikael Magnusson <mikachu@gmail.com> writes:

> On Mon, Jul 27, 2015 at 10:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The latest feature release Git v2.5.0 is now available at the
>> usual places.  It is comprised of 583 non-merge commits since
>> v2.4.0, contributed by 70 people, 21 of which are new faces.
> ...
>> Git 2.5 Release Notes
>> =====================
>>
>> Updates since v2.4
>> ------------------
>>
>> UI, Workflows & Features
>>
> ...
>>
>>  * A replacement for contrib/workdir/git-new-workdir that does not
>>    rely on symbolic links and make sharing of objects and refs safer
>>    by making the borrowee and borrowers aware of each other.
>>
>>    Consider this as still an experimental feature; its UI is still
>>    likely to change.
>
>
> It might be helpful to list what the replacement actually is in this entry.

Did you read "Its UI is still likely to change" ;-)?  It earlier was
parked at "checkout --to", it is parked at "worktree add" today, but
who knows where it will end up.  It would be harmful to say that
here as if we are already encouraging its use.
