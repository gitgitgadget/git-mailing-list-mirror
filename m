From: =?UTF-8?Q?Nico_Sch=C3=BCmann?= <nico.schuemann@googlemail.com>
Subject: Git-Automerge
Date: Sun, 4 Apr 2010 18:47:14 +0200
Message-ID: <w2j1f05046e1004040947k3b812063ndbc2f8da3496effb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 04 18:47:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NySyq-000464-OO
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 18:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130Ab0DDQrR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Apr 2010 12:47:17 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:35525 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab0DDQrQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 12:47:16 -0400
Received: by bwz1 with SMTP id 1so2419833bwz.21
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=GBANvDuS7OUsugYgzbsvehH5yrPKfxuI2C3pg4sp63c=;
        b=YYEspVHS5GC3+wMJWySGVaW015VBgT0e0kmbs1jzBTQIMhlBWOyT9tyJ40iv1U/ur+
         TqWaKMLmfu03puWHutAPv6+OQGCLdh5FRI7mgD9Uyn293v5/rV2FxUi7CsAJkyFHkLug
         G0B5LkFdpzB3KWK4F5WzeVLQVbN8ceBhQHHec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=UToq2Cb0OF1ISlroAoYLNmAOa0g3HCnWFB2kqiv45S72MTGzwwgrzzUp179nqo3gjn
         qj64GemQaGl7ZdWzVj3droWDgi1KOnvVnUpHET55A+srghkBY37KIaEUDx1Y1MCkbl0b
         rgXTHwYhNGAOhA8bU0IzF2Fq/S0nk8jOC6EBM=
Received: by 10.204.67.195 with HTTP; Sun, 4 Apr 2010 09:47:14 -0700 (PDT)
Received: by 10.204.134.87 with SMTP id i23mr1656114bkt.125.1270399634985; 
	Sun, 04 Apr 2010 09:47:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143931>

Dear Git people,

after having been convinced by Linus Torvald's talk on git, I've been
using it for some days now.

But there is one thing that just does not get into my mind, or maybe I
am just thinking too complicated.

What I have is a productive system, let's call it MASTER and my
development machine, call it ME.

Now I made a copy of the MASTER tree by
$ git pull me@master:/path/to/stuff

And did some changes:
$ nano -w blablabla

Then I commited:
$ git commit

Everything fine until now.

What I want now are the changes to apper on the MASTER server, so I say
$ git push

But the changes do not appear on the master server. I have to type

# git reset --hard=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or
# git checkout -f
in order to make the changes appear. Since I do not want to login onto
that MASTER machine every time, what command do I miss on my developer
machine?

Thanks in advantage,
Nico
