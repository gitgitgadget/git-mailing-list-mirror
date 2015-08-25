From: Stefan Beller <sbeller@google.com>
Subject: Re: Git's inconsistent command line options
Date: Tue, 25 Aug 2015 15:06:20 -0700
Message-ID: <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org>
	<CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
	<CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 00:06:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUMMS-0002Qd-Vd
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 00:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236AbbHYWGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 18:06:22 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:36434 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbbHYWGV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 18:06:21 -0400
Received: by qgeb6 with SMTP id b6so115485630qge.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 15:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UD+DgYnM2dk+CBvgVNVNSc/qDn79Ko2HYW6gf4rLdQY=;
        b=RxklBx57v0RihjYoMDfzlLCtCfJsD11blSPjVOUNdfcGYoz1HlbYjVc4VLTEaMfAWf
         8XyOgPf5ZoXh3lTpTXUaZlXQRrN7z+GGvA8FZppAVM/Jb+pPzLyQeQ0k6MqF5nR0cYGX
         bzFV/WNhu6GhtBZT6k5zMoXSxT8+uj6Mma2BjvsNaJ64wsA83bdYUr1WTnWFbvVMCZVO
         NenQU97XtEy7jvilF2Ux3u4GTdrNrf2r+Eu8t7ktG+rwLFXsJJQhVG9l+nTjquIX5fT0
         yxP87pUf2Dbg5KbzsUMv3eB6cSk004qU2v7L/bKJRb+kemYmOJoKQQx0+ancysK8MJve
         YkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UD+DgYnM2dk+CBvgVNVNSc/qDn79Ko2HYW6gf4rLdQY=;
        b=Br7YpknT9Xm9wv7LjFlPSKWAV4HxH0NUCVxVL1ESNXtizbFuyRh65o1DR8JXxhQu3K
         9HKuZp9up3ZdstGq9ss2YTikRjJ85LUa7ELToXg41Kv1GcO0i5m5yTt2Y8fQOEdYJMzg
         HhZSA39SxjcM1hudohm7T7doAnC+lwW4frdo7z/bHMeYaB27JEbK/AzsZMUUXAjinizA
         uWgGabGxx+x/nEDbCR7cv3A+womflSch1Y29ElPaY7IVSbYL0LiqXfg3kzZcJeZKRXwN
         gbx/MpYbbQKqFF6oETne9Z53hd1kclj5D6ttUo1zyePdmD072lKUDS6YRi4uPjXQlusZ
         Sqsw==
X-Gm-Message-State: ALoCoQmT75piud9Mgxc+vg/fFkCAVaecW2PdXVfR/MREOwIS9q4fj4Xe2dWZ8LxXy6A97YolSkPl
X-Received: by 10.140.147.69 with SMTP id 66mr74717135qht.57.1440540380385;
 Tue, 25 Aug 2015 15:06:20 -0700 (PDT)
Received: by 10.140.41.198 with HTTP; Tue, 25 Aug 2015 15:06:20 -0700 (PDT)
In-Reply-To: <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276578>

On Tue, Aug 25, 2015 at 2:49 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Aug 25, 2015 at 8:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> On Tue, Aug 25, 2015 at 1:01 AM, Graeme Geldenhuys <graemeg@gmail.com> wrote:
>>>
>>> Even though I have worked with Git since 2009, I still have to
>>> reference the help to remind me of what parameter to use in certain
>>> situation simply because similar tasks differ so much.
>>>
>>> Maybe we could address this in the next major version of Git? Has
>>> anybody else thought about this or started work on this? Or was this
>>> discussed before and declined (link?).
>>
>> http://article.gmane.org/gmane.comp.version-control.git/231478 comes to mind,
>> which has been linked from this entry:
>>
>> Discuss and decide if we want to choose between the "mode word" UI
>> (e.g. "git submodule add") and the "mode option" UI (e.g. "git tag --delete")
>> and standardise on one; if it turns out to be a good idea, devise the migration
>> plan to break the backward-compatibility.
>>
>> in http://git-blame.blogspot.com/p/leftover-bits.html
>
> I would vote for command words, as this is clean and simple.

me too after rereading the arguments in that thread.

> The
> downside is in converting all the old options based commands, git-tag,
> and similar. These commands cannot easily convert because "valid"
> sequences would become invalid with no easy way to deprecate for
> example in the linked gmane above, "git tag delete master" can't be a
> call to delete master as it is currently a call to create a tag
> "delete" at the commit marked by master.

git-tag being a porcelain command (i.e. we do not give a promise to keep
it set to stone) can be changed with a deprecation announcement period.
Say starting with Git 2.6 we would put out warnings for upcoming commands:

 $ git tag --delete master
 $ echo $?
 # 0 # actually works as of today!

 $ git tag delete master
 #  Due to the planned switch to command words, this doesn't work.
 #  For details see road map at  `man git commandwords-roadmaps`
 $ echo $?
 # 128 maybe ?

$ git tag create delete

And after a while (maybe 3-5 years, once this version is picked up by
debian stable as well as red hat stable)
we can change it, so with Git 3.4(?)

 $ git tag --delete master
 # --delete is deprecated since 3.4, use `git tag delete` instead
 $ echo $?
 # 128

 $ git tag delete master
 # --delete is deprecated since 2.6, use `git tag delete` instead
 $ echo $?
 # 0 # actually works!

>
> I can't think of an easy way to deprecate the change in behavior over
> time, which means that making a conversion would require some other as
> yet unknown way?
>
> It may be possible to convert other options based commands, such as
> how git-branch and git-checkout do things which seem highly unrelated.
> A good example is how checkout is used to both change branches, as
> well as can create a branch, and can also checkout a file. The "reset"
> command is used to rewind history, as well as potentially reset *all*
> files, but it can't be used to reset a single file, and is completely
> different from revert. Some of these distinctions are ok because it's
> just no good way to make everything easy.
>
> Some of these could be fixed by the command word setup, but as many
> have mentioned an actual migration plan is difficult.
>
> Personally, I don't want to move to the command option "--status"
> format, as I think these aren't really options, and are very much
> sub-subcommands. I think we should try to push more uses of this
> style, and try to determine a possible migration path towards using
> them. Maybe some warts simply aren't worth the effort to fix though.
>
> Other issues are tricker to solve, and are result of git exposing more
> complex functionality and users eventually simply have to learn and
> understand.
>
> Regards,
> Jake
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
