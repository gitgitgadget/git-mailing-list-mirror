From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 10/25] Add new environment variable $GIT_COMMON_DIR
Date: Wed, 26 Feb 2014 14:43:59 -0500
Message-ID: <CAPig+cSpnK0vqG_jQYmW1SC-VTQknG_aFnBRN-HvBmEsN0mzSw@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-11-git-send-email-pclouds@gmail.com>
	<CAPig+cRPpdfNYP=8o+9ku7Lr6bQ3EBiFQcS_aM4YBVhCbuJ3sQ@mail.gmail.com>
	<CACsJy8CSZZptDr6rWTNES1peDrkk5k7Ai9mzQvSBDZz7FGJxLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 20:44:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIkOj-0000hV-GA
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 20:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbaBZToA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 14:44:00 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:56590 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbaBZToA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 14:44:00 -0500
Received: by mail-yh0-f41.google.com with SMTP id f73so1571906yha.28
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 11:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wiesjg5RbquqGvmzE3M67O3CoQ79gnLkddPsAX/ZPzE=;
        b=kK80MQ5sGqMQb6o6GwStLPpB1XPQNqD68OyZMfBVRN+JmbJnzA8JZC3tmBNzDrrDDQ
         vxwhI5Jbkih9lR7aW0pnDNm7/1wrEv+pqQ7MDch0ArscNUgVFqOIn6GnUybkRqvJQwfw
         LwZ9mXpaPxU++BU7o/5a/VD9oPpkREu5CZFpwXzP5GZYE/Ejy06YTrGj2miruhev6NZt
         cvwAbE3Fh/NXTuMox3W9bfRs1Ttrf0ipaP3wIhy8Q8eWYhwhU28B7d2yfbkXMYHdDQ1S
         ReX4xYThgvs32+WCnEHb5o/o1xaYt1qjw5gULRJPAfak7bRWwzjIzkDG4YWHvlzTSO7b
         UKew==
X-Received: by 10.236.50.194 with SMTP id z42mr3441078yhb.145.1393443839255;
 Wed, 26 Feb 2014 11:43:59 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Wed, 26 Feb 2014 11:43:59 -0800 (PST)
In-Reply-To: <CACsJy8CSZZptDr6rWTNES1peDrkk5k7Ai9mzQvSBDZz7FGJxLA@mail.gmail.com>
X-Google-Sender-Auth: BiplYwW8Pc-xEkmKb5PaF9U1MJE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242750>

On Wed, Feb 26, 2014 at 5:55 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Feb 26, 2014 at 8:24 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> +'GIT_COMMON_DIR'::
>>> +       If this variable is set to a path, non-worktree files that are
>>> +       normally in $GIT_DIR will be taken from this path
>>> +       instead. Worktree-specific files such as HEAD or index are
>>> +       taken from $GIT_DIR. This variable has lower precedence than
>>> +       other path variables such as GIT_INDEX_FILE,
>>> +       GIT_OBJECT_DIRECTORY...
>>
>> For a person not familiar with "git checkout --to" or its underlying
>> implementation, this description may be lacking. Such a reader may be
>> left wondering about GIT_COMMON_DIR's overall purpose, and when and
>> how it should be used. Perhaps it would make sense to talk a bit about
>> "git checkout --to" here?
>
> I don't want to repeat too much. Maybe mention about "git checkout
> --to" and point them to git-checkout man page?

Yes, that might be sufficient. "git checkout --to" documentation
points the reader at the "MULTIPLE CHECKOUT MODE" section which gives
a more detailed explanation of GIT_COMMON_DIR, so a user wanting to
understand GIT_COMMON_DIR better would have a way to find the
information.
