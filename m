Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6CE20A40
	for <e@80x24.org>; Sat, 25 Nov 2017 09:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbdKYJbQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 04:31:16 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:46981 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdKYJbP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 04:31:15 -0500
Received: by mail-ot0-f174.google.com with SMTP id j29so20494812oth.13
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cCLu9b/z3hiDhSNMO9g6q4xoCLksi5U6mSoEOkjrkG0=;
        b=PnNPA/DVZrugPsdKZXvG2UZghabeHpIRxuR3IYAWB6JFq4wsmuWu60uPiHeAp5jW6v
         xd07H7OOgvNlI4QLRteu6cla+yw1Ov+w+1bN4iwMaR3kbyYbj0gTZYL59ybeJUM+nneP
         9TURTtx8iRqOXoliDz2nNoaKY7IiMJhLOkneewfX0zvlxls2x4EuAWRGyLgvyVNHczLb
         SPNXQWDqpAKFFj69UIgIyw6eDVNmMkws9vbTJZbjdzWD0usw140umoX4zUbBCXiR0crD
         AyJFQUxXPR+wBwsrr7EH50WRhwgGC979fJtX3KRsZSlOvtQWZCDdQS6aSCSyZ3MhjWWu
         WUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cCLu9b/z3hiDhSNMO9g6q4xoCLksi5U6mSoEOkjrkG0=;
        b=IX5BdQjZRpsYLyKW6K3AjRF1ZZ27oZ0g72tSCHO+HGEe8q+7UaQieCBwiB+2sWPEC2
         8hDzzyj9AYLzhgVMRYWq8TN/vz1DN3TuA5P4ZpRzONWltxyYd0hPVgYD7jpxkRn6dDyB
         61Tiw6gqNE6icaYVdcYOEiUIxr4A0Y8Q+AZK3z/iUgr2q/bOanG6aZYGoZzIufekaGtw
         2lwF4BRLVryfXOmh9OfZvewt9I0U6aS+qFcoFkWSqz3TVw0T3Pouj7jE7vODVMD82gsS
         zwwjQHCwulrWBGxOkRcdcwzUG8DBHYfNbNcutwh/TlKGRn8z9a7n8BXMxOnXuJ4T6K3C
         YPFg==
X-Gm-Message-State: AJaThX4KUR+N7RzE7zEgaAbngkzjscxP6EvU7v69iuMTcqnIftLqS9jK
        Cur2wYXqRcmobEe6zXxSH5nhSiVvOYJXOEaxwfNbCQ==
X-Google-Smtp-Source: AGs4zMZRljtxpIS9fq/xbxRDBwdcmhOvjjbZMed5czOtOU6+Colh4NQ6V1JXBSjCw8N4196DdrcJPC9CyZugOGvtTYA=
X-Received: by 10.157.85.194 with SMTP id z2mr20569546oti.74.1511602274842;
 Sat, 25 Nov 2017 01:31:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.108.78 with HTTP; Sat, 25 Nov 2017 01:31:14 -0800 (PST)
From:   Roberto Garcia <eltitorober1985@gmail.com>
Date:   Sat, 25 Nov 2017 10:31:14 +0100
Message-ID: <CAOeKBwpUDD_C5mQ54Aa2pj72aVkp9F2rkmGrSVMC81d6gJQRew@mail.gmail.com>
Subject: Clone repository computer A to remote B doenst work
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I'm trying clone in windows a git repository to other remote machine
(NAS Linux based).
I have installed git for windows but i didn't installed nothing in the
other remote machine (NAS Linux based).

I open git-bash and I try do this: "git clone
user@IP:/directory/where/i/want/clone".
This doesnt work because I obtain "sh: git-upload-pack: command not found".

I search in google and I found a possible solution, I need add -u
/path/to/git-upload-pack.
When i try again writing git clone -u
/c/Git/mingw64/bin/git-upload-pack
user@IP:/directory/where/i/want/clone
After I Write the password I obtain sh:
C:/Git/mingw64/bin/git-upload-pack: No such file or directory. But it
exists! (in my local computer windows)

I'm newbie with Git and Unix system. What can i do ?
Thanks a lot!
