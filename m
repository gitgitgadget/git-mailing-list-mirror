From: Jona Christopher Sahnwaldt <jc@sahnwaldt.de>
Subject: Re: "git checkout foo" is getting confused by folder named "foo"
Date: Wed, 25 Sep 2013 10:58:53 +0200
Message-ID: <CAEQewpqbf-sWSt0GS9eXQNi0yFz5-23NcO2JWKO4OgSFv3SXdA@mail.gmail.com>
References: <CAEQewpqLcDJPo2gUWPk-xc3OitdTC4gH2tnyqaURiQ77BApNog@mail.gmail.com>
 <CAJDDKr64ou+gO7WJLFZ4zOSv+VCbkiW7nKuZa9=5_fiSqGUeyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 10:59:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOkwM-0007Ll-86
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 10:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875Ab3IYI7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 04:59:16 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:40018 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab3IYI7O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 04:59:14 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so5780834pdj.30
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=JsGzMh1Ukkc5jCOYxSca/GLdDkouUYsFsNRwZAE75T8=;
        b=kXWYt6n1TzH43IZ0EtSAqaHYjqVa1boW83+zIInIlUDDRKJ50POlxScGeeQBd/9mLl
         QPtRNAIj4OG33L/HS46Ib2ObwqWka2BwP+KN4FMfDBkWDtvVHxcezlgQ0fifU0MmhLz2
         XBIbB1DuKn0kBSqvqm+to9u8HYiJiCWSndhydeGfznOFFF+FLdtZv6BQ8nqlIwByWIrV
         Gx80JewpgOfA6Ustm80DEcijqr9+ydxsN69efVreifYcScIu7H0kVQKeCKQvgdgMxQJV
         5n5JIEW+pIPQfeAXlYDhqOhCaXIrneatK1RofL2cPgmpxTmii3yWN+qYzRkPImLvyRDL
         MDOA==
X-Received: by 10.66.171.204 with SMTP id aw12mr32840475pac.7.1380099554067;
 Wed, 25 Sep 2013 01:59:14 -0700 (PDT)
Received: by 10.66.229.70 with HTTP; Wed, 25 Sep 2013 01:58:53 -0700 (PDT)
In-Reply-To: <CAJDDKr64ou+gO7WJLFZ4zOSv+VCbkiW7nKuZa9=5_fiSqGUeyQ@mail.gmail.com>
X-Google-Sender-Auth: o_DXKjVx1ZFtmHcMsltChFpm-OY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235337>

On 25 September 2013 04:51, David Aguilar <davvid@gmail.com> wrote:
> On Tue, Sep 24, 2013 at 2:07 PM, Jona Christopher Sahnwaldt
> <jc@sahnwaldt.de> wrote:
>> Hi,
>>
>> maybe this has already been reported, but I didn't find it in the mail archive.
>>
>> If I understand correctly, after I clone a repo, I should be able to
>> switch to branch foo just by running
>>
>> git checkout foo
>>
>> This doesn't seem to work if a folder called "foo" exists in the root
>> of the repo.
>
> git checkout foo --

Thanks for the suggestion, but it doesn't work for me. With both
1.7.9.5 and 1.8.3.2, I get this:

$ git checkout wiktionary --
fatal: invalid reference: wiktionary

When I try the full branch name:

$ git checkout origin/wiktionary --
Note: checking out 'origin/wiktionary'.
You are in 'detached HEAD' state. You can [...]

:-(

Christopher

>
> The double-dash at the end disambiguates between refs and paths.
>
> You can use that trick on any command that accepts refspec (branches,
> tags, etc) and pathspec (path patterns).
> --
> David
