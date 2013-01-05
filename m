From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: [PATCH] gitk: Display the date of a tag in a human friendly way.
Date: Sat, 5 Jan 2013 14:05:00 +0000
Message-ID: <CAM1C4Gm_ea8DgrVhnp_MHmqaF6pyDe98EDA_BPkjvc8M5AO6FQ@mail.gmail.com>
References: <1357314431-32710-1-git-send-email-wildfire@progsoc.org> <7vhamwse2c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 15:05:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrUNk-0004Yu-U4
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 15:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745Ab3AEOFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 09:05:34 -0500
Received: from mail-ea0-f177.google.com ([209.85.215.177]:59477 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556Ab3AEOFd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 09:05:33 -0500
Received: by mail-ea0-f177.google.com with SMTP id c10so7040279eaa.22
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 06:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=ZP5FSvVmVw5RYWeZXjABRM04utACcRAXoeJ3t/c2fsw=;
        b=rc0JDL0gpGoUojF0EjUu2fqWmCCqBkX5mgUrvJ2I2EDW0szyD/w2+Chun24A8n675Y
         Y73gZ5F4ZdtGdb5o4o+OvZxImX9gbqiCyZmwEhQWUiEVQ/aLuDxZvVb7Ft2bAwqKx7zz
         +cLm/MsYVm79Z2m+Y495HWdF0ZCKMyJDfGgwGYPyxS+4P4kKgFkuT4zYXCpu+NlEXQPl
         ZgJSKt3zGhVdf9Ttk/vVZlbV+8uWIY1fsVxMIcxIR3DJ3zAVib59e+dfgABX5pteyG1E
         RgAdiQ8R7tKZ9/hoGQ3M4y6OdZKrHF7eOrUxbxGwrCemJinoLAOTiyTtJSw1ZQEfdM0c
         YVgA==
Received: by 10.14.174.198 with SMTP id x46mr152249389eel.23.1357394731950;
 Sat, 05 Jan 2013 06:05:31 -0800 (PST)
Received: by 10.14.2.65 with HTTP; Sat, 5 Jan 2013 06:05:00 -0800 (PST)
In-Reply-To: <7vhamwse2c.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: YeaIdi33AtkWn3jfiY_0sBwil6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212692>

Hi Junio,

On 4 January 2013 23:50, Junio C Hamano <gitster@pobox.com> wrote:
> Anand Kumria <wildfire@progsoc.org> writes:
>
>> By selecting a tag within gitk you can display information about it.
>> This information is output by using the command
>>
>>  'git cat-file tag <tagid>'
>>
>> This outputs the *raw* information from the tag, amongst which is the
>> time - in seconds since the epoch. As useful as that value is, I find it
>> a lot easier to read and process time which it is something like:
>>
>>  "Mon Dec 31 14:26:11 2012 -0800"
>>
>> This change will modify the display of tags in gitk like so:
>>
>>   @@ -1,7 +1,7 @@
>>    object 5d417842efeafb6e109db7574196901c4e95d273
>>    type commit
>>    tag v1.8.1
>>   -tagger Junio C Hamano <gitster@pobox.com> 1356992771 -0800
>>   +tagger Junio C Hamano <gitster@pobox.com> Mon Dec 31 14:26:11 2012 -0800
>>
>>    Git 1.8.1
>>    -----BEGIN PGP SIGNATURE-----
>>
>> Signed-off-by: Anand Kumria <wildfire@progsoc.org>
>> ---
>
> Sounds like a sensible thing to do but I didn't check how else
> (other than purely for displaying) this string is used.

As far as I can tell it is only used for display (cached_tagcontent in
gitk) purposes.

> Paul, the patch is not made against your tree, so if you choose to
> take it you would need to strip the leading directory at the top.

Sorry, I didn't know that gitk had been split back out (and
Documentation/gitk.txt still mentions it is part of the git suite).

Regards,
Anand
