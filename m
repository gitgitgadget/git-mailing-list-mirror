Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2371F597
	for <e@80x24.org>; Fri,  3 Aug 2018 11:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbeHCNMa (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 09:12:30 -0400
Received: from mail-ua0-f173.google.com ([209.85.217.173]:34476 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbeHCNMa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 09:12:30 -0400
Received: by mail-ua0-f173.google.com with SMTP id r10-v6so3928592uao.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 04:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bsW/1MUvlHGsXLoGUdm7E7C3htw0LwSiwCK8C5NopEk=;
        b=u4cqVQLy8yJef+90jf9V02q48tzuLNvK7IuHE1vTNOE6n8KZ3gmxr1+sD1Jp/Yk78w
         5yPRXStz+s1223rJUlSM0aA//l8F0Aae10rl6JwaqcwVIC/9W7eMm1Xmkld5H+hRPjnZ
         ygYYEjj8DKiNH+z/PkQmX2tGwt9DFdesNWXEX+C2NvdcOOi8FOxRCekMAjftP1gBaOSe
         z+rBSnjX+LTrqVbzVP2e31m4jAEAYDMikltG9lhqlvfAVFfgrsANyEQ/PR0S1a5MODoo
         2u2X+BaLqa+JOOT9b/PDxD4Z51P1pDKQ9Yn3dYfTA3jqfBJi0JhLtXGxhD83PA2Y3GTV
         FWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bsW/1MUvlHGsXLoGUdm7E7C3htw0LwSiwCK8C5NopEk=;
        b=tBwZ8Jy/MhwfzBX7htn79G6cv4ThQQVkXHlPW10Ri4hWXUvw/PrZAtkWZlSrm17UH7
         lSP0hTZ7hbo/BffcWKfqV4A5Zy1FU2MqzeiSiT2n9xwgr/QwX60KMo2finR17K9JLO43
         RqxZaMfRoAvMIYnrmHvE8ahG85tHWLf+52rncH6Q4Q4xjudSb9PBctaQBCqzjGGaGjqi
         m4C+HoDi3/sLFdQn2Jf39CREsHI+/wtlf+g+LarhIUEJXZ8maQwfl+TM4AJlfy/eEdQA
         U4DDcxf5hT4IclbJNev3IrsSx929XvTYZa2HdVtjhJ2CBeuYRu4ybTwFhqOBESYW87Q8
         vNhA==
X-Gm-Message-State: AOUpUlHgD9Tzt/3ew5SGteRgvRELRq+5nXYQF/DFSCqnwBDv5pmOFU1v
        pw4rFxmDvVDQlFZd5SmjwVU+u5aZF1M0wq0mx4uHRf+Z
X-Google-Smtp-Source: AAOMgpeX7vBJ9QisHTSvfVlIzPnCmlTpsZAXrp4j+1MZedKNI6J3ihoQFjEPI+z2kUK6MGuVppQJMmQLTeP8UlpjlGw=
X-Received: by 2002:ab0:6a6:: with SMTP id g35-v6mr2467285uag.16.1533294997501;
 Fri, 03 Aug 2018 04:16:37 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Mosegaard Amdisen <martinmosegaard@gmail.com>
Date:   Fri, 3 Aug 2018 13:16:26 +0200
Message-ID: <CAAVPhBmg1=dhGPougT2fXPdA+ogenrS8T3YhbpwzTfurxcn+HA@mail.gmail.com>
Subject: Bug: git-describe abbrev documentation mentions wrong default
To:     git@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000a97de40572860f19"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000a97de40572860f19
Content-Type: text/plain; charset="UTF-8"

The documentation for the "git describe --abbrev" flag says that the
default value is 7 hexadecimal digits:
https://github.com/git/git/blob/master/Documentation/git-describe.txt#L63
and
https://git-scm.com/docs/git-describe

I have experienced that sometimes I see 7 digits, but other times more.
The behavior seems to have changed in git 2.11.0 ("default abbreviation
length"):
https://github.com/git/git/blob/aeddbfdfa48443c034a9b28b10dfddf2f71b907f/Documentation/RelNotes/2.11.0.txt

I was able to trigger different behavior using a bash script like the one
below:

```sh
#!/bin/bash

DIR=test-git-describe
rm -rf ${DIR}
mkdir ${DIR}
cd ${DIR}
git init

# One-time test results I have seen:
# 10 tags, 10 * 10 commits: 7 hex digits
# 100 tags, 100 * 100 commits: 8 hex digits
FILE=foo
touch ${FILE}
for i in `seq 1 10`; do
    echo ${i} >> ${FILE}
    git add ${FILE}
    git commit -m "Tag update number ${i} to ${FILE}"
    git tag -m "Version 1.0.${i}" -a 1.0.${i}
    for j in `seq 1 10`; do
        echo ${i}-${j} >> ${FILE}
        git add ${FILE}
        git commit -m "Update number ${i}-${j} to ${FILE}"
    done
done
```

--000000000000a97de40572860f19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The documentation for the &quot;git describe --abbrev=
&quot; flag says that the default value is 7 hexadecimal digits:</div><div>=
<a href=3D"https://github.com/git/git/blob/master/Documentation/git-describ=
e.txt#L63">https://github.com/git/git/blob/master/Documentation/git-describ=
e.txt#L63</a> and<br></div><div><a href=3D"https://git-scm.com/docs/git-des=
cribe">https://git-scm.com/docs/git-describe</a><br></div><div><br></div>I =
have experienced that sometimes I see 7 digits, but other times more.<div>T=
he behavior seems to have changed in git 2.11.0 (&quot;default abbreviation=
 length&quot;):</div><div><a href=3D"https://github.com/git/git/blob/aeddbf=
dfa48443c034a9b28b10dfddf2f71b907f/Documentation/RelNotes/2.11.0.txt">https=
://github.com/git/git/blob/aeddbfdfa48443c034a9b28b10dfddf2f71b907f/Documen=
tation/RelNotes/2.11.0.txt</a><br></div><div><br></div><div>I was able to t=
rigger different behavior using a bash script like the one below:<br></div>=
<div><br></div><div>```sh</div><div><div>#!/bin/bash</div><div><br></div><d=
iv>DIR=3Dtest-git-describe</div><div>rm -rf ${DIR}</div><div>mkdir ${DIR}</=
div><div>cd ${DIR}</div><div>git init</div><div><br></div><div># One-time t=
est results I have seen:</div><div># 10 tags, 10 * 10 commits: 7 hex digits=
</div><div># 100 tags, 100 * 100 commits: 8 hex digits</div><div>FILE=3Dfoo=
</div><div>touch ${FILE}</div><div>for i in `seq 1 10`; do</div><div>=C2=A0=
 =C2=A0 echo ${i} &gt;&gt; ${FILE}</div><div>=C2=A0 =C2=A0 git add ${FILE}<=
/div><div>=C2=A0 =C2=A0 git commit -m &quot;Tag update number ${i} to ${FIL=
E}&quot;</div><div>=C2=A0 =C2=A0 git tag -m &quot;Version 1.0.${i}&quot; -a=
 1.0.${i}</div><div>=C2=A0 =C2=A0 for j in `seq 1 10`; do</div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 echo ${i}-${j} &gt;&gt; ${FILE}</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 git add ${FILE}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 git=
 commit -m &quot;Update number ${i}-${j} to ${FILE}&quot;</div><div>=C2=A0 =
=C2=A0 done</div><div>done</div></div><div>```</div></div>

--000000000000a97de40572860f19--
