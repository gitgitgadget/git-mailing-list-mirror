From: Ori Avtalion <ori@avtalion.name>
Subject: Re: [PATCH] Change mentions of "git programs" to "git commands"
Date: Sat, 08 Aug 2009 16:26:10 +0300
Message-ID: <4A7D7CF2.40902@avtalion.name>
References: <4a7c3971.170d660a.3caa.20b3@mx.google.com> <7v4osj1odt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 15:26:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZlwG-0005He-Hp
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 15:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbZHHN0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 09:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbZHHN0Q
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 09:26:16 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:59308 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbZHHN0P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 09:26:15 -0400
Received: by fxm28 with SMTP id 28so232724fxm.17
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 06:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=OXyio6YJmeHJxExtF/zJxl/nGQP2GF3N369+cul9qPY=;
        b=lpW8mPWAxyHBWUZrwAq+PNJ0yAUS8uBG1EPAyfJ16010LlLnTCFQ+5PPRQieaS1r43
         jz+XYHyEfq6xH8YSLlShiVJaJwvu62Q3Qa7NQIfrbERxCA284+Beav8FqPEUO4eGQtZn
         q0cRUnfGJIsEcE6InEJVcIQl+ZeqoQkQieERc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=sihAxpkcwL+NvAmFIeJjGeDLmBGX7INrIgmXxuxsZ3cR+IvdtvuGWzWA7dLYL/aci4
         VUqRn9tlJg8V8EzSCzyaFksUnDSmGJBAnXz+ro2KVJtgT9mmd/Bf11C99hPCxLUfNjd1
         g0w2ng1LfGzi79VsIT/64W5Sl8DpocpdKeXm0=
Received: by 10.103.1.7 with SMTP id d7mr980751mui.122.1249737975503;
        Sat, 08 Aug 2009 06:26:15 -0700 (PDT)
Received: from ?192.168.1.55? (bzq-82-81-24-228.red.bezeqint.net [82.81.24.228])
        by mx.google.com with ESMTPS id j9sm10503081mue.26.2009.08.08.06.26.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 06:26:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1.3pre) Gecko/20090807 Shredder/3.0b4pre
In-Reply-To: <7v4osj1odt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125278>

On 08/07/2009 09:15 PM, Junio C Hamano wrote:
> Ori Avtalion<ori@avtalion.name>  writes:
>
>> Most of the docs and printouts refer to "commands".
>> This patch changes the other terminology to be consistent.
>
> Thanks, but not really.
>
>> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
>> index d313795..20bf512 100644
>> --- a/Documentation/fetch-options.txt
>> +++ b/Documentation/fetch-options.txt
>> @@ -1,7 +1,7 @@
>>   -q::
>>   --quiet::
>>   	Pass --quiet to git-fetch-pack and silence any other internally
>> -	used programs.
>> +	used utilities.
>
> This does not have much to do with what you claim to have done in the
> commit log message nor the title.  Probably "utilities" is a slightly
> better word than "programs" in this context but not by a wide margin.
>

I picked the word from the glossary definition of "core git":

   "Fundamental data structures and utilities of git. [...]"

If that doesn't fit, how about:
    "Pass --quiet to git-fetch-pack and silence other output" ?

>> -'git-rev-list' is a very essential git program, since it
>> +'git-rev-list' is a very essential git command, since it
>>   provides the ability to build and traverse commit ancestry graphs. For
>>   this reason, it has a lot of different options that enables it to be
>>   used by commands as different as 'git-bisect' and
>
> Ok, but probably we would want to say "git rev-list" here.

In that case, shouldn't all of the manpages be changed to say "git foo" 
instead of "git-foo" under the NAME section?

I see the "git-foo" notation as a convention for git commands.
It may be for historical reasons, but the manpage for the "pull" git 
command is "git-pull", and that is how commands are mentioned all over 
the documentation.

>
>>   --exec-path::
>> -	Path to wherever your core git programs are installed.
>> +	Path to wherever your core git commands are installed.
>
> I do not think this is a good change.
>
> When you talk about git "command", e.g. "'git rev-list' is an essential
> command", you are talking about an abstract concept.  In the reader's
> world view, there is one single toplevel program called "git" and it has
> various commands, one of which is 'rev-list'.  But this description is not
> about an abstract concept of command, but is about a particular
> implementation detail.  For every git command, there is a corresponding
> git _program_ that implements that command, and --exec-path tells you (or
> you use --exec-path to tell the git toplevel program) where they are.
>
> You kept this intact in gitcore-tutorial:
>
>      ... Also
>      you need to make sure that you have the 'git-receive-pack'
>      program on the `$PATH`.
>
> and I think you did the right thing.  This is about a concrete instance of
> a program.  If you really really want to say _command_, you would probably
> want to do something like this instead:
>
>   --exec-path::
> -	Path to wherever your core git programs are installed.
> +	Path to the directory that holds programs that implements git commands.
>

I agree with the suggestion.


I found a few other instances that should probably be changed.

In git.txt:
"The following are helper programs used by the above"
                           ^^^^^^^^
                           commands

In git-mailsplit.txt (and cmds-purehelpers.txt):
    "Simple UNIX mbox splitter program."

Maybe the word "program" should just be dropped.


I'll submit a new patch once there's an agreement on the changes.

-Ori
