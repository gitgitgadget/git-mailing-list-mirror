From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Fri, 08 May 2015 20:21:55 +0200
Message-ID: <554CFEC3.5030105@gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com> <554B30D5.3050909@emmajane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
To: Emma Jane Hogbin Westby <emma.westby@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 20:22:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqmuR-00053W-Mt
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 20:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbbEHSV7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 14:21:59 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:32921 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbbEHSV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 14:21:58 -0400
Received: by wgin8 with SMTP id n8so79839038wgi.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EqirBrz4xfUmkPxQ96aKPdvN6fzilMkkWLdXCxgYK6c=;
        b=vNQskheBoTNIQdQDif36jMCCUlMya7VOMow2BTKZT/Kvz8KC1xeSK1ysiOx/jsnlgY
         b/pRqJoeq/XQkArDIeUWkcUvFegdvlzeD080rUTOhDNl2audtiMcOdKvcg2z4r+96hIm
         U+2GYpMtXCXXM7V7tNlE51slJ7JZEvrAVCoA0pcx8I72DgUSzmbgy4Rmioz8iu/sL44H
         MMP7oFCAu1UZ2vdpatO952p7/oZ981tMQi72c8NpjaotMoLIDUdiPvuEv+HmaSzorKPM
         Awxf+0IX7hjrKHzYxXHB/EEqBZXgoepazyo9OBvXJPKzTTxolwDVMRiLncb0UgLSt0/y
         a8rg==
X-Received: by 10.180.83.229 with SMTP id t5mr259975wiy.82.1431109317179;
        Fri, 08 May 2015 11:21:57 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id df1sm13449920wib.12.2015.05.08.11.21.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 11:21:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <554B30D5.3050909@emmajane.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268640>

On 05/07/2015 11:31 AM, Emma Jane Hogbin Westby wrote:
> S=C3=A9bastien !
>
> This is fantastic! My apologies for jumping in late. Hopefully
> I'm not too late.
>

Thank you :) It's just a very modest contribution though.

>
> S=C3=A9bastien Guimmara wrote:
>> This v4 includes the following suggestions:
>>
>> In command-list.txt:
>> - Add a [groups] block containing names and description for groups:
>>
>>     [groups]
>>     init                   starting a working area
>>     worktree               working on the current change
>>     remote                 working with others
>>     info                   examining the history and state
>>     history                growing, marking and tweaking your histor=
y
> I like these headings / separation.
>
> As you've already "lost" a line to the header, would it make sense to
> add a "see also" into the Guides from here? For example:
>
> starting a working area (see also: git help tutorial)
> working on the current change (see also: git help everyday)
> working with others (see also: git help workflows)
> examining the history and state (see also: git help revisions)
>

I think it's a good idea.

> [...]
>> This produces the following output of $ git help:
>>
>> [...]
>> The most commonly used git commands are:
>>
>>     * starting a working area:
>>        clone      Clone a repository into a new directory
>>        init       Create an empty Git repository or reinitialize [..=
=2E]
>>
>>     * working on the current change:
>>        add        Add file contents to the index
>>        reset      Reset current HEAD to the specified state
> I could not live without status at this stage, and status always tell=
s
> me what I should do next. I'm tempted to see it up here instead...

The layout was not designed to be workflow oriented (even if it appears
so), but rather theme oriented. But I think that a redesign that
introduces the typical Git workflow in a gentle, not intimidating manne=
r
could help beginners realize that Git is extremely simple in its core
principles.

>
>>     * working with others:
>>        fetch      Download objects and refs from another repository
>>        pull       Fetch from and integrate with another repository [=
=2E..]
>>        push       Update remote refs along with associated objects
>>
>>     * examining the history and state:
>>        log        Show commit logs
>>        status     Show the working tree status
> For this grouping, instead of also having "state", I'd like to see lo=
g
> and diff. Perhaps the header is simply "examining the history". This
> narrowing would make more sense to then move status up to "working on
> the current change".
>
>>     * growing, marking and tweaking your history:
>>        branch     List, create, or delete branches
>>        checkout   Checkout a branch or paths to the working tree
>>        commit     Record changes to the repository
>>        diff       Show changes between commits, commit and working [=
=2E..]
>>        merge      Join two or more development histories together
> By the definition of "tweaking" I would include rebase. Hiding rebase
> from the "common" list will increase its mystique and make people
> even more hesitant to use it. Best to shine some light on it and help
> to make it less scary. I would remove diff from this group as it is
> a non-destructive command.

In a workflow-oriented 'git help', I believe this would make sense.
The patch originally started by examining what is really a 'common'
command, and I estimated that 'rebase' was not that common. However,
since 'rebase' is such a powerful tool and a killer feature of git
(among others), we could mention it in a way that is less intimidating
(see above)

>
> What a wonderful thing to have started, S=C3=A9bastien ! Thank you. :=
)
>
Thank you again :)
