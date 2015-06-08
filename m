From: Rossella Barletta <rossella.barletta@gmail.com>
Subject: Re: Permission denied ONLY after pulling bundles
Date: Mon, 8 Jun 2015 10:34:39 +0200
Message-ID: <CAJeiYQHmXjxdk7eGSsd9TN5hfPF72ssS-j0xGZ6QOYD+5Gb++g@mail.gmail.com>
References: <CAJeiYQGUsB-9XYdnqDgoSy5JU-EVTbf-1OuTU5BGfpT9q6xKbg@mail.gmail.com>
	<CAP8UFD1=96Y484GvG9ms2uiWm2uyWO0qE2Lh6SH2UwrwHpEF8w@mail.gmail.com>
	<41C6F74EB68C43E183AF26092D2AAD44@PhilipOakley>
	<CAJeiYQH9jF4S6FivHW5xc_xeef5kL1r1xF+yjJuHf7Wa0yUifw@mail.gmail.com>
	<CAP8UFD0gMCnaJnXNxe6Tmwxes7c4Wqgga1d8AzSNEcFxtHtGWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>, git <git@vger.kernel.org>,
	"dario.ligorio" <dario.ligorio@selex-es.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 10:35:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1sWC-0008M5-Hi
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 10:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbbFHIer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 04:34:47 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:32962 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbbFHIek (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 04:34:40 -0400
Received: by qkhg32 with SMTP id g32so74257055qkh.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 01:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zApf1hcfljUjEc+/B/UmjAO/rXQcCAwtv0H3yNzF6MI=;
        b=oI+0uKhS5SVBvaUsKKXdtg7fw7CKttjoxVrDFC9aLEgd/4ihVqueOOYuYfODt2mj1Z
         JYZS+LDOyyZJzxL32w7VwcgHw368ylwj4DKJCzMUOra+4iPODKUxO7rRGQ6iskyzpSDA
         2R2+B0I39oK47ahd+l9IePUNnKjwRpaH24WEgy6FjvmT1IamlsKJ+2j6LBqZohut2s8d
         GuXcYLn8R1QB3Eucd6RrvVKnKJZBIw4PWIZy0jCd1RHIOQlwac+5dI2VeRSZRPkvz+AY
         uunaXDBgUfKcL8XHql7NYdoYjefz/En5VvoDR3XGHNqo9Q9bxiNLyje885YAshWwGTKy
         n7dg==
X-Received: by 10.140.81.135 with SMTP id f7mr18068608qgd.33.1433752479496;
 Mon, 08 Jun 2015 01:34:39 -0700 (PDT)
Received: by 10.96.58.165 with HTTP; Mon, 8 Jun 2015 01:34:39 -0700 (PDT)
In-Reply-To: <CAP8UFD0gMCnaJnXNxe6Tmwxes7c4Wqgga1d8AzSNEcFxtHtGWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270992>

I followed all your indications (created a small fake repo on windows,
cloned it and playing with bundles)  and in this case everything
works.On windows i dont have any problem and i used the version 1.9.5.

Then i created a clone of my original repo, again on Windows (since my
original one is a bare repository) and i pulled the bundle and then
pushed in the branch and it worked. Same operation that doesnt work on
Linux works on Windows.

So i went again on Linux, pulled on my branch of the clone repo , i
has to commit first since i had some changes. So i committed, pulled,
and then pushed again.The push was unsuccessful giving the error
message that i indicated at the beginning.

So i cannot push only my clone on Linux.

Rossella

2015-06-05 18:01 GMT+02:00 Christian Couder <christian.couder@gmail.com>:
> On Fri, Jun 5, 2015 at 8:54 AM, Rossella Barletta
> <rossella.barletta@gmail.com> wrote:
>
> [...]
>
>> FIST ONE (PERMISSION PROBLEMS)
>>
>> - Repo is on windows
>> - Repo folder is shared
>> -Repo is a copy of another repository being on a machine in another
>> city on which we cannot access. We got all the files, included the
>> folder .git a put everything in our shared folder
>> - Mounted the Repo folder on Linux
>> -Created the clone
>> - got a bundle from the original repository (bundle created from a branch)
>> -pulled the bundle in the same branch
>>
>>
>>
>> SECOND ONE (NO PROBLEMS BUT WE CANT USE THIS)
>> - Repo is on Linux
>> -Repo is a copy of another repository being on a machine in another
>> city on which we cannot access.
>> - got a bundle from the original repository (bundle created from a branch)
>> -pulled the bundle in the same branch
>>
>>
>>
>> 4) Git version is 1.7.1
>
> It would be nice if you could try to reproduce the problem:
>
> - using a recent Git, as v1.7.1 is 5 years old,
> - using a small fake repo,
> - doing everything on Windows.
>
> Best,
> Christian.



-- 
Rossella
