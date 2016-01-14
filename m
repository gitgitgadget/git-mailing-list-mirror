From: =?UTF-8?B?6YOt6IW+6aOe?= <tfguo369@gmail.com>
Subject: [issue?]'git branch -D' case sensitive issue
Date: Thu, 14 Jan 2016 15:52:02 +0800
Message-ID: <CAB4fgE81JHzU=KmN9e=pjsurboipQ3K-pMu-26j+o+FU5G7tQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 08:52:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJci4-0001aP-1Y
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 08:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbcANHwF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2016 02:52:05 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35917 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbcANHwE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2016 02:52:04 -0500
Received: by mail-qg0-f50.google.com with SMTP id e32so385827522qgf.3
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 23:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=wJeXgryAqLFe2d5ZOz3GszheVNgIZRsbrfTg2Yb769c=;
        b=WoxE31h19+1vnkd96Na9qgONAn09ju7HPpwgqk+/UexIZ5Pz5h/SzueVzAAzmzCDW/
         uDjjejNHMyapFYZ9Q2tLGl1ivqTPFFaxilPmR7z/yXxJeKyvpzDAsC4CzhE/OhIeRon0
         yryHdSqiQFMhb6tRQW3wdX96t4ixFxgYa0/yvKN7j4r7nf8LmI1fcsVhxD8oZgMK8h2D
         I3M1X6RmpkK4SrTZassVcCqsuk84I9/GpamVQYVN//KgsIGlSHuxJOq04hmXaPhs2Wmh
         iCHd4FTvglnEunrMQnWn5ODo4nbo59f1W+9FyzGsgftioZcWSSHnuvkVCHgFNVPeTd1p
         oHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=wJeXgryAqLFe2d5ZOz3GszheVNgIZRsbrfTg2Yb769c=;
        b=bDmncwynEyw7Z5pOuYKXOxbo66KKfF0ASF0goAB/UQCIvOHTWo6alpG0iA6oKKk0A9
         P7DgpN9coFOlArWpWW5a0+/yMVnKxFioJghg/ah2K1OLubPNmdTlNkDBGPnlHlAvPtic
         C01UBxCQzpC3gf7N93w+ig8YPGni83RXl9i9jd77jHvAhYnMg0XMgPGvRNfHgs7oXJwh
         s6Qz9E2YYbO6aBDjejeBfSpQNxO9X87SoeXKtOe5W3rZWvDSeQZV3mgO8Uo4Q66IroDb
         btDxHNbqNUoBUFPg8qrTfWNEDAAebtNgZg8OAp8yKRRO7jO8lc1wV4QrUROwPmVls5hE
         D9vA==
X-Gm-Message-State: ALoCoQnte9Q+0/zzf8QL6x3tv2q3PMScZFSe7jM7s0P4q8rW3kRrdj+7C/cBqQW8ekq0EkgNUj9gJacJe00mlkLC4bE+8zXahQ==
X-Received: by 10.140.94.198 with SMTP id g64mr3314538qge.57.1452757922724;
 Wed, 13 Jan 2016 23:52:02 -0800 (PST)
Received: by 10.55.181.70 with HTTP; Wed, 13 Jan 2016 23:52:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284022>

Hi All,
I encountered some issues when using 'git branch -D'.
It's strange, the command 'git branch -D' is case sensitive.
Here is the operated log.

=E2=9E=9C  my-emacs-conf git:(NIce) git branch -avv
* NIce                  fed5d9c Update js2-mode $ js-beautify.
  master                fed5d9c [origin/master] Update js2-mode $ js-be=
autify.
  remotes/origin/HEAD   -> origin/master
  remotes/origin/fake   8ec9cad fake.
  remotes/origin/mac13  13ae483 mac pro 13's config.
  remotes/origin/master fed5d9c Update js2-mode $ js-beautify.
=E2=9E=9C  my-emacs-conf git:(NIce)
=E2=9E=9C  my-emacs-conf git:(NIce) git branch -D NIce
error: Cannot delete the branch 'NIce' which you are currently on.
=E2=9E=9C  my-emacs-conf git:(NIce)
=E2=9E=9C  my-emacs-conf git:(NIce) git branch -D NICe
Deleted branch NICe (was fed5d9c).
=E2=9E=9C  my-emacs-conf git:(NIce) =E2=9C=97 git branch -avv
  master                fed5d9c [origin/master] Update js2-mode $ js-be=
autify.
  remotes/origin/HEAD   -> origin/master
  remotes/origin/fake   8ec9cad fake.
  remotes/origin/mac13  13ae483 mac pro 13's config.
  remotes/origin/master fed5d9c Update js2-mode $ js-beautify.

Hope someone can give me a hint.

=E2=9E=9C  my-emacs-conf git:(NIce) =E2=9C=97 git --version
git version 2.6.3
=E2=9E=9C  my-emacs-conf git:(NIce) =E2=9C=97 sw_vers -productVersion
10.11 OSX

BRs,
terry3
