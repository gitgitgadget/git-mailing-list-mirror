From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/3] git-p4: add failing test for P4EDITOR handling
Date: Wed, 20 May 2015 13:56:27 -0700
Message-ID: <xmqqd21vm0hw.fsf@gitster.dls.corp.google.com>
References: <xmqqa8x0a7wq.fsf@gitster.dls.corp.google.com>
	<1432074198-13806-1-git-send-email-luke@diamand.org>
	<1432074198-13806-2-git-send-email-luke@diamand.org>
	<xmqq617nnhxk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed May 20 22:56:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvB2Y-0003Ln-Az
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 22:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbbETU43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 16:56:29 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34814 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbbETU43 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 16:56:29 -0400
Received: by igbhj9 with SMTP id hj9so72372060igb.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aDddpEQuP24Geyko5eTC+/egRX2LFj6rZeuK3bRJcl0=;
        b=l/+50HlOiNrxTZ5EmIR8NwQke2EqU9rRN/GABplgjiC86G24NeJiiIaFa/J+jN+W1K
         5qwIaPtmgTtGNjuRn1LXOIzPcNpcHGs7j2pcbh38NPFaIP96qRWzML2rG5Gqk9rPaq2A
         y58X/tX4zFKtO6c8SA6nLmBKvpOolax59y8pFCABLPatGjlDQ+FnE1ZsMeq01h3JKfM9
         RAtdEi5589zkO96L3i/a9+98Jvg110DUZ1aNjyA2ewZ9L+8psZCu51gspzp1dohnuNUr
         EI0QTO1KwlnQREUcbjFsWD9Wxj+P/GYldmWrzrwY9TJgF6Pc7ACpo2g4Exblq9pN0Szc
         v8Tg==
X-Received: by 10.107.136.197 with SMTP id s66mr4778715ioi.65.1432155388625;
        Wed, 20 May 2015 13:56:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id z195sm13196284iod.33.2015.05.20.13.56.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 13:56:28 -0700 (PDT)
In-Reply-To: <xmqq617nnhxk.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 20 May 2015 12:54:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269520>

Junio C Hamano <gitster@pobox.com> writes:

> Luke Diamand <luke@diamand.org> writes:
>
>> +
>> +test_expect_failure 'EDITOR has options' '
>> +# Check that the P4EDITOR argument can be given command-line
>> +# options, which git-p4 will then pass through to the shell.
>> +test_expect_success 'EDITOR has options' '
>> +	git p4 clone --dest="$git" //depot &&
>
> Oops?  I assume that the one before the comment should go and this
> one is
>
> 	test_expect_failure 'Editor with an option' '
>
> or something.

I'll queue the three patches, each of them followed with its own
SQUASH commit.  Could you sanity check them?  If everything looks OK
then I'll just squash them and that way we can save back-and-forth.

Thanks.
