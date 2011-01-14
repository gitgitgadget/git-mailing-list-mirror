From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/1] fixup! Documentation: start to explain what git replace is for
Date: Fri, 14 Jan 2011 23:48:30 +0100
Message-ID: <201101142348.31647.jnareb@gmail.com>
References: <746745466.20110111134101@mail.ru> <20110114084903.GD11343@burratino> <4D308B69.1050003@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Aleksey Shumkin <zapped@mail.ru>
To: Maaartin-1 <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Fri Jan 14 23:48:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdsRl-0006a3-Bw
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 23:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab1ANWse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 17:48:34 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64882 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643Ab1ANWsd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 17:48:33 -0500
Received: by wwa36 with SMTP id 36so3545771wwa.1
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 14:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=XtvAw3LH3vZANy80upklpH40Tuk09/8MoQtvgzxOBqs=;
        b=EfFLROa6Ce54IMrudcBvjvziVKUQFkhCXgIp2At3YFS4AO8Hob+p7XVEim1i5FTBWI
         vqRJzrf+2Weh+FbbhrpyY/bh4aTtvtGJIDAuqTmeYI8VajXPFORHf4nUcnFyhYYbd2or
         nnalnUIUUOEyXmTrnaeieZkI+f1kDP6e68X8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Qi4kye2IzFeXsiJRkLM4KTdu5YTk/kUhkfa73Ya0agkO6ZekBQZxZuN73xPOotRRPh
         QeFVugKlU0mD0Y+QsNT5NQXRGN/OcnXFBVpOvqOmazrfnjXFV4x0vs/bzSmZQjGy5MaY
         dH0jO5CcE7b0Brf7Fb6sCTHuxNxtFQcOl+ghY=
Received: by 10.227.157.17 with SMTP id z17mr1273597wbw.78.1295045312356;
        Fri, 14 Jan 2011 14:48:32 -0800 (PST)
Received: from [192.168.1.13] (abwj119.neoplus.adsl.tpnet.pl [83.8.233.119])
        by mx.google.com with ESMTPS id 11sm1284192wbi.12.2011.01.14.14.48.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 14:48:30 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D308B69.1050003@seznam.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165129>

On Fri, 14 Jan 2011, Maaartin-1 wrote:
> On 11-01-14 09:49, Jonathan Nieder wrote:
> > Some tweaks suggested by Maaartin:
> 
> [snip]
> 
>> [side note: please do not prune the cc list; I only stumbled on this
>> message in the online archive by luck]
> 
> What could I have done about it? I didn't received it by email and
> answered using post.gmane.org. There's no way to add CC there. If I'd
> wrote an email instead, it wouldn't be placed in the thread.

In a good newsreader, like e.g. Gnus from GNU Emacs, you have option
to do 'reply all via email', which includes also git@vger.kernel.org,
i.e. mailing list from which gmane newsgroup is created.  That's what
I do nowadays (usually).

> [snip]
> 
>>>> +<1> Find all parentless commits in the 'master' branch;
>>>> +for 'master' read the branch holding v2.5 history.
>>>
>>> Aren't you later calling it "FIRST" and assuming there's only one?
>> 
>> Hmm.  I want to say that there _could_ be multiple parentless commits
>> in the v2.5 history and we are treating one of them as its root (just
>> like git master has multiple parentless ancestors but e83c5163 is
>> conventionally considered its beginning).  Not sure how to write that
>> clearly.
> 
> Maybe just something like "Let's assume there's only one and let's call
> it FIRST". For the example, this is enough.

That might be good enough, as I don't think that at beginning (where you
are creating current and archive repository) one would have multiple roots
from joining separate projects.
 
>>> Isn't the combination of "-i" (=in-place edit) with redirection wrong?
>> 
>> Good catch (the "-i" is a typo).
> 
> I'd go the other way round and use "-i" so I'd need only one file. Using
> a shell variable instead would be even better, s. below.

No, using shell variable for storing commit object is *not* a good idea.
Either save it to temporary file, where you can edit it using editor of
your choice, or use pipeline.
 
> [snip]
> 
> I tried to use the vars instead of files below, but never tested it. I
> used "first_commit" instead of both "tmp" and "new", which is not really
> nice.
> 
>> +$ git rev-list master --parents | grep -v ' '
>> +$ first=$(git rev-list master --parents | grep -v ' ') <1>

Or using always the oldest commit:

   +$ first=$(git rev-list master --date-order --parents | grep -v ' ' | tail -1) <1>


>> +$ git rev-parse v2.4                                   <2>

Let's save it to a variable too

   +$ join=$(git rev-parse v2.4)                           <2>


>> +$ git cat-file commit $first >tmp                      <3>

We can use COMMIT, or even FIRST as a file name here.

> $ first_commit = $(git cat-file commit FIRST)            <3>

No.  Just... no.

> > +$ sed "/^tree / a \\
> > +parent $(git rev-parse v2.4)" <tmp >new                <4>
> 
> $ first_commit = $($ echo $first_commit |
> sed  "/^tree / a \\
> parent $(git rev-parse v2.4)")                      <4>
> 
> Unfortunately, the line got too long. For sed unaware people like me it
> may not be obvious that a line break is required.

No, it is not required, I think.

> I'd use perl, anyway. 
> 
> $ first_commit = $($ echo $first_commit |
> perl -p
> "s/^tree .*/$&\nparent $(git rev-parse v2.4)/")      <4>
> 
> > +$ new_commit=$(git hash-object -t commit -w new)       <5>
> 
> $ new_commit=$(echo $first_commit |
> git hash-object -t commit -w --stdin)       <5>

If you don't use temporary file, which you can edit, you can use pipeline
instead:

  $ new_commit=$(git cat-file commit $first_commit |
                 sed -e "/^tree / a\\parent $(git rev-parse v2.4)" |
                 git hash-object -t commit -w --stdin

  $ git replace $first_commit $new_commit

-- 
Jakub Narebski
Poland
