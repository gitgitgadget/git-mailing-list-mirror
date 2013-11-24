From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: slow git-cherry-pick.
Date: Sun, 24 Nov 2013 19:48:13 +0700
Message-ID: <CACsJy8BNVwVWh7847Vvtz0mRAY3OX4DkYZ_D_9EX7n6MfTjfTA@mail.gmail.com>
References: <2142926.gg3W3MsbJZ@localhost.localdomain> <CACsJy8CAAov1nSGPx79U+md4xROsCydidHPcipOb_sdFwNdSkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: pawel.sikora@agmk.net
X-From: git-owner@vger.kernel.org Sun Nov 24 13:48:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkZ7I-0008Vl-Om
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 13:48:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298Ab3KXMsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 07:48:45 -0500
Received: from mail-qe0-f53.google.com ([209.85.128.53]:45856 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab3KXMso convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Nov 2013 07:48:44 -0500
Received: by mail-qe0-f53.google.com with SMTP id nc12so1183974qeb.12
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 04:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=47ITwq+9rtylkrZomMfcQW9F0F3mcbPUF58Vf9jp0vY=;
        b=vm/7tt7GxKHKD0iA40N1SKYX7NPF63lmywhkFy+z/3shPLVFTlHbyONQ+SvIXlm81c
         gz/I6n6TejB2r68FjyHJcApvUn93Th91kxxMsCuGwh3LSyx9wSwKrv56azoXBeV8Ns65
         LJ/b+r/HFQsuFsS6VxF9WBa0QNBTc96mC54Bz+jRY6TjDTjwiJzlSlUfj5F5Ut7AcFIe
         qChj1te2fH1m02bDGdVgRBKcP1Qx+D3ntaSTncYyB6KiR3MFuRzfbF9ViaXJbig+vnE8
         k5hT5dw4LlPs6h+QLrUuoKdaaSec3gLz+AiFj0Kkns6NsQjrzXVloz2qcJ2CDFmmRe4L
         hhuw==
X-Received: by 10.224.32.66 with SMTP id b2mr37708241qad.80.1385297324047;
 Sun, 24 Nov 2013 04:48:44 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Sun, 24 Nov 2013 04:48:13 -0800 (PST)
In-Reply-To: <CACsJy8CAAov1nSGPx79U+md4xROsCydidHPcipOb_sdFwNdSkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238257>

On Sun, Nov 24, 2013 at 7:47 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Nov 24, 2013 at 5:45 PM, Pawe=C5=82 Sikora <pawel.sikora@agmk=
=2Enet> wrote:
>> i've recently reinstalled a fresh system (fc20-beta) on my workstati=
on
>> and observing a big slowdown on git cherry-pick operation (git-1.8.4=
=2E2-1).
>> the previous centos installation with an old git version works faste=
r
>> (few seconds per cherry pick). now the same operation takes >1 min.
>
> What is the git version the reinstallation? Do you cherry-pick on one

I accidentally the word "before" in the first question..

> commit or a commit range?
--=20
Duy
