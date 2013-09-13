From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Removing all notes containing a specific string
Date: Fri, 13 Sep 2013 17:43:23 +0200
Message-ID: <CAC9WiBj0SEwZmqjGPpJTzStic0RJ2vLnN39mTenji4rCeyH26A@mail.gmail.com>
References: <CAC9WiBi4=SVF6SE0hpccPLRdv-n8hcRUg+Pa+BbRWN1YudtXjQ@mail.gmail.com>
	<CALKQrgfX-tEm84h8a2qcaoZuZ0U7BCe34V0HMyuvJHCX72-y=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Sep 13 17:43:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKVWq-0006C6-Qo
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 17:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757204Ab3IMPnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 11:43:25 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:51000 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755799Ab3IMPnY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 11:43:24 -0400
Received: by mail-vc0-f179.google.com with SMTP id ht10so1081883vcb.10
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 08:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=optIt+QYZP8yy5XLO/Cn2ncWI1J50h+zmcLbvgrn03E=;
        b=lzT/AurnQvWKMI9uUAPMXVQ7RwLAQ+NlA/o/0tbAKxlvSvKKj73TCokSePPwtYqrqA
         oguJ4162D7s/QR6CEkLrcg6FPnsEmCVvcKTSrsurV7gJ4ZS0FHTOpFyEh8k0ON6R3JJm
         E48cG4bQWKaEE/KFJSKUTfODKUP/yOor5oPX3kh9rCgSDBc6vIKeuDfjKVfn0ClMyIVe
         IUOGDvZO/8waqkwb7a+xjWGS2rIGxqeDZA13Lj0zekdZ9Cb16fiaDPCnOAekvX/hU68D
         bAoNARj99yq8Q1OsR+X8tvf0OFGZmCrkO4MzOcx9/IfcNgiWtWKjvZEG92e6Q2RMKfRi
         AmXg==
X-Received: by 10.58.118.130 with SMTP id km2mr12469333veb.0.1379087003364;
 Fri, 13 Sep 2013 08:43:23 -0700 (PDT)
Received: by 10.58.96.109 with HTTP; Fri, 13 Sep 2013 08:43:23 -0700 (PDT)
In-Reply-To: <CALKQrgfX-tEm84h8a2qcaoZuZ0U7BCe34V0HMyuvJHCX72-y=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234757>

On Fri, Sep 13, 2013 at 10:12 AM, Johan Herland <johan@herland.net> wrote:
> On Fri, Sep 13, 2013 at 8:51 AM, Francis Moreau <francis.moro@gmail.com> wrote:
>> Hello,
>>
>> I'd like to know if that's possible to parse all notes to detect a
>> special string and if it's the case, remove the note like "git-notes
>> remove" would do.
>
> Hi,
>
> There's no built-in command/option to do this, but the following shell
> one-liner should do the job:
>
>   git grep -l $mystring refs/notes/commits | cut -d':' -f2 | tr -d '/'
> | xargs git notes remove
>

Looks "magic" to me but does the trick

Thanks !
-- 
Francis
