From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv6 01/16] test-lib: make test_expect_code a test command
Date: Mon, 4 Oct 2010 03:37:16 +0000
Message-ID: <AANLkTi=4_KN858sfXy59xgUSTCtj9ZkvW3+MrX3w3wWg@mail.gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
	<1286136014-7728-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 05:37:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2brh-0006AI-OK
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 05:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab0JDDhT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 23:37:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46149 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630Ab0JDDhS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 23:37:18 -0400
Received: by iwn5 with SMTP id 5so6377085iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 20:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2v5cTms2qEorKBGSeZQcR8BGfQPCzdVQ71v8ziLtcs8=;
        b=NxgsgDTxhKZVDAz//5OSF82eOEFBPeT5iEZSjO8A/k426ec9M30ngv9fhmUzDt+svX
         1ZrIQgbbuf1/67SSnzZa//rpRvCn+AQM80XqTIbhZGKfTGdCPe+aUs/RqnKUEETxIhV2
         8LsYi1F0KG9IupMdST05UimrHdiEyIDEkhm2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CKtuyuK8tAyn541o2okn5bBFHguClQT2IIStSQxQIs6aghTlGqjH/kACcpngi0g77R
         YKWDXPNay0/ZkpjCZ6QAvz1+PwcqvuBN+vvrT/KBuST7zRW/Nc8/pI/kxN30XCyEWcpI
         rHXhrNv+LJuSS1qMpNbxuI3kKj0UeVsTrz9V4=
Received: by 10.231.170.13 with SMTP id b13mr9471752ibz.62.1286163436638; Sun,
 03 Oct 2010 20:37:16 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Sun, 3 Oct 2010 20:37:16 -0700 (PDT)
In-Reply-To: <1286136014-7728-2-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157966>

On Sun, Oct 3, 2010 at 19:59, Elijah Newren <newren@gmail.com> wrote:
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Change test_expect_code to be a normal test command instead of a
> top-level command.

> [...]

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
> =C2=A0t/README =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 16 +++++++------
> =C2=A0t/t0000-basic.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 55 +++++++=
+++++++++++++++++++++++++++++++--------
> =C2=A0t/t1504-ceiling-dirs.sh | =C2=A0 =C2=A05 ++-
> =C2=A0t/t6020-merge-df.sh =C2=A0 =C2=A0 | =C2=A0 =C2=A04 ++-
> =C2=A0t/test-lib.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 40 ++=
++++++++++++++++---------------
> =C2=A05 files changed, 82 insertions(+), 38 deletions(-)

This doc change looks. Here's the diff against my patch for reference:

    diff --git a/t/README b/t/README
    index c216e8c..ee4c0cf 100644
    --- a/t/README
    +++ b/t/README
    @@ -475,10 +475,10 @@ library for your script to use.
                'Perl API' \
                "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl

    - - test_expect_code <exit-code> <git-command>
    + - test_expect_code <exit-code> <command>

    -   Run a git command and ensure that it exits with the given exit
    -   code. For example:
    +   Run a command and ensure that it exits with the given exit code=
=2E
    +   For example:

            test_expect_success 'Merge with d/f conflicts' '
                    test_expect_code 1 git merge "merge msg" B master
