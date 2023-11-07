Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F23B2D05E
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbTGzvWd"
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE30DF
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 03:28:28 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso7355998e87.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 03:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699356506; x=1699961306; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/IYfP6FFei71QkbXE/2LPLDa2p1uSRi9Bzl3DFhvvS4=;
        b=hbTGzvWdkfS94m6zW5+E3GQHTUurJAFYvG2pE7TGGHddSz9jK4uHIfM/JLl6QWH9gi
         E5fLtJVa5bpJT2+wSUVmhM170jE9dm1xLI9ZjEA1jHsKv6iy07nKD3qQrYPv9C0sD6mD
         7+mB0r0Sqse0ovvk8vWbohpyqsXdKDgv1EnNBy/UsIa8xecfDOo0U660G31PGTN6UspG
         8Ik/uDkBDcYBMImMIDQkQosB0z1/1T8+fql6rwUyAcNcVvVq5WqeMwyuLIq+zte1wciV
         9Xsh1FzgFbtH8UQFUIUpqq6Yuo6CbdT8Khpc2iRGij3MI23zpxiFenLhZqXMhpAm/1rK
         Ks/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699356506; x=1699961306;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/IYfP6FFei71QkbXE/2LPLDa2p1uSRi9Bzl3DFhvvS4=;
        b=R1440FNf4XMvRtsHxpRZ1gygLv/Y3fpERJHLEK48XJRj37k58U2k3+lYBGEW/XPa1V
         emNgGlsedWbT4sc3/un9T4+MUty6NmjeuDZg1W8rvYSbS/cRoaUCG723d8JN6zryLUjT
         bYChrcZVQEfU0kOikOyimE1/zOckTONhWXURkLwBRdq/6s9IGiKBhQgJfFBctb7Zq+fm
         sG4M4Z6Ad9IFVz4ZfIcmFAOexHLLgFOLDtXs1xzKtVBv3tvdorqLNhPpxlnCfZaJkIed
         XXd4deRsR9N8J0OxuZwI/SV5OzXVMV6DE5+AOS7xscYst13Y+yogKbwF6BHBd/BvvDaE
         oShw==
X-Gm-Message-State: AOJu0YxTnt7mIwyylrlB5bfNGXvShQSiOHuqAfzFqyM61z/9qToBm8lF
	KESDICE6qI0i2o+oi5a9TnBunwFaFgYOMqDLMhwEMhhNNJQ=
X-Google-Smtp-Source: AGHT+IGOghN7Kt9Ds8DvwjAWYyOLVVTHtDJVlITbyZyNb6G36g00bUlRDrFb9Y4n7rGV5Ya819ZFyydxO7UGcAI28YU=
X-Received: by 2002:a05:6512:514:b0:509:471e:f111 with SMTP id
 o20-20020a056512051400b00509471ef111mr10741239lfb.57.1699356505893; Tue, 07
 Nov 2023 03:28:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: chengpu lee <okuxxo@gmail.com>
Date: Tue, 7 Nov 2023 19:28:14 +0800
Message-ID: <CAHv3AeCOoEXxpNh=gzjNcKbVyZFaYZ5BzSf3FGL1=pdheNebZw@mail.gmail.com>
Subject: issue unable to commit file and folder name to upper lower case
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e1b71306098e44da"

--000000000000e1b71306098e44da
Content-Type: multipart/alternative; boundary="000000000000e1b71006098e44d8"

--000000000000e1b71006098e44d8
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
$ mkdir abc

$ echo "">abc/.keep

$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        abc/

$ mv abc Abc

$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        Abc/                                                      # rename
to Abc/ successfully

$ git commit -m "commit Abc/"                                     # commit

$ mv Abc abc

$ git status
On branch master
nothing to commit, working tree clean                             # cannot
rename again

$ git diff
>""

$ git add .

$ git commit -m "Cannot rename from Abc/ to abc/"
On branch master
nothing to commit, working tree clean                             # cannot
commit to right, keep old file name / folder name


What did you expect to happen? (Expected behavior)
It should be correct to new name although just change upper/lower case,
because other commiter can pull it from repo or improve reading clarity.

What happened instead? (Actual behavior)
can commit file/folder but cannot fix upper/lower case.

What's different between what you expected and what actually happened?
git unable to faithfully represent file/folder upper/lower case changes.

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.40.0.windows.1
cpu: x86_64
built from commit: 1d90ca2906dd4b7ddaf0669a13c173ec579d794a
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19045
compiler info: gnuc: 12.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]

--000000000000e1b71006098e44d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for filling out a Git bug report!<br>Please answ=
er the following questions to help us understand your issue.<br><br>What di=
d you do before the bug happened? (Steps to reproduce your issue)<br>$ mkdi=
r abc<br><br>$ echo &quot;&quot;&gt;abc/.keep<br><br>$ git status<br>On bra=
nch master<br>Untracked files:<br>=C2=A0 (use &quot;git add &lt;file&gt;...=
&quot; to include in what will be committed)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 abc/<br><br>$ mv abc Abc<br><br>$ git status<br>On branch master<br>Untrac=
ked files:<br>=C2=A0 (use &quot;git add &lt;file&gt;...&quot; to include in=
 what will be committed)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Abc/ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0# rename to Abc/ successfully<br><br>$ git commi=
t -m &quot;commit Abc/&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # commit<br><br>$ mv Abc abc<br><br>$ git status<br>On branch master=
<br>nothing to commit, working tree clean =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # cannot=
 rename again<br><br>$ git diff<br>&gt;&quot;&quot;<br><br>$ git add .<br><=
br>$ git commit -m &quot;Cannot rename from Abc/ to abc/&quot;<br>On branch=
 master<br>nothing to commit, working tree clean =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #=
 cannot commit to right, keep old file name / folder name<br><br><br>What d=
id you expect to happen? (Expected behavior)<br>It should be correct to new=
 name although just change upper/lower case, because other commiter can pul=
l it from repo or improve reading clarity.<br><br>What happened instead? (A=
ctual behavior)<br>can commit file/folder but cannot fix upper/lower case.<=
br><br>What&#39;s different between what you expected and what actually hap=
pened?<br>git unable to faithfully represent file/folder upper/lower case c=
hanges.<br><br>Anything else you want to add:<br><br>Please review the rest=
 of the bug report below.<br>You can delete any lines you don&#39;t wish to=
 share.<br><br><br>[System Info]<br>git version:<br>git version 2.40.0.wind=
ows.1<br>cpu: x86_64<br>built from commit: 1d90ca2906dd4b7ddaf0669a13c173ec=
579d794a<br>sizeof-long: 4<br>sizeof-size_t: 8<br>shell-path: /bin/sh<br>fe=
ature: fsmonitor--daemon<br>uname: Windows 10.0 19045 <br>compiler info: gn=
uc: 12.2<br>libc info: no libc information available<br>$SHELL (typically, =
interactive shell): C:\Program Files\Git\usr\bin\bash.exe<br><br><br>[Enabl=
ed Hooks]<br></div>

--000000000000e1b71006098e44d8--
--000000000000e1b71306098e44da
Content-Type: text/plain; charset="US-ASCII"; name="git-bugreport-2023-11-07-1855.txt"
Content-Disposition: attachment; 
	filename="git-bugreport-2023-11-07-1855.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_loo8vbqf0>
X-Attachment-Id: f_loo8vbqf0

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQpQbGVhc2UgYW5zd2Vy
IHRoZSBmb2xsb3dpbmcgcXVlc3Rpb25zIHRvIGhlbHAgdXMgdW5kZXJzdGFuZCB5b3VyIGlzc3Vl
LgoKV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8gcmVw
cm9kdWNlIHlvdXIgaXNzdWUpCiQgbWtkaXIgYWJjCgokIGVjaG8gIiI+YWJjLy5rZWVwCgokIGdp
dCBzdGF0dXMKT24gYnJhbmNoIG1hc3RlcgpVbnRyYWNrZWQgZmlsZXM6CiAgKHVzZSAiZ2l0IGFk
ZCA8ZmlsZT4uLi4iIHRvIGluY2x1ZGUgaW4gd2hhdCB3aWxsIGJlIGNvbW1pdHRlZCkKICAgICAg
ICBhYmMvCgokIG12IGFiYyBBYmMKCiQgZ2l0IHN0YXR1cwpPbiBicmFuY2ggbWFzdGVyClVudHJh
Y2tlZCBmaWxlczoKICAodXNlICJnaXQgYWRkIDxmaWxlPi4uLiIgdG8gaW5jbHVkZSBpbiB3aGF0
IHdpbGwgYmUgY29tbWl0dGVkKQogICAgICAgIEFiYy8gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjIHJlbmFtZSB0byBBYmMvIHN1Y2Nlc3NmdWxs
eQoKJCBnaXQgY29tbWl0IC1tICJjb21taXQgQWJjLyIgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIyBjb21taXQKCiQgbXYgQWJjIGFiYwoKJCBnaXQgc3RhdHVzCk9uIGJyYW5j
aCBtYXN0ZXIKbm90aGluZyB0byBjb21taXQsIHdvcmtpbmcgdHJlZSBjbGVhbiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIyBjYW5ub3QgcmVuYW1lIGFnYWluCgokIGdpdCBkaWZmCj4iIgoK
JCBnaXQgYWRkIC4KCiQgZ2l0IGNvbW1pdCAtbSAiQ2Fubm90IHJlbmFtZSBmcm9tIEFiYy8gdG8g
YWJjLyIKT24gYnJhbmNoIG1hc3Rlcgpub3RoaW5nIHRvIGNvbW1pdCwgd29ya2luZyB0cmVlIGNs
ZWFuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjIGNhbm5vdCBjb21taXQgdG8gcmlnaHQs
IGtlZXAgb2xkIGZpbGUgbmFtZSAvIGZvbGRlciBuYW1lCgoKV2hhdCBkaWQgeW91IGV4cGVjdCB0
byBoYXBwZW4/IChFeHBlY3RlZCBiZWhhdmlvcikKSXQgc2hvdWxkIGJlIGNvcnJlY3QgdG8gbmV3
IG5hbWUgYWx0aG91Z2gganVzdCBjaGFuZ2UgdXBwZXIvbG93ZXIgY2FzZSwgYmVjYXVzZSBvdGhl
ciBjb21taXRlciBjYW4gcHVsbCBpdCBmcm9tIHJlcG8gb3IgaW1wcm92ZSByZWFkaW5nIGNsYXJp
dHkuCgpXaGF0IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpCmNhbiBjb21taXQg
ZmlsZS9mb2xkZXIgYnV0IGNhbm5vdCBmaXggdXBwZXIvbG93ZXIgY2FzZS4KCldoYXQncyBkaWZm
ZXJlbnQgYmV0d2VlbiB3aGF0IHlvdSBleHBlY3RlZCBhbmQgd2hhdCBhY3R1YWxseSBoYXBwZW5l
ZD8KZ2l0IHVuYWJsZSB0byBmYWl0aGZ1bGx5IHJlcHJlc2VudCBmaWxlL2ZvbGRlciB1cHBlci9s
b3dlciBjYXNlIGNoYW5nZXMuCgpBbnl0aGluZyBlbHNlIHlvdSB3YW50IHRvIGFkZDoKClBsZWFz
ZSByZXZpZXcgdGhlIHJlc3Qgb2YgdGhlIGJ1ZyByZXBvcnQgYmVsb3cuCllvdSBjYW4gZGVsZXRl
IGFueSBsaW5lcyB5b3UgZG9uJ3Qgd2lzaCB0byBzaGFyZS4KCgpbU3lzdGVtIEluZm9dCmdpdCB2
ZXJzaW9uOgpnaXQgdmVyc2lvbiAyLjQwLjAud2luZG93cy4xCmNwdTogeDg2XzY0CmJ1aWx0IGZy
b20gY29tbWl0OiAxZDkwY2EyOTA2ZGQ0YjdkZGFmMDY2OWExM2MxNzNlYzU3OWQ3OTRhCnNpemVv
Zi1sb25nOiA0CnNpemVvZi1zaXplX3Q6IDgKc2hlbGwtcGF0aDogL2Jpbi9zaApmZWF0dXJlOiBm
c21vbml0b3ItLWRhZW1vbgp1bmFtZTogV2luZG93cyAxMC4wIDE5MDQ1IApjb21waWxlciBpbmZv
OiBnbnVjOiAxMi4yCmxpYmMgaW5mbzogbm8gbGliYyBpbmZvcm1hdGlvbiBhdmFpbGFibGUKJFNI
RUxMICh0eXBpY2FsbHksIGludGVyYWN0aXZlIHNoZWxsKTogQzpcUHJvZ3JhbSBGaWxlc1xHaXRc
dXNyXGJpblxiYXNoLmV4ZQoKCltFbmFibGVkIEhvb2tzXQo=
--000000000000e1b71306098e44da--
