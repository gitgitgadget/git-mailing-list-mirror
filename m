From: Rossella Barletta <rossella.barletta@gmail.com>
Subject: Re: Permission denied ONLY after pulling bundles
Date: Mon, 8 Jun 2015 17:19:52 +0200
Message-ID: <CAJeiYQH2fK3EMXUV9Qrbf+19Dp1Ls0KR58DnJfEzKih6NUrO6Q@mail.gmail.com>
References: <CAJeiYQGUsB-9XYdnqDgoSy5JU-EVTbf-1OuTU5BGfpT9q6xKbg@mail.gmail.com>
	<CAP8UFD1=96Y484GvG9ms2uiWm2uyWO0qE2Lh6SH2UwrwHpEF8w@mail.gmail.com>
	<41C6F74EB68C43E183AF26092D2AAD44@PhilipOakley>
	<CAJeiYQH9jF4S6FivHW5xc_xeef5kL1r1xF+yjJuHf7Wa0yUifw@mail.gmail.com>
	<CAP8UFD0gMCnaJnXNxe6Tmwxes7c4Wqgga1d8AzSNEcFxtHtGWg@mail.gmail.com>
	<CAJeiYQHmXjxdk7eGSsd9TN5hfPF72ssS-j0xGZ6QOYD+5Gb++g@mail.gmail.com>
	<CAJeiYQED8h3h9VGgcBfg9ddEBee7aGC+5HYpXEja6_vjy_hs6Q@mail.gmail.com>
	<CAEcj5uVQkeex=q_ssDYYo=jamYX-zdM2FvG61Kgzq-XDdzhtHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	git <git@vger.kernel.org>,
	"dario.ligorio" <dario.ligorio@selex-es.com>
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 17:20:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1yqI-0007HX-QU
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbbFHPTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:19:55 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33005 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbbFHPTx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:19:53 -0400
Received: by qgfa66 with SMTP id a66so14692869qgf.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O7I/87rjA55wCwVeJZUsVglXyaFI+7BR0clgplgfFZw=;
        b=FTd4BMvLyB4i6/1MtcPpemidvFG6UjksWzhhla95lALDLZWztTwP8ljcLzop0oWcCZ
         wOIo7ALwSjmZrm5aMJt2L5YtFgl96S8nUNdMLPRKTP5rzuw4garURendqz1rrWQu+K2v
         zNfvnqHIk4SHCKUNefanshE1B9vZQPjilOlW5+/+9Ll1/VkhNT6cM02QVgAYK1wkHkDN
         kJ7b4yZi64uTGuHpw66bUq16C7sEI7r4WVkaMNC//Ve//RkJTP0RqqazjJFNQXBEA1cb
         oesS6LVDJrYVqeXNFTMNlyLxFLJcRVso286LNzO5F7F2OzYnadSe3onr2eaEeQQaNoSR
         Rt1Q==
X-Received: by 10.229.98.200 with SMTP id r8mr21023789qcn.15.1433776792863;
 Mon, 08 Jun 2015 08:19:52 -0700 (PDT)
Received: by 10.96.58.165 with HTTP; Mon, 8 Jun 2015 08:19:52 -0700 (PDT)
In-Reply-To: <CAEcj5uVQkeex=q_ssDYYo=jamYX-zdM2FvG61Kgzq-XDdzhtHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271049>

Dear Thomas,

Unfortunatly for me i cannot send the files, since there are
restrictions, but thanks for your offer.

At the moment also configuring the repo with --shared=all is not
helping, but i could try to reproduce the problem with a fake repo
shared between windows and linux and see if i get the same error and
at the point i will share the files

with you.

Thanks again.



Rossella

2015-06-08 15:03 GMT+02:00 Thomas Ferris Nicolaisen <tfnico@gmail.com>:
> On Mon, Jun 8, 2015 at 10:47 AM, Rossella Barletta
> <rossella.barletta@gmail.com> wrote:
>>
>> So summarizing:
>>
>> 1)  Git repository (bare)  is on Windows on a shared folder
>> 2)  Clone of the repository is on Linux
>> 3) Clone of the repository is on windows
>> 4) I received a bundle made starting by a branch, i pull the bundle on
>> the same branch on Windows, i push the changes , everything ok
>> 5) I go on the clone on Linux, i pull the changes in the branch, make
>> some updates, push...but i get error message about permissions.
>>
>>
>>
>> 4-Alternative)  I received a bundle made starting by a branch, i pull
>> the bundle on the same branche on Linux, i push the changes ,
>> permission errors.
>>
>> The permissions of the files are all set to 777. It is not clear why
>> pushing (after pulling a bundle) on Linux gives permission problems.
>> Even thinking about the user, we have to take in account that before
>> pulling the bundle the same user was used and there was no problem
>> before.
>
> Just to quickly shoot in a thought: I've heard about some similar
> permission problems that occurred when setting up a bare repository
> (on a Linux system). They solved it by re-initializing the repository
> with --shared parameter.
>
> Looking what shared does in the documentation of git-init, the default
> is to use "umask" if --shared is "not specified". I'm not sure if even
> Windows has any sort of umask.. In any case, my wild guess is that
> some operations triggers the remote Git process/user to create new
> files (repack, gc, etc) that get restricted permissions on Windows.
>
> How do you set permissions to 777 on Windows? I didn't know Windows
> uses the same kind of permissions there.. Anyhow, is it possible for
> you to reset the permissions again so that the pushing works again
> (until the next bundle)? If you can do so, configure the bare
> repository to have --shared=all, and see if that helps.
>
> For more help, please share with us the following:
>
> * A complete zip of the bare repository where pushing still works
> (shared over Internet, not as email attachment)
> * The commands you are executing, and their complete output
> * A complete zip of the bare repository where pushing no longer works
> * The complete configuration of the Linux client where the push is
> failing (git config -l)
>
>
> Also noting that this seems to be cross-posted to StackOverflow:
> http://stackoverflow.com/questions/30500226/git-push-fatal-write-error-permission-denied-after-pulling-a-bundle



-- 
Rossella
