From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 17:15:54 +0200
Message-ID: <AANLkTimDOOjbCRJMOlW8sTEtiHdI4AqjdOcdFug7MD94@mail.gmail.com>
References: <4BFE750B.5030007@llaisdy.com> <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com> 
	<4BFE83A7.4020604@llaisdy.com> <AANLkTinn_D2nrZDoczHqvAFKdCxxubK0N0jHr-nE94JP@mail.gmail.com> 
	<4BFE8A99.5060906@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Thu May 27 17:16:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHeoq-0004jo-5o
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758116Ab0E0PQW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 11:16:22 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:48851 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758052Ab0E0PQR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 11:16:17 -0400
Received: by qyk13 with SMTP id 13so125280qyk.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=g7FvRvVRyMNrzLBSLKH+n49AyKITE+m6Qr83HYyV5mI=;
        b=IkkKmYLyrJ+y7pN/VP2qQomFYD64hTKNzZZ5LfiygASCgMZ5sd4XfkDpBX3tp4l3Zb
         yA9pH1hPxbnfYdvHiPHWaWyuEZXxoSsZWfgDKfMsxzWsr2PDwo2xelm4l+lJ9yjm8Alq
         HjCQa+i/6X5BPE3sOY6iw//CHytT9clNRv/yg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=V0urVFz1mLnoPVbdyw8MxTE41DGLYpLPpQ/z3wljE1DWkKClJY3j+1EEoYTyCMGxXj
         2AmmjhBfUntfimRhIURLHePVhtXrL+gRNLkGKNqLibQt6YfJavA6HuymsmLY++icTmpX
         X8+mH2CsqtCizXokG9gmnaAFthduB58fU84xY=
Received: by 10.224.8.4 with SMTP id f4mr5741567qaf.10.1274973376145; Thu, 27 
	May 2010 08:16:16 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Thu, 27 May 2010 08:15:54 -0700 (PDT)
In-Reply-To: <4BFE8A99.5060906@llaisdy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147872>

Hi,

> =C2=A0 =C2=A0/opt/libexec/git-core/git-pull: line 11: git-sh-setup: N=
o such file or
> directory

You seem to be missing git-sh-setup (called `git-sh-setup.sh` in
git.git), another shell script that's called by every other shell
script in Git.

> As for reinstalling: unless something else is broken, I'm happy with =
"git
> fetch; git merge origin". =C2=A0However, I should like to understand =
why git pull
> is not working.

A lot of other things won't work. `git rebase -i` for example is
another shell script `git-rebase--interactive.sh`.

-- Ram
