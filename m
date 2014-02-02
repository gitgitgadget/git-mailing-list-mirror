From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 3/4] setup: Add 'abspath_part_inside_repo' function
Date: Sun, 2 Feb 2014 09:23:32 +0700
Message-ID: <CACsJy8Drf5D273Tfaxpqjg==8jcB3iAaPKM4P0-ErF7mPCC1JQ@mail.gmail.com>
References: <20140131202142.GA9731@mule> <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391306351-13237-4-git-send-email-martinerikwerner@gmail.com> <CACsJy8A8hardH7EaopY2Xu5Ob50mew3pJdqAr6fJsqyyhLQYMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, richih@debian.org,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 02 03:24:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9mjB-0005dP-Dj
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 03:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbaBBCYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Feb 2014 21:24:04 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:54821 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbaBBCYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Feb 2014 21:24:03 -0500
Received: by mail-qa0-f46.google.com with SMTP id ii20so8136307qab.5
        for <git@vger.kernel.org>; Sat, 01 Feb 2014 18:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+LI1bsZKG7lh6BK4Cv1S789Ikpg7HngDCeY0vEQg9B8=;
        b=v7UYsw9HV2XUvkUO5JbCSubpOiwgkkRJwVr5b3lVkFoxwNXs7FCT3XRx3/LhgeyoaR
         WTotALH+m+6xI/wdqgX/UPF+i9UoTNZHqPzCQh4DkijiiTdoUmnJMNq4pzk8XXioOhAT
         cgnvjestqvWrfEpZy88KKz7CBDP8Yo3ZKmXFXq//4ee9DfJiPgC6uvLCFBB18g6pohsy
         lOhI9UspbqBEdMvEcGERhZjsnHPIs4GoO6VLD/v4q7HndV8fJ2ZfAdvoyQhFhBx2U8Qi
         WTr8d62IXrYU9c6Tae1dSP5bQ6NpWX9FhCqR/tZ6TXXRK+jZHeh7T28fd/RuYcA75YQZ
         02/g==
X-Received: by 10.140.107.138 with SMTP id h10mr41585643qgf.30.1391307842262;
 Sat, 01 Feb 2014 18:24:02 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sat, 1 Feb 2014 18:23:32 -0800 (PST)
In-Reply-To: <CACsJy8A8hardH7EaopY2Xu5Ob50mew3pJdqAr6fJsqyyhLQYMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241352>

On Sun, Feb 2, 2014 at 9:19 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> +       /* check whole path */
>> +       if (strcmp(real_path(path0), work_tree) == 0) {
>> +               *path0 = '\0';
>> +               return 0;
>> +       }
>
> I think this is already handled by the "check if work tree is already
> the prefix" block.

No, the "check if.." block does not do real_path() so we still need it
here. Sorry for the noise.
-- 
Duy
