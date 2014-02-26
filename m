From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 10/25] Add new environment variable $GIT_COMMON_DIR
Date: Wed, 26 Feb 2014 17:55:54 +0700
Message-ID: <CACsJy8CSZZptDr6rWTNES1peDrkk5k7Ai9mzQvSBDZz7FGJxLA@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-11-git-send-email-pclouds@gmail.com> <CAPig+cRPpdfNYP=8o+9ku7Lr6bQ3EBiFQcS_aM4YBVhCbuJ3sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 11:56:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIcA9-0004gI-3f
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 11:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbaBZK4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 05:56:25 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:41849 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbaBZK4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 05:56:25 -0500
Received: by mail-qa0-f41.google.com with SMTP id j5so844946qaq.0
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 02:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zCINn5EtKAbhBdxrggNTwdsPUadSguOtEZnDdpv4XSI=;
        b=oFhYxXVnmnZ0DePcGp31uqosZwNNb261dRrUTQ7qwDqq5P7kYUofPRFeNEVlUM+SqU
         a0yscISLa0qI8vYQ1xEd/0UgGM12Suc/907wNw4vna+YJNs+AYYdUQdmb0S2PnoJIk9t
         tbFAsZfSmFLZECd3vPe3+HcO1MK3lvOQu9dIBkX4DJmS3y8pbp8TB8a9L6u0U6NnjEf6
         bAsnBxXqBP4geDc7UTULEc2AxzJ+gMc8gHBrXVUh/9zMwYa4ohauWwwxH5L5bcdBmcK3
         E5Kua5hT8T3IAWRYLlXUSqgvtnk1mmZrQqwyFAq3uKI6zC8l88fY1Sd9d9h2DqpMtcKX
         59qw==
X-Received: by 10.224.167.84 with SMTP id p20mr7086664qay.24.1393412184184;
 Wed, 26 Feb 2014 02:56:24 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 26 Feb 2014 02:55:54 -0800 (PST)
In-Reply-To: <CAPig+cRPpdfNYP=8o+9ku7Lr6bQ3EBiFQcS_aM4YBVhCbuJ3sQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242715>

On Wed, Feb 26, 2014 at 8:24 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +'GIT_COMMON_DIR'::
>> +       If this variable is set to a path, non-worktree files that are
>> +       normally in $GIT_DIR will be taken from this path
>> +       instead. Worktree-specific files such as HEAD or index are
>> +       taken from $GIT_DIR. This variable has lower precedence than
>> +       other path variables such as GIT_INDEX_FILE,
>> +       GIT_OBJECT_DIRECTORY...
>
> For a person not familiar with "git checkout --to" or its underlying
> implementation, this description may be lacking. Such a reader may be
> left wondering about GIT_COMMON_DIR's overall purpose, and when and
> how it should be used. Perhaps it would make sense to talk a bit about
> "git checkout --to" here?

I don't want to repeat too much. Maybe mention about "git checkout
--to" and point them to git-checkout man page?
-- 
Duy
