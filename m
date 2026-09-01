Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19269351C27
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299711; cv=none; b=FdZnBylimFDyHSJX1Fb7foF+fXCatoGhzgvgddcizL4ukI78NG0E7VBrdSwtKMvpxJtF+cnL4dfpo+Vc+7ZHJj2h0ubN9kIY3nWMmp2bUY/tXfJnP0WlyTGMaZl07lzezQjo+9b0J22JTqI5XCqgPUQ6Q08hv+KY22SqKc3Z5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299711; c=relaxed/simple;
	bh=b6pWsla4JPa0X5H3sxdbQDXsbFAAUDGARLoPoCbsp/Q=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=dMPsFEwAwkKXqPFhH+qFeanXoKVYyQvp6/qvxgiiN4H2Or6ZQjIc0ZCa0kbZp1AgnkAbpAY0WV/FZK/kuwMEdPqCCdr+Psc7lJuzJyo3I5Ld1hGq2mUBoR0/SUV+1iNj1Nos1wJNqbLyfoOelhS1SJ67uMTbSGsy1i5I1JeNXqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-255-187-253.cpe.net.cable.rogers.com [99.255.187.253])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 681Lji01024735
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Sep 2026 21:45:45 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Skybuck Flying'" <skybuck2000@hotmail.com>,
        "'Git'" <git@vger.kernel.org>
References: <AM0PR02MB445096594555DAD1D9EE1505B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com> <AM0PR02MB445083767BAE669D4656CA6CB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com> <AM0PR02MB445013B3CDAAAD361FD93A86B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com> <AM0PR02MB44501AFB0A97E2E097B8795AB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com> <AM0PR02MB445092119D0BA1921E2BAADFB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com> <AM0PR02MB4450EF826479360A3A262277B3A82@AM0PR02MB4450.eurprd02.prod.outlook.com>
In-Reply-To: <AM0PR02MB4450EF826479360A3A262277B3A82@AM0PR02MB4450.eurprd02.prod.outlook.com>
Subject: RE: AI Textconv filter misconfiguration on Windows leads to silent corruption of diff output (ongoing investigation)
Date: Tue, 1 Sep 2026 17:45:38 -0400
Organization: Nexbridge Inc.
Message-ID: <000601dd3a5b$3e4be8a0$bae3b9e0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG/A74nuxZ9S0nr6fdPAV8IovWWEQKY/cdqAdcK/JwB4Zs92AGG/tONAULMUxa2rc9REA==
Content-Language: en-ca
msip_labels: 
X-Antivirus: Norton (VPS 260901-8, 9/1/2026), Outbound message
X-Antivirus-Status: Clean

On September 1, 2026 4:14 PM, Skybuck Flying wrote:
>MORE GOD DAMN PROBLEMS WITH GIT AND CR/LF FILTERS.
>
>I DOWNLOADED/GIT CLONED:
>
>https://github.com/openai/openai-openapi/tree/main
>
>I NOTICED:
>
>https://github.com/openai/openai-openapi/tree/main/assets
>
>WAS CORRUPTED.
>
>(CORRECT DOWNLOAD METHOD USES TO PROVE FILE IS INTACT ON SERVER):
>
>curl -L --output "K:\Delphi\Specifications\OpenAI API\github version =
3.1.0 (1
>september 2026)\assets\openai-api-referencev2.png"
>https://raw.githubusercontent.com/openai/openai-
>openapi/master/assets/openai-api-reference.png
>
>GOOD THING I INSPECTED IT JUST OUT OF CURIOSITY.
>
>I IMMEDIATELY EXPECTED GIT FILTER TO BE THE CAUSE.
>
>DIAGNOSIS COMMANDS.
>
>"
>Microsoft Windows [Version 10.0.22631.6199]
>(c) Microsoft Corporation. All rights reserved.
>
>C:\Users\skybu>git config --global core.autocrlf false
>
>C:\Users\skybu>git config --system core.autocrlf false
>
>C:\Users\skybu>git config --local core.autocrlf
>fatal: --local can only be used inside a git repository
>
>C:\Users\skybu>git config --global --get-regexp filter
>
>C:\Users\skybu>git config --local --get-regexp filter
>fatal: --local can only be used inside a git repository
>
>C:\Users\skybu>git check-attr -a openai-api-reference.png
>fatal: not a git repository (or any of the parent directories): .git
>
>C:\Users\skybu>type .gitattributes
>* text diff=3Dlfclean
>C:\Users\skybu>git config --global --list core.autocrlf=3Dfalse =
core.eol=3Dcrlf
>core.sshcommand=3DC:/Windows/System32/OpenSSH/ssh.exe
>core.attributesfile=3DC:\Users\skybu\.gitattributes
>user.email=3Dskybuck2000@hotmail.com
>user.name=3DSkybuck Flying
>user.signingkey=3DI:\Informatie\Van mezelf\SSH =
Keys\PrivateKey\GitSigningKey
>gui.recentrepo=3DV:/FuckingWhore/vite-wallet
>cinnabar.version-check=3D1743733941
>credential.http://localhost:3000.provider=3Dgeneric
>includeif.gitdir:V:/AI0001/.path=3D~/.gitconfigs/.gitconfig-ai0001-v2
>includeif.gitdir:V:/AI0002/.path=3D~/.gitconfigs/.gitconfig-ai0002-v2
>includeif.gitdir:V:/AI0003/.path=3D~/.gitconfigs/.gitconfig-ai0003-v2
>includeif.gitdir:V:/AI0004/.path=3D~/.gitconfigs/.gitconfig-ai0004-v2
>includeif.gitdir:V:/AI0005/.path=3D~/.gitconfigs/.gitconfig-ai0005-v2
>includeif.gitdir:V:/AI0006/.path=3D~/.gitconfigs/.gitconfig-ai0006-v2
>includeif.gitdir:V:/AI0007/.path=3D~/.gitconfigs/.gitconfig-ai0007-v2
>includeif.gitdir:V:/AI0008/.path=3D~/.gitconfigs/.gitconfig-ai0008-v2
>includeif.gitdir:V:/AI0009/.path=3D~/.gitconfigs/.gitconfig-ai0009-v2
>includeif.gitdir:V:/AI0010/.path=3D~/.gitconfigs/.gitconfig-ai0010-v2
>includeif.gitdir:V:/AI0011/.path=3D~/.gitconfigs/.gitconfig-ai0011-v2
>includeif.gitdir:V:/AI0012/.path=3D~/.gitconfigs/.gitconfig-ai0012-v2
>includeif.gitdir:V:/AI0013/.path=3D~/.gitconfigs/.gitconfig-ai0013-v2
>includeif.gitdir:V:/AI0014/.path=3D~/.gitconfigs/.gitconfig-ai0014-v2
>includeif.gitdir:V:/AI0015/.path=3D~/.gitconfigs/.gitconfig-ai0015-v2
>includeif.gitdir:V:/AI0016/.path=3D~/.gitconfigs/.gitconfig-ai0016-v2
>includeif.gitdir:V:/AI0017/.path=3D~/.gitconfigs/.gitconfig-ai0017-v2
>includeif.gitdir:V:/AI0018/.path=3D~/.gitconfigs/.gitconfig-ai0018-v2
>includeif.gitdir:V:/AI0019/.path=3D~/.gitconfigs/.gitconfig-ai0019-v2
>includeif.gitdir:V:/AI0020/.path=3D~/.gitconfigs/.gitconfig-ai0020-v2
>includeif.gitdir:V:/AIMain/.path=3D~/.gitconfigs/.gitconfig-aimain-v2
>merge.tool=3Dmeld
>mergetool.prompt=3Dfalse
>mergetool.keepbackup=3Dfalse
>gpg.format=3Dssh
>commit.gpgsign=3Dtrue
>log.showsignature=3Dtrue
>gpg.ssh.allowedsignersfile=3DI:/Informatie/Van mezelf/SSH
>Keys/GitAllowedSigners/GitAllowedSigners.txt
>diff.lfclean.textconv=3Dsed -e s/\\r//
>diff.lfclean.binary=3Dfalse
>
>C:\Users\skybu>git check-attr --all -- openai-api-reference.png
>fatal: not a git repository (or any of the parent directories): .git
>
>C:\Users\skybu>
>"
>
>HYPOTHESIS BY CO-PILOT AND POSSIBLE FIX:
>
>The **smoking gun is now visible**: your global config + your global =
attributes file
>**are applying a custom diff filter (`lfclean`) to *all files*** =
=E2=80=94 including PNGs.
>That is exactly why your Git=E2=80=91downloaded PNG is corrupted while =
the curl version is
>intact.
>
>Let me break it down cleanly and give you the exact commands to verify =
every part.
>
>---
>
>## =F0=9F=8E=AF Core finding: your global `.gitattributes` is rewriting =
files You showed:
>
>```
>C:\Users\skybu>type .gitattributes
>* text diff=3Dlfclean
>```
>
>This means:
>
>- `*` =E2=86=92 **every file**, regardless of type
>- `text` =E2=86=92 Git treats **every file as text**, even binaries
>- `diff=3Dlfclean` =E2=86=92 Git applies your custom diff driver
>- Your diff driver is defined as:
>
>```
>diff.lfclean.textconv=3Dsed -e s/\\r//
>diff.lfclean.binary=3Dfalse
>```
>
>This forces Git to:
>
>- run `sed -e s/\r//` on files
>- treat them as **non=E2=80=91binary**
>- strip carriage returns
>- potentially corrupt binary formats (PNG, JPG, ZIP, EXE, DLL, etc.)
>
>Curl does not run Git filters =E2=86=92 curl file stays intact.
>
>Git does run filters =E2=86=92 Git file becomes corrupted.
>
>This is 100% the cause.
>
>---
>
>## =F0=9F=A7=AA Commands to confirm the corruption mechanism
>
>### 1. Check what attributes Git applies to your PNG ``` git check-attr =
--all -- openai-
>api-reference.png ```
>
>Expected output (because of your global `.gitattributes`):
>
>```
>openai-api-reference.png: text: set
>openai-api-reference.png: diff: lfclean
>```
>
>If you see this =E2=86=92 confirmed.
>
>---
>
>### 2. Check the raw blob stored in Git (to see if corruption happens =
on checkout)
>``` git show HEAD:openai-api-reference.png > raw.png ```
>
>Then compare:
>
>```
>fc /b raw.png openai-api-reference.png
>```
>
>If `raw.png` is intact but the working=E2=80=91tree file is corrupted =
=E2=86=92 the corruption
>happens during checkout due to filters.
>
>---
>
>### 3. Show all filters Git knows about
>```
>git config --show-origin --get-regexp diff git config --show-origin =
--get-regexp filter
>```
>
>You will see your `lfclean` diff driver.
>
>---
>
>### 4. Show your global attributes file path ``` git config --global =
core.attributesfile
>```
>
>It points to:
>
>```
>C:\Users\skybu\.gitattributes
>```
>
>This file is applied to **every repository** on your system.
>
>---
>
>## =F0=9F=9B=A0=EF=B8=8F How to fix it (choose one)
>
>### Option A =E2=80=94 Remove the global `.gitattributes` (recommended) =
``` del
>C:\Users\skybu\.gitattributes ```
>
>### Option B =E2=80=94 Restrict the rule to text files only
>Replace:
>
>```
>* text diff=3Dlfclean
>```
>
>With:
>
>```
>*.txt text diff=3Dlfclean
>*.pas text diff=3Dlfclean
>*.dpr text diff=3Dlfclean
>```
>
>### Option C =E2=80=94 Mark binary files correctly
>Add:
>
>```
>*.png binary
>*.jpg binary
>*.zip binary
>*.exe binary
>*.dll binary
>```
>
>---
>
>## =F0=9F=93=8C Why this happened
>You created a global `.gitattributes` with:
>
>```
>* text diff=3Dlfclean
>```
>
>This is extremely dangerous because:
>
>- Git thinks **every file is text**
>- Git applies your custom diff filter to **every file**
>- Binary files get corrupted on checkout
>
>This is why:
>
>- **curl file =3D correct**
>- **git file =3D corrupted**
>
>---
>
>## =F0=9F=94=8D Want me to help rewrite your `.gitattributes` safely?
>I can generate a clean, safe version tailored to your Delphi workflow.
>Pick one:
>
>- fix global attributes
>- create safe Delphi attributes
>- audit all Git filters
>
>
>
>Apperently Co-Pilot now has the ability to send e-mails, funny =
functionality, risky
>too ! Expect another melissa ai virus soon ? ;)
>
>Anyway I copy & paste it's reply here in plain text:
>
>```
>Hi Git developers,
>
>I'm writing to report a reproducible corruption issue caused by global =
Git attributes
>and diff filters being applied to binary files during checkout.
>
>Summary of the problem
>A PNG file downloaded via Git becomes corrupted, while the same file =
downloaded
>via curl remains intact. The corruption is caused by a global =
`.gitattributes` file that
>marks all files as text and assigns a custom diff driver:
>
>* text diff=3Dlfclean
>
>The diff driver is defined globally as:
>
>diff.lfclean.textconv=3Dsed -e s/\\r//
>diff.lfclean.binary=3Dfalse
>
>This forces Git to treat every file as text and run a textconv filter =
that strips carriage
>returns. When applied to binary formats (PNG, JPG, ZIP, EXE, etc.), the =
checkout
>process produces corrupted files.
>
>Reproduction steps
>1. Create a global `.gitattributes` file containing:
>   * text diff=3Dlfclean
>2. Define the diff driver globally:
>   diff.lfclean.textconv=3Dsed -e s/\\r//
>   diff.lfclean.binary=3Dfalse
>3. Clone any repository containing binary files.
>4. Compare a binary file from the working tree with the raw blob:
>   git show HEAD:path/to/file > raw.bin
>   fc /b raw.bin path/to/file
>
>The working-tree file differs from the blob, confirming corruption =
during checkout.
>
>Expected behavior
>Binary files should remain untouched unless explicitly marked with =
filters.
>
>Actual behavior
>Git applies the global attributes and diff driver to all files, =
including binaries, causing
>corruption.
>
>Request
>I would appreciate guidance on whether Git should:
>- Warn users when global attributes force text filters onto binary =
files, or
>- Provide safeguards to prevent textconv filters from being applied to =
known binary
>formats.
>
>Thanks for your time and consideration.
>
>Best regards,
>Skybuck
>```
>
>version 2:
>
>Here is the **clean, corrected, plain=E2=80=91text reply**, in a =
**single code block**, clearly
>explaining:
>
>- the **cause**
>- the **solution**
>- the **future risks**
>
>You can paste this directly into the Git mailing list.
>
>```
>Hi Git developers,
>
>I want to report an issue where Git corrupts binary files during =
checkout when a
>global .gitattributes file forces all paths to be treated as text and =
assigns a diff driver.
>
>Cause of the problem
>My global attributes file contained the line:
>
>    * text diff=3Dlfclean
>
>Because the pattern "*" matches every file, Git applies "text" and =
"diff=3Dlfclean" to all
>paths, including binary files such as PNGs. The "text" attribute forces =
Git to treat the
>file as text even when its content is clearly binary. The assigned diff =
driver runs a
>textconv filter:
>
>    diff.lfclean.textconv =3D sed -e s/\r//
>    diff.lfclean.binary =3D false
>
>This causes Git to rewrite the file during checkout, stripping carriage =
returns from
>binary data. As a result, the working-tree version of a PNG differs =
from the blob
>stored in the repository, and the file becomes corrupted. A copy =
downloaded via
>curl remains intact because curl does not apply Git filters.
>
>Reproduction steps
>1. Create a global .gitattributes file containing:
>       * text diff=3Dlfclean
>2. Define the diff driver globally:
>       diff.lfclean.textconv=3Dsed -e s/\r//
>       diff.lfclean.binary=3Dfalse
>3. Clone any repository containing binary files.
>4. Compare the blob with the working-tree file:
>       git show HEAD:path/to/file > raw.bin
>       fc /b raw.bin path/to/file
>
>The working-tree file is corrupted while the blob is correct.
>
>Solution
>Remove the global rule or restrict it to actual text file extensions. =
For example:
>
>    *.txt text diff=3Dlfclean
>    *.pas text diff=3Dlfclean
>    *.md  text diff=3Dlfclean
>
>Alternatively, explicitly mark binary formats:
>
>    *.png binary
>    *.jpg binary
>    *.zip binary
>    *.exe binary
>
>Deleting the global .gitattributes file entirely also resolves the =
issue.
>
>Future risks
>Global attribute rules are applied to every repository on the system. =
Using "*" with
>"text" or any filter can silently rewrite binary files, break archives, =
corrupt
>executables, and cause difficult-to-diagnose data loss. Users may not =
realize that Git
>is modifying files during checkout, especially when the corruption is =
subtle. A
>warning or safeguard when "text" is forced globally might help prevent =
accidental
>misuse.
>
>Thanks for your time and consideration.

Just some musings from my own frustration in this area.

Having gone through some similar things, I would ignore CoPilot. There =
are other words I would use as well but they are not for polite company.

Set autocrlf=3Dinput not false. Also it is a good idea to set =
ignorecase=3Dtrue and filemode=3Dfalse on Windows.

Git tends to give preferential treatment to text files, only looking at =
the first hunk (whatever that might be) looking for non-text characters. =
CR is text, so a file containing those near the front will probably be =
consider text unless explicitly marked as binary. If you are sure you =
have binary files, declare them. Do not assume git will always get it =
right - although .EXE, .ZIP, .JPG, and .PNG are pretty much always =
binary.

I am going to assume something there, that the clean/smudge and diff =
engines are not guaranteed to be subject to autocrlf processing before =
receiving the files. It might be or might not be, depending on what git =
feels like doing given the state of the file. You would have to go look =
in the code on the version you have to be certain, but don't count on it =
in future.

The other problem you may to face, and I have been there, is that =
clean/smudge and textconv filters definitely *do not like* binary files =
if not declared as binary, and sometimes even then. You are dealing with =
stdin and stdout, so have to know how the filter/textconv is opening the =
files. I have seen platforms that always open in "r" instead of "rb", =
which was a problem. I had to hack around that using %f in textconv. I =
have also seen people write textconv programs without awareness that =
they might get binary data, and that blows up runtimes badly when you =
hit a NUL in an input buffer after an fgets() in C.

I wish you luck in your adventure.
Randall

