From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [Q] Import SVN tags into a local Git repository?
Date: Fri, 26 Feb 2016 11:31:33 +0100
Message-ID: <CA+icZUVi1a8XA=Dp2Vnt=vYmyseOMBNptgZzB-oekqB32+mAnw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 11:31:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZFgX-00071h-9N
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 11:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbcBZKbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 05:31:38 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35167 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbcBZKbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 05:31:34 -0500
Received: by mail-vk0-f49.google.com with SMTP id e6so73295888vkh.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 02:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to;
        bh=vjJQlB15Jmy8YlMpNamrD05cN6o624z8/PPxry1LL7k=;
        b=xUaz2P9J3UhV0zL3l/8vnXVdmXd6VQSOTO1cyMJLyYCKA0nhiJPyTymHngX4sR1yZd
         yTMrYNBeTxYOkBsqHKEUyh0bbbybV111eTPDWcfd88cffVmVXiLowlP5dLMt/bvpKs3b
         NIhPciKHUweH7A1f2BrdAmc6ea3rfNHfQLAqMdYGHx0kui5cZnuMh0MHOKz7yCHiEcz+
         WbtkfEtK7hZLTHNUU1vKn40+oBHohvqGu8nkrflo/pWJYmU8OF8PZvS+/em+C8wJDJjl
         352bHbcC52BTwUG0ep16E6eFyrjsxS8cht+r6wJPA1/a9xB+RmP0YMK2/SI+dPOQdQez
         ma7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:date:message-id:subject
         :from:to;
        bh=vjJQlB15Jmy8YlMpNamrD05cN6o624z8/PPxry1LL7k=;
        b=Nj5bsO5JnvzRM8X8Oz0sIVhNtSUYpvAoKwXCwdEItfK293YfRsYUpnnrXYRwJMi/9s
         KDYcgqrpv9eP+p6WKUqGj7Z3dXBTJmg92hePv0HeCnDvDuwOywz5e/NJpgpoI3uDbzGi
         XP7ky7yp8vbq1+gJkA1JbQmf/nzZd8bch37MDmmBfovCWJGCY4ldUeWg2k9JDQEgHxs1
         ZiHPpbqDiRxIcZUyqcU5Fwwk/TLUlmr+4yq1GvuOqPQm4Roa51xXeoNkVEl/jOKxt5pg
         4WrBJ+zW7i5IkzdEo1MARGx1zhSFr0mOyYkqgkJzX00BI7YoVR4zLETmrenjPmkQkFI6
         p4tg==
X-Gm-Message-State: AD7BkJI90f91Pk4sq28JbPNwLecq7grm6pKDVjPNcCulnPV0UGYXEAZHruHnrsBIu27czFCAH+5jTnwZcSgw+w==
X-Received: by 10.31.54.75 with SMTP id d72mr514274vka.30.1456482693509; Fri,
 26 Feb 2016 02:31:33 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Fri, 26 Feb 2016 02:31:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287563>

[ Please CC me as I am not subscribed to this ML ]

Hi,

I have here the problem that I build LLVM/Clang out of the official
LLVM Git repositories.

But version-tagging is done in the LLVM SVN repositories (see announce
in [0] "[3.8 Release] RC3 has been tagged").

The according Git repositories have "release_38" branches (see [1]..[3]).

For building LLVM/Clang v3.8.0rc2 I used official tarballs and for
v3.8.0rc3 I built from Git as there were no source-tarballs published
(maintainers wait for all prebuilt-toolchains to be done first).

I got two statements of responsible maintainers.
(Hans is the release-manager and Anton is the LLVM-Git-repo-maintainer).
Please, read yourself.

So, my question is...
Can I import "llvm/tags/RELEASE_380/rc3/" SVN-tag into my local Git
repository (see [6])?
If YES, how can I do that?

One side-effect is...
...that my generated clang binary shows a "final" release in the
version-string (see post-scriptum).

JUST FYI:
On my Ubuntu/precise AMD64 I have git v2.7.2 and svn v1.6.17 installed.

If you need more informations, please let me know.

Regards,
- Sedat -

[0] http://lists.llvm.org/pipermail/llvm-dev/2016-February/095756.html
[1] https://github.com/llvm-mirror/llvm/tree/release_38
[2] https://github.com/llvm-mirror/clang/tree/release_38
[3] https://github.com/llvm-mirror/compiler-rt/tree/release_38
[4] http://lists.llvm.org/pipermail/llvm-dev/2016-February/095780.html
[5] http://lists.llvm.org/pipermail/llvm-dev/2016-February/095798.html
[6] http://lists.llvm.org/pipermail/llvm-branch-commits/2016-February/009866.html
[7] http://llvm.org/pre-releases/3.8.0/rc2/

P.S.: Version mumbo-jumbo ("3.8.0rc3" built out of llvm.git#release_38
and "3.8.0rc2" from official tarballs).

[ 3.8.0rc3 ]

$ clang -v
clang version 3.8.0
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /opt/llvm/bin
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/4.6
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/4.6.4
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/4.9
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/4.9.2
Selected GCC installation: /usr/lib/gcc/x86_64-linux-gnu/4.9
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Selected multilib: .;@m64

[ 3.8.0rc2 ]

$ LC_ALL=C clang -v
clang version 3.8.0 (tags/RELEASE_380/rc2)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /opt/llvm/bin
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/4.6
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/4.6.4
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/4.9
Found candidate GCC installation: /usr/lib/gcc/x86_64-linux-gnu/4.9.2
Selected GCC installation: /usr/lib/gcc/x86_64-linux-gnu/4.9
Candidate multilib: .;@m64
Candidate multilib: 32;@m32
Selected multilib: .;@m64

- EOT -
