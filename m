From: Emma Jane Hogbin Westby <emma.westby@gmail.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Thu, 07 May 2015 10:31:01 +0100
Message-ID: <554B30D5.3050909@emmajane.net>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
To: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 11:31:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqI9T-0001d7-MI
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 11:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbbEGJb0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2015 05:31:26 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:35242 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbbEGJbX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 05:31:23 -0400
Received: by labbd9 with SMTP id bd9so26280854lab.2
        for <git@vger.kernel.org>; Thu, 07 May 2015 02:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:message-id:date:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=KqkPHthtKs7TbTtx09I/HRRW/91C71Gu3JAl7NSgc8s=;
        b=R9/9syFjhtjv6zGBANBpvQl+S6KbXyso2pMQyqdh1VCE7lzXvV0cp0pYMI2FQ/ZcC/
         mvS58YgQCaShYlofd/Q/JQLTKXMolZm7fYU8y6zN72IadS1FziyPFaIMSOomoK3fjgrD
         SjClug/MYv66YIMUvsGLb58msUxkiDrUaeLC2CoXFKBqYwACM+500eN2AhAqy1mw017A
         d3sqKveHOYJu9DDAJtn2CChzPK2m6Vy/nKQZZefRo11qm4VyRJiuTNLGS0+Q1vrtorBF
         hNS4ksDCg/53J1m3bi2uA+aT03ToPsNI/rBux5JWwOxyt8IMt9lvCdULFU+ZK/1v7iMW
         XsSw==
X-Received: by 10.112.220.34 with SMTP id pt2mr2313455lbc.81.1430991082142;
        Thu, 07 May 2015 02:31:22 -0700 (PDT)
Received: from falkor.local (94.197.121.44.threembb.co.uk. [94.197.121.44])
        by mx.google.com with ESMTPSA id h3sm320615laf.24.2015.05.07.02.31.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 May 2015 02:31:21 -0700 (PDT)
X-Google-Original-From: Emma Jane Hogbin Westby <emma@emmajane.net>
User-Agent: Postbox 3.0.11 (Macintosh/20140602)
In-Reply-To: <cover.1430770308.git.sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268525>

S=C3=A9bastien !

This is fantastic! My apologies for jumping in late. Hopefully I'm not=20
too late.


S=C3=A9bastien Guimmara wrote:
> This v4 includes the following suggestions:
>
> In command-list.txt:
> - Add a [groups] block containing names and description for groups:
>
>     [groups]
>     init                   starting a working area
>     worktree               working on the current change
>     remote                 working with others
>     info                   examining the history and state
>     history                growing, marking and tweaking your history
I like these headings / separation.

As you've already "lost" a line to the header, would it make sense to=20
add a "see also" into the Guides from here? For example:

starting a working area (see also: git help tutorial)
working on the current change (see also: git help everyday)
working with others (see also: git help workflows)
examining the history and state (see also: git help revisions)

[...]
> This produces the following output of $ git help:
>
> [...]
> The most commonly used git commands are:
>
>     * starting a working area:
>        clone      Clone a repository into a new directory
>        init       Create an empty Git repository or reinitialize [...=
]
>
>     * working on the current change:
>        add        Add file contents to the index
>        reset      Reset current HEAD to the specified state
I could not live without status at this stage, and status always tells=20
me what I should do next. I'm tempted to see it up here instead...

>     * working with others:
>        fetch      Download objects and refs from another repository
>        pull       Fetch from and integrate with another repository [.=
=2E.]
>        push       Update remote refs along with associated objects
>
>     * examining the history and state:
>        log        Show commit logs
>        status     Show the working tree status
=46or this grouping, instead of also having "state", I'd like to see lo=
g=20
and diff. Perhaps the header is simply "examining the history". This=20
narrowing would make more sense to then move status up to "working on=20
the current change".

>     * growing, marking and tweaking your history:
>        branch     List, create, or delete branches
>        checkout   Checkout a branch or paths to the working tree
>        commit     Record changes to the repository
>        diff       Show changes between commits, commit and working [.=
=2E.]
>        merge      Join two or more development histories together
By the definition of "tweaking" I would include rebase. Hiding rebase=20
from the "common" list will increase its mystique and make people even=20
more hesitant to use it. Best to shine some light on it and help to mak=
e=20
it less scary. I would remove diff from this group as it is a=20
non-destructive command.

What a wonderful thing to have started, S=C3=A9bastien ! Thank you. :)
