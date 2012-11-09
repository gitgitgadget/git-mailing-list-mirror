From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Rename edge case...
Date: Fri, 9 Nov 2012 17:30:24 +0700
Message-ID: <CACsJy8C6RSnJL=1kWZY8JjXOE9EJGVQL-FFhMN-DNnv9EhH3Cw@mail.gmail.com>
References: <CAEBDL5U+OSTCAqgWoApE_m21Nef24Wqvt78oB6qqV4oEvU0vXQ@mail.gmail.com>
 <1352453243-ner-1164@calvin> <CAEBDL5WeQEWdyaJuuNbnnQbbsLYv8NO1ZSj3eHHpjW+ToS9X1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 11:31:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWlrh-0003je-ES
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 11:31:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab2KIKa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 05:30:56 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52708 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab2KIKaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 05:30:55 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so3863409oag.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 02:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=F2/0aC52lmzmUvf+szJAHYMfoid2nExIIL4ekzyLrL8=;
        b=jkGKkshMc1NzQgBiB+fKFfVsKErifb+0Adx4GHimXl0lasRVOwlWPWcDfZMNpx2gJQ
         23wwhr/iXE6zoJ6w4eUdgwqKxAU6Vzf0dlpEnKVTmkWyMtMFnub5EWSW8KgI5OXHLvxM
         Q8gCzKONykmUDcTtGh4guvM2IKHDSlJp/bPD2FLBZfx75qJKS1+wZcKK69fhGcDbycjK
         FSR0gQAhbInjgIXjl5/VzcFW++yOPWAfb1spKxX+mgXgQug7sndXuaQ/ouULcjLP3U3P
         Z874sVD0aZ2GOkKYS7oi9PiG9BoaW3cLdr//P7bU/HFng+/CaaDxzDSTFU3vuYmWgvFH
         DZ5Q==
Received: by 10.60.8.103 with SMTP id q7mr7323432oea.70.1352457054848; Fri, 09
 Nov 2012 02:30:54 -0800 (PST)
Received: by 10.182.49.41 with HTTP; Fri, 9 Nov 2012 02:30:24 -0800 (PST)
In-Reply-To: <CAEBDL5WeQEWdyaJuuNbnnQbbsLYv8NO1ZSj3eHHpjW+ToS9X1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209212>

On Fri, Nov 9, 2012 at 5:25 PM, John Szakmeister <john@szakmeister.net> wrote:
> On Fri, Nov 9, 2012 at 4:27 AM, Tomas Carnecky <tomas.carnecky@gmail.com> wrote:
> [snip]
>> When merging two branches, git only looks at the tips. It doesn't inspect
>> their histories to see how the files were moved around. So i doesn't matter
>> whether you rename the files in a single commit or multiple commits. The
>> resulting tree is always the same.
>
> I guess I figured that when I saw the final result, but didn't know if
> there was a way to coax Git into doing a better job here.  I guess not
> though.

There is not (yet). There were a few patches around that allow users
to override git's automatic renames. You can search the mail archive.
I think the keywords are "rename cache". Thanks for reminding me for
putting a higher priority on that.
-- 
Duy
