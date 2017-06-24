Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6900720401
	for <e@80x24.org>; Sat, 24 Jun 2017 22:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754923AbdFXWBn (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 18:01:43 -0400
Received: from mout.web.de ([212.227.17.11]:59024 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752238AbdFXWBn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 18:01:43 -0400
Received: from [192.168.209.79] ([195.198.252.176]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGAG3-1dahVL0Lah-00FGDG; Sun, 25
 Jun 2017 00:01:40 +0200
Subject: Re: EOL LF Windows auto.crlf issue
To:     Filip Kucharczyk <fil.kucharczyk@gmail.com>, git@vger.kernel.org
References: <CADtLFZcQNziGJx-aW9pvUU-NTHcbRN8pHXecMtRgaYwqTjGZWQ@mail.gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <9825c435-d752-79b5-f474-964f1ded8c54@web.de>
Date:   Sun, 25 Jun 2017 00:02:43 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CADtLFZcQNziGJx-aW9pvUU-NTHcbRN8pHXecMtRgaYwqTjGZWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:1akqk58Nbz21gDjS5523tcp+ORGTck1FdqUgU7aFX6nnH5rIxWP
 gIUBPLwoEQMrt1s2QYM2ibpt9/NHF5zmP7NY7RixeuALzBdbeT7o5oQ1Prbj4FmtQobl62Y
 TBzwz4oes5uR+tOXh7ckO0O8i0ZKLMMymse9Od/S4LFqTP9rGH3rF/UWp9xWkuV9rQZGFEm
 mxqsAhDec+FXZpDWmpS3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QxanmfPh6S0=:jqru5JPKTWIefi7EV7OAok
 1b5U4M3ira0N8zNUHYR5Pt3ApjrAA2tvbljgDKL6YwupDD77g+opIug6Lj8h/XX1FPx8Gy5mI
 Ur1z1JrYQlkdColQKGP0sY1Z4m4+AIChCBz3DjiH5UHQgst2e1FTQA5D/i+kgkvhMs1Kz50fR
 59DRPT3ujetrMJxHs+a3XxepuFAVVhjjnOAvx9lrEPyWTKSeWavq5v+d5R/aTXa8mossQ03St
 yebR1Z3k40w9PDKubpbk+FTbPspKd94TW8WuWwyDaoPqTj7FWLtV3iaG49+/FOJT9kIMOzlyQ
 3CuO9x2kl9IlM5l7FCEUHjFCYVyib7AvDPVMqUx7lRBve2Ktw1pieMemQroXhLG1HV7yhJ4wm
 7zrTHKTwpI6iCICRZIrOOeqO/bJyAbxc/9lE5E0wXu9N1otkc59MSK3m/8C4VL0dthbiAUYWw
 5oJbXkuSsrHXv9OkWRNFYZzv4BOL4muomHEncyA7rUb7vD96ijhNN3SsikvAr06oIL9fXRw9W
 U+TZy7qaFiTAki7MsTRrPt/2X5PGLNdPZ5I5iQhd4SpYFbHr43+i7ZPL8qyu22r3NgzJanjgH
 zVdLGKkw208sviiKD+W8J9D7Hsvstf5fWfJQDYZ/AMJTqpi9D99a5MBZ9wN1AcYwrRaJ8q7NY
 hI2WEgJ+VA7aZ2umxKc+45WK3Il1mfkkIWtuN++lU5OSU6+OJNV07jw+eC9rmy8vU2nP3pkTo
 eCcY3Wx0qq2N/THms9CgnemOZNcXmSbaxXNp9RkITcZGqszitbb+jUhap3NewP+uXdTFhyeLP
 8am0kCY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/06/17 18:56, Filip Kucharczyk wrote:
> I'm on Windows 10.
> auto.crlf in .gitconfig is set to
> [core]
> autocrlf = true
> I've got a git (git version 2.13.1.windows.2) repo.
> A linux guy emails me a text with with line endings LF.
> I paste this file into my repo.
> Now every time I introduce changes to this file and stage it, git tell me:
> "warning: LF will be replaced by CRLF in a.txt.

This conversion will happen if you do
rm a.txt
git checkout a.txt

After these 2 steps, the file willhave CRLF in the working tree,
see below.
But if you don't, the file stays as it is in the working tree.

> The file will have its original line endings in your working directory."

> But when I commit the file git does not replace anyline endings - they
> stay LF in the commited file and in my working direcotry.

Yes, core.autocrlf=true tells Git that they should have CRLF in the working 
tree, at least after a clean checkout.
> I'm sort of misleaded by this message.
Suggestions how to improve things are of course welcome -
for your case it may help to set
git config core.autocrlf input
for this very repo.

> 
> Filip
> 
