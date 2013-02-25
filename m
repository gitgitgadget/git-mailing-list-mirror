From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: Fix rename pretty-print when suffix and prefix overlap
Date: Mon, 25 Feb 2013 23:41:26 +0100
Message-ID: <CALWbr2w47K0jqrKaQs3eTUtQ18_L5TrLR=BttspKACT7vCmWEA@mail.gmail.com>
References: <1361638125-11245-1-git-send-email-apelisse@gmail.com>
	<7vzjyu3we1.fsf@alter.siamese.dyndns.org>
	<CALWbr2yviqF68zF7mBbhaXW7oFar0YRqROBWXwqjo7UNgZNVBQ@mail.gmail.com>
	<512BE787.1090901@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Feb 25 23:41:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA6k5-0006VE-5c
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 23:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102Ab3BYWl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 17:41:28 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:46474 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759684Ab3BYWl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 17:41:27 -0500
Received: by mail-qa0-f47.google.com with SMTP id j8so1947693qah.6
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 14:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=v5+DSzMSXPNAB6505WLHWuUGck5FB+9OXWDg3XspgFk=;
        b=eF2RFTYN1fMt2X7NedA7U/SBjh9EMYzmkptpSlZig+113+HYjyAUfpW6USnEbj2Zk4
         eGbB9wQnrNkiZdRZYvuwuwakh8YhcZa97v2cZMnMfqpEq5uLRhK55+5TkaHd2nmhSPok
         diOw97U2ccSXFzKo856rdW8oHpYYosdV5vkgBwkVcYqQykvmpy0ugFegV/X+rgDXNsXB
         eEJHqPE5/UYNPARndqLexdnPFsMhgWHdPbIfoV/vB2YPh4HlfZdP/W/O3WFIC/rnV3/J
         qeQ7DIYzBWqT8JyzvXROTTebwhXjbwVRICcnJNlXt+NUEr+HELqiFixbXDALpCsUDmbB
         2rWg==
X-Received: by 10.224.42.79 with SMTP id r15mr14167209qae.47.1361832086357;
 Mon, 25 Feb 2013 14:41:26 -0800 (PST)
Received: by 10.49.70.163 with HTTP; Mon, 25 Feb 2013 14:41:26 -0800 (PST)
In-Reply-To: <512BE787.1090901@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217116>

>>> In this example, the common prefix would be "a/b/" and the common
>>> suffix that does not overlap with the prefix part would be "/c", so
>>> I am imagining that "a/b/{ => b}/c" would be the desired output?
>>
>>
>> Yes, at least that's what I expected.
>
>
> Surely it would be "a/b/{b => }/c", that is, we have reduced the number of
> b's by one. Or am I misunderstanding something?
> (I'm guessing it was an all too obvious typo that was misread)

Indeed, read to fast and reproduced in suggested new message.
a/b/b/c => a/b/c is equivalent to a/b/{b => }/c

Thank you for proof-reading.
