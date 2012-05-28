From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Vietnamese l10n pull request problems
Date: Mon, 28 May 2012 15:42:57 +0800
Message-ID: <CANYiYbGkHn7NgKgi2SG11fWV7kzuLPH_vhgOrhow17s9JzqBNg@mail.gmail.com>
References: <CANYiYbHWsfNSVESsZ6KoSH+_FEuLrrESC1_N0=DB5uMaWSv+Xg@mail.gmail.com>
	<4fc320ce.04d8440a.0581.ffff8a98@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 09:43:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYubX-0000cH-66
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 09:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128Ab2E1Hm7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 03:42:59 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:41842 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab2E1Hm6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2012 03:42:58 -0400
Received: by gglu4 with SMTP id u4so1666228ggl.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 00:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=WUuyLqUaq1AX+CX1Uj+HAV6S5iBljZbyYCrhLy0Q+fU=;
        b=Vfc5IvUvzrdezfQQd5KQ+UucMeSOXr8uODePxAMrI4rU+yDIhtlKpn6eXjhbJ8vVX/
         HoBqbrqHsh3pXsuLYYUFU1KgqtImQ9Oq81KmqD548DQsQJZtBpb4SVCGvT5O/kKl91Mw
         dT7XXMBzK4v+/vubPvJ/GdVCdbEBNJQA9daywgA/39Dqz+mw2XdfIVpEikyr+3ljqUp8
         RKOCLG+/2aCu83xOlcf8KoJ5VcHERTmVFTKi/WqbGhBVbaB+K1uZ8MfVvVt55EPEBlX9
         K3G1LnzwWgtXuqzPv409hV4eGUonHlQk7podNh9lCARkSHyn4Q2B88n8DG0sC8nj1hO5
         bj2Q==
Received: by 10.50.180.225 with SMTP id dr1mr3729165igc.52.1338190977616; Mon,
 28 May 2012 00:42:57 -0700 (PDT)
Received: by 10.50.82.105 with HTTP; Mon, 28 May 2012 00:42:57 -0700 (PDT)
In-Reply-To: <4fc320ce.04d8440a.0581.ffff8a98@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198633>

2012/5/28 Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman@gmail.com>:
>> Fuzzy means wrong
> It isn't true! When complete into mo, fuzzy will be ignore. When run,=
 it use origin string.
>> pull from git.git
> Now I will:

> -Drop my current repository

It's not necessary, just making a force push is OK. I already
clean the history, squash the commits, add the signed-off-by
line, and what I have done is pushed to branch WIP/vi/master
at:

 * https://github.com/git-l10n/git-po/commits/WIP/vi/master

You can just reset your master branch to it. See comment:

 * https://github.com/git-l10n/git-po/pull/22#issuecomment-5954600

> -Clone from git.git

You already forked a repo directly from https://github.com/git-l10n/git=
-po/
right? And registered it as your team's main repo, which you have alrea=
dy
written in the TEAMS file.

You should clone your own forked repo, which you have rights to push.

> Sorry about inconvenience!

Your translation for Vietnamese is most completed than any other langua=
ges.
=46eel free to make pull request.

Indead, close pull request #22 on GitHub is unnecessary, just clean
commit history of your master branch, create new commit to fix
fuzzy translations, and the pull request will update automatically.

--
Jiang Xin
