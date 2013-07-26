From: Daniele Segato <daniele.segato@gmail.com>
Subject: Re: [PATCH] git-tag man: when to use lightweight or annotated tags
Date: Fri, 26 Jul 2013 10:44:54 +0200
Message-ID: <51F23706.5040009@gmail.com>
References: <51EFA9A9.4010103@gmail.com> <7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com> <51F13A8F.9040400@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 10:45:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2deA-0004aI-8u
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 10:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248Ab3GZIpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 04:45:06 -0400
Received: from mail-bk0-f43.google.com ([209.85.214.43]:35426 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab3GZIo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 04:44:59 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so568128bkc.16
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 01:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=63LDDRZFu7k7LT2OXeSnqQ6z7BWdM1YiYqYbFd32Anc=;
        b=vmpFHnYztRCI7GmBffWkE/iltAF81I0JFA8gIgmWXOOjrdufvBA8sqQa9tKVUnrTFl
         7s74s9PTY0TM3fi8Dk6Ia4BdqUQeLvW84PXB/OvRSXe0o1Qw+8Ek755lHSVKUZOfJDd6
         mge50YqlJItIcVT+A+O0AOTNQB1gJnMYJxxe2sR9lPcLQ2fclGg90SjzdbNhVNJgzsfL
         f8D3umPYGZXG8Hy/HVr4bYWSJwElLVg1P20bR2T3YcG99plQbDP5NDVYhQJFB9Hbf/C9
         w2cSDMAXP77hnM2CKoQXI9jJ3Zc3hwy79++12QcLTmajRaOuBqf7YStVIglDa1Hro4ha
         OJew==
X-Received: by 10.204.191.79 with SMTP id dl15mr1960526bkb.82.1374828298032;
        Fri, 26 Jul 2013 01:44:58 -0700 (PDT)
Received: from [192.168.1.16] (host22-75-dynamic.4-87-r.retail.telecomitalia.it. [87.4.75.22])
        by mx.google.com with ESMTPSA id qw6sm11993693bkb.4.2013.07.26.01.44.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Jul 2013 01:44:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51F13A8F.9040400@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231173>

On 07/25/2013 04:47 PM, Marc Branchaud wrote:
> On 13-07-25 09:45 AM, Daniele Segato wrote:
>>  From d0f4eca712e7cf74286bfab306763a8a571b6c95 Mon Sep 17 00:00:00 2001
>> From: Daniele Segato <daniele.segato@gmail.com>
>> Date: Thu, 25 Jul 2013 15:33:18 +0200
>> Subject: [PATCH] git-tag man: when to use lightweight or annotated tags
>>
>> stress the difference between the two with suggestion on when the user
>> should use one in place of the other.
>>
>> Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
>> ---
>>   Documentation/git-tag.txt |    4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>> index 22894cb..48f5504 100644
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -36,6 +36,10 @@ are absent, `-a` is implied.
>>   Otherwise just a tag reference for the SHA-1 object name of the commit
>> object is
>>   created (i.e. a lightweight tag).
>>
>> +Annotated and Lightweight tags are not the same thing for git and you shouldn't
>> +mix them up. Annotated tags are meant for release while lightweight tags are
>> +meant to tag random commits.
>
> Unfortunately the word "annotated" hasn't yet been introduced at this point,
> so the overall effect is even more confusing.

Actually annotated tag has already be introduced but they haven't been 
named "Annotated" yet; what about changing the above paragraph like this:

  If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
-creates a 'tag' object, and requires a tag message.  Unless
+creates a 'tag' object called 'Annotated tag', and requires a tag 
message. Unless
  `-m <msg>` or `-F <file>` is given, an editor is started for the user 
to type
  in the tag message.




> Also, I find the "release" vs.
> "random" distinction a bit misleading since both types of tag can refer to
> any object.

I can change it into something like these (using your suggestion below):
"Annotated tags are meant for release while lightweight tags are meant 
for private or temporary object labels."

What do you think?

>  I also liked the direction of your earlier "command only
> consider annotated tags by default" phrasing.

I also think it would be helpful. We can write this after the previous 
sentence:
"Most git commands only consider Annotated tags by default."



> After reading the Tagging section of the Git Book[1] I came up with the
> following.  Feel free to modify it as you like, or ignore it completely:
>
> Tag objects (created with -a) are called annotated tags.  While a lightweight
> tag is simply a name for an object (usually a commit object), an annotated
> tag contains the creation date, the tagger's name and e-mail, a tagging
> message, and can be signed and verified with GNU Privacy Guard (GnuPG).  Most
> git commands only consider annotated tags by default.  In general lightweight
> tags are for private or temporary object labels, while annotated tags are
> meant to be permanent and/or published.  For example, an annotated tag is
> normally used to identify a release point.
>
> 		M.
>
> [1] http://git-scm.com/book/en/Git-Basics-Tagging
>

I took some inspiration but I think writing about what a tag object 
contains in the documentation is not useful at that point in the doc. 
What's important there is that user do understand the difference between 
Annotated and Lightweight tags.

I'll follow with a patch containing these modification I'm talking 
about, should be easier to comment.

Regards,
Daniele
