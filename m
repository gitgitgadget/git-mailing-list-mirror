Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CEBC83001
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D3F20709
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 03:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="kCtssuy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD3Dme (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:42:34 -0400
Received: from mout.web.de ([212.227.17.12]:36281 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgD3Dme (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 23:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588218151;
        bh=vzEihn25UNRiDLkWGSi5MSqqCUaL3IixlujSbPiq/oE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kCtssuy8CfEBmC4oIYSXs1v/j56p9fQLNI/yDqOquJea3akzb4K/UFtAP+e7kOM09
         ODwWbUwE0nsQ/Ub4jBnnfnTRrAudfCgebINE7VrqMfRlQzxp97H0RRvMdc2CTQpEK1
         XUnIqfl/XmYvQkQVhCL3OxSvoow0sNaRo95dLtAQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LecRm-1iowNF1iXO-00qQ1W; Thu, 30
 Apr 2020 05:42:31 +0200
Date:   Thu, 30 Apr 2020 05:42:31 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Doug Glidden <41mortimer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git fast-export not preserving executable permissions?
Message-ID: <20200430034230.smqu3ai5nx3ewbdq@tb-raspi4>
References: <CAHTRwmjXXYAU_LTBF_9sX1CXFnGyHsu5_KHuCp1rB76-4zn=Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHTRwmjXXYAU_LTBF_9sX1CXFnGyHsu5_KHuCp1rB76-4zn=Gg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:zsQdajutRpkPgofSi6Fwm757yWlkgnwxrCttKUI6xKLyS8phRLF
 4jruTELLQIr71SGGNR3/YCw/LN7vxZR+pboeaHfqoCnflkfPZP0BmthP/ACcy8bml99Orer
 33UzXtUYI+9O3Ws/iht/gYSwduha7G8vgMIPSDV9zKzWS7OKgqbUxZs9QxNWJRBN3hVQ+Nf
 fnmScBjabf9OO/uFwpZJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cNDsmo2Xipo=:JmFvAtn8ihIOAuIz4BZ/2n
 ztQg6wdNb1kXs3vQzTdW17/8JYmWL0x2RyO/3XB6a7MDUYh8jloNfmICyXNgB1N8ynUnHSapD
 rEr+oYROlLC8q8LYsJEpuaOEweq0eN+ffhd/N5cWEsbyEOAI3KQwNrGJOB5jJkiFyRb+xIjoB
 68ol9SP+1MA+QfX1SiiT89CrVSwexGEtlRS1XwAbbDF8r3td7DmM/T9BJD4G9Mb51DOvb5hPa
 MvRr0RWV8jacJ9qVOetDekXfC6MIm3MdQFcwh2Ji7z1lGbC4f/BCFUekPwE+gxgo6o8zTUreB
 /YVjt4rqD/kJrDQNCKOSuRAfniaiG6iY7DW/zbnbIDU0sGi8s5HXEXw9+QBZ5I/L9ifm2WgYE
 Fm6FWu1YR7fJ2YYG0OgEosMAa1RiavBhRqC3IcKCDnqM55nM45vosC/aATtDlyzlhhDAgBhj1
 2svrSt6IvIZBPYhfx4DDSizBqEsDjdSaXoxDa7t3HTHcVjTmJbenf8wCl9XXpfMmaXygMOTsw
 ggBfZDlGd68KM/iivvX524L+pDZGz3ENk7W55x0Eo0Ca+k8FmihmkI728sNGBKPF7oWDQGOsI
 Ouav00Ks47Bynur+A1HElFC61yIBt3pqOspBDwSinNkpRmwqfXs130L5Uwv3qGQpP9mmQntAp
 hjR4u7vJwLIjnKqJanoHWLGjZFb3i87eXf3OcCUt2QwkIn9MDj3J0HwPMk6lX0YORxyNNw7+1
 a50HiL5QBDhIDaumnlC7xVsC87AP/ExgRdMaCrB/93ZQa90x5DOcWLXwoqnhL2Y5ks8NlveXh
 zU/hZneZvX8ovOH2+UNv7DxC8jAl7f5LCxmBcy0N0uU9GeV0vmx6zdR2/+uOCW4M8NT4qmFHz
 eBbIY92q/j+C2jKlwnPQtghfL7qUQNE31850rBRZCxgJpCMRiBcdeRx5kCxSGNXKyAkMZMCC5
 pbCyJj6JMch8s9uK5ZUHMmSkbrl0smYhDbIvOmW2dhzwytCI1ky6CHwRUpeYmgXXjAXazbcBz
 ig2XgMUUKs1WtnNvPP8TOJb8slULu6aHqFOHW1k59suSjkoL2S7LflWt9jDNEx5NUGhjc1S6w
 N5PZDMq0lt3+Ey3KsQ5dEexMHofMzSaXVKZJUwvN7YGx806xwC1LbV387GRLAR1kG+CHJdE01
 y7DO2Jl8gdi1IziA3mcUEszadjHxg41LhCvG8qlA8ictQSiDS/BFVIRbO/V6LQ3KbyCqE4WF2
 JNRH8PZg5HqTUfWk5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 09:36:31AM -0400, Doug Glidden wrote:
> Hello Git world!
>
> I have run into an issue that I cannot seem to resolve with git
> fast-export. When running a fast-export on a repo that contains
> scripts with executable permissions (e.g. a gradlew script), the
> resulting export does not properly reflect the executable permissions
> on the script files.
>
> To illustrate this issue, I created a small sample repo, with one
> executable file and one non-executable file. From the output below,
> you can see that the mode in the output from fast-export is the same
> for both files; according to the documentation for fast-import, the
> mode for the executable file should be 100755 instead of 100644.
>
>     $ ls -gG
>     total 2
>     -rwxr-xr-x 1 106 Apr 29 09:13 executable_script.sh*
>     -rw-r--r-- 1  63 Apr 29 09:12 non_executable_file.txt

What does
git ls-files -s
give you here ?
We need to know, how Git tracks the files, is it
100644 or 100755 ?

The following works for me:

user@pc:/tmp/fff> git init
Initialized empty Git repository in /private/tmp/fff/.git/
user@pc:/tmp/fff> echo file1 >file1
user@pc:/tmp/fff> git config core.filemode false
user@pc:/tmp/fff> echo file2 >file2
user@pc:/tmp/fff> git add file1 file2
user@pc:/tmp/fff> git ls-files -s
100644 e2129701f1a4d54dc44f03c93bca0a2aec7c5449 0       file1
100644 6c493ff740f9380390d5c9ddef4af18697ac9375 0       file2
user@pc:/tmp/fff> git update-index --chmod=3D+x file2
user@pc:/tmp/fff> git ls-files -s
100644 e2129701f1a4d54dc44f03c93bca0a2aec7c5449 0       file1
100755 6c493ff740f9380390d5c9ddef4af18697ac9375 0       file2
user@pc:/tmp/fff> git commit -m "Add file1 file2"
[master (root-commit) f75926e] Add file1 file2
 2 files changed, 2 insertions(+)
  create mode 100644 file1
  create mode 100755 file2

user@pc:/tmp/fff> git fast-export --all
blob
mark :1
data 6
file1

blob
mark :2
data 6
file2

reset refs/heads/master
commit refs/heads/master
mark :3
author Torsten B=F6gershausen <tboegi@web.de> 1588217922 +0200
committer Torsten B=F6gershausen <tboegi@web.de> 1588217922 +0200
data 16
Add file1 file2
M 100644 :1 file1
M 100755 :2 file2

