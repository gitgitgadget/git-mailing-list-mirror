From: Stefan Beller <sbeller@google.com>
Subject: Re: test suite failure t5570, 8 with v2.4.1-168-g1ea28e1
Date: Tue, 19 May 2015 10:24:21 -0700
Message-ID: <CAGZ79kbV8noD6v8mdc7vM4cONV_cvuLLt_ay14YSoFjQ3v4N0w@mail.gmail.com>
References: <CAGZ79kY61ZJHHG4jj2hZSzXZ58fh9R9b8hOijaCTGxTu8dtN=w@mail.gmail.com>
	<20150519172254.GA27174@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 19 19:24:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YulFj-0004wA-5k
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 19:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbbESRYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 13:24:23 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34042 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbESRYW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 13:24:22 -0400
Received: by ieczm2 with SMTP id zm2so19351957iec.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BiXCyAQco9224iPHlTklEJFBZwoLTFHLgCYuyxiMJ1s=;
        b=AlLyElW19YgpiSUo/UqfjmeX5APPVudlkQFfBmpsUWAPPNnWWPTOP+EXnM7On37yZa
         t5Qz5fRZDI0hRfkPo9lvCXmj53emNFYYGQiDgbXTjCOR7H3Etil9xkzZYDCySBVljNbH
         YABhazfbAWESEgNGRjxrAtftX/s5eQCjNFpWDXlftZ/psqRy3acJ+TKL5A6d9SdaBW+H
         I0YwhU9NuR7e26wji6tJA6DkF8TD7d8fV0VK/w77Un97EY4OMEjD+JqwveMNB5sxMtAk
         vqJhrWFKea8HslCUME2YV+r8p6lVwRjLCaF1HmuBiTLHf/TBTrSI4AwV6hk61LW6s4ma
         Orog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=BiXCyAQco9224iPHlTklEJFBZwoLTFHLgCYuyxiMJ1s=;
        b=Vm1dEulRIPAFAmlymz4qzPHoJblEVayI0Ayq5RmD/91ubq8WLchWMtU5t5UFw/E7zR
         aBvozqQ1OOknaBiiJF+nGjh9TamQLs4eGuS4kB5HH/2wKap67OKKyqlE27WTUyJSOcaV
         8SIXNCmSJz/UgGNit+LpQa8J0Ro3AUF6KlZNrBjbG+t/qZxKLt4daJZjjItatFGE+yul
         7pp1pc/JdVveUfweG1PYFa02r0dnETqr/7dA377vY8gGXoFy7zcVbnSYhKO8b6yJuL7g
         viHfqbrfpLT9G9Cfo5V0lUP+tmS/17wcTv1ENtDtXkoKZ03tP3fG6GMkaN4C6aUhEjjr
         A3Xw==
X-Gm-Message-State: ALoCoQnuJip9RtCslCrBCdmH6drVV7Ui4QuE8+BAs8hcICwdCYZxx+dVmz8nKgnP2Y+m2TCSQh4m
X-Received: by 10.107.170.222 with SMTP id g91mr38791612ioj.2.1432056261475;
 Tue, 19 May 2015 10:24:21 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Tue, 19 May 2015 10:24:21 -0700 (PDT)
In-Reply-To: <20150519172254.GA27174@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269377>

On Tue, May 19, 2015 at 10:22 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 19, 2015 at 10:20:04AM -0700, Stefan Beller wrote:
>
>> so today I am running make test (no special flags I am aware of) on my
>> ubuntu machine using
>> git v2.4.1-168-g1ea28e1 and t5570-git-daemon.sh (not ok 8 - fetch
>> notices corrupt idx) fails.
>>
>> Any hints?
>
> It works for me. :)
>
> Is the problem reproducible, or intermittent? The daemon-oriented tests
> sometimes can suffer from weird races.
>
> If it is reproducible, what does running it with "-v -i" (and maybe
> "-x") say?

-x also keeps it failing

expecting success:
cp -R "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git
"$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
(cd "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
p=`ls objects/pack/pack-*.idx` &&
chmod u+w $p &&
printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
) &&
mkdir repo_bad2.git &&
(cd repo_bad2.git &&
git --bare init &&
test_must_fail git --bare fetch "$GIT_DAEMON_URL/repo_bad2.git" &&
test 0 = `ls objects/pack | wc -l`
)

++ cp -R '/usr/local/google/home/sbeller/OSS/git/t/trash
directory.t5570-git-daemon/repo/repo_pack.git'
'/usr/local/google/home/sbeller/OSS/git/t/trash
directory.t5570-git-daemon/repo/repo_bad2.git'
++ cd '/usr/local/google/home/sbeller/OSS/git/t/trash
directory.t5570-git-daemon/repo/repo_bad2.git'
+++ ls objects/pack/pack-0de42e9908e5d304b40de56c4ce788ce0ff4eff0.idx
++ p=objects/pack/pack-0de42e9908e5d304b40de56c4ce788ce0ff4eff0.idx
++ chmod u+w objects/pack/pack-0de42e9908e5d304b40de56c4ce788ce0ff4eff0.idx
++ printf %0256d 0
++ dd of=objects/pack/pack-0de42e9908e5d304b40de56c4ce788ce0ff4eff0.idx
bs=256 count=1 seek=1 conv=notrunc
1+0 records in
1+0 records out
256 bytes (256 B) copied, 0.000129681 s, 2.0 MB/s
++ mkdir repo_bad2.git
++ cd repo_bad2.git
++ git --bare init
Initialized empty Git repository in
/usr/local/google/home/sbeller/OSS/git/t/trash
directory.t5570-git-daemon/repo_bad2.git/
++ test_must_fail git --bare fetch git://127.0.0.1:5570/repo_bad2.git
++ git --bare fetch git://127.0.0.1:5570/repo_bad2.git
[18703] Connection from 127.0.0.1:39945
[18703] Extended attributes (21 bytes) exist <host=127.0.0.1:5570>
[18703] Request upload-pack for '/repo_bad2.git'
remote: Counting objects: 6, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 6 (delta 0), reused 6 (delta 0)
[18534] [18703] Disconnected
Unpacking objects: 100% (6/6), done.
From git://127.0.0.1:5570/repo_bad2
 * branch            HEAD       -> FETCH_HEAD
++ exit_code=0
++ test 0 = 0
++ echo 'test_must_fail: command succeeded: git --bare fetch
git://127.0.0.1:5570/repo_bad2.git'
test_must_fail: command succeeded: git --bare fetch
git://127.0.0.1:5570/repo_bad2.git
++ return 1
error: last command exited with $?=1
not ok 8 - fetch notices corrupt idx
#
# cp -R "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git
"$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
# (cd "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
# p=`ls objects/pack/pack-*.idx` &&
# chmod u+w $p &&
# printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
# ) &&
# mkdir repo_bad2.git &&
# (cd repo_bad2.git &&
# git --bare init &&
# test_must_fail git --bare fetch "$GIT_DAEMON_URL/repo_bad2.git" &&
# test 0 = `ls objects/pack | wc -l`
# )
#
