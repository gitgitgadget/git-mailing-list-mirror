From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/8] notes: allow use of the "rewrite" terminology for merge strategies
Date: Mon, 17 Aug 2015 12:35:28 -0700
Message-ID: <xmqqoai5d7y7.fsf@gitster.dls.corp.google.com>
References: <1439801191-3026-1-git-send-email-jacob.e.keller@intel.com>
	<1439801191-3026-5-git-send-email-jacob.e.keller@intel.com>
	<CALKQrgfLzWdRxC5saBXJ_-iKmVDfs+mBfDKKrSU2-tP7eO5+Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:35:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRQBy-0000UO-J0
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbbHQTfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:35:30 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33154 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbbHQTf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:35:29 -0400
Received: by pabyb7 with SMTP id yb7so114789199pab.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5iRjwGZCEIz2F+dqgVnyDVwsjEJ2Y6r8ZjEFqTlU/y4=;
        b=Tud1cw6anBKkz1IkGhDvcS7Km/Hk0JsIQITGG4S87AhkKKMoX9K5GPiqEg4Jz3oFWe
         3qA8utji3p/7Bb485Xvze26uKlIaKbXvGzWnZG+5aIF54Q/UEhmYSm/6J6RSmGsmoAFY
         BwMQyZtORJ701RZt7kgJ35tvhtq4JMGPLFVtPf0O9DLRiExk8Yl7X2lCuMmxbxmpnCAq
         1+RfvTgJ5Az21b3L4nPBYePlD9J0LwUs8ZIB5iTSO8sfUmqHwaDg9nhpZpKzFTvVMQ52
         BrkU7q4miA8uU+fh4xS3xPdRyqCzEI2cJF7QDhWWj0fL2xLKA2hgkHR8yl93DOXZ75RP
         YCAw==
X-Received: by 10.67.15.67 with SMTP id fm3mr5500759pad.114.1439840129310;
        Mon, 17 Aug 2015 12:35:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id pg9sm15498089pbb.60.2015.08.17.12.35.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 12:35:28 -0700 (PDT)
In-Reply-To: <CALKQrgfLzWdRxC5saBXJ_-iKmVDfs+mBfDKKrSU2-tP7eO5+Zg@mail.gmail.com>
	(Johan Herland's message of "Mon, 17 Aug 2015 14:54:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276081>

Johan Herland <johan@herland.net> writes:

> On Mon, Aug 17, 2015 at 10:46 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> notes-merge.c already re-uses the same functions for the automatic merge
>> strategies used by the rewrite functionality. Teach the -s/--strategy
>> option how to interpret the equivalent rewrite terminology for
>> consistency.
>
> I'm somewhat negative to this patch. IMHO, adding the rewrite modes as
> merge strategy synonyms adds no benefit - only potential confusion -
> to the existing merge strategies.  ...
> ... By committing to these synonyms now, you might
> actually be making things harder for the future author: once the
> synonyms are part of the user-visible and documented interface, they
> cannot easily be removed/changed again.

OK.  Thanks.
