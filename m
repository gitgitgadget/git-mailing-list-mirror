From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git ls-files handles paths differently in Windows and Mac (probably Linux)
Date: Wed, 13 Oct 2010 04:20:39 -0700 (PDT)
Message-ID: <m3aami731j.fsf@localhost.localdomain>
References: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com>
	<AANLkTimB6s_yt6L59xpqsWO_yBsZxuVCiExFoSm9FcN1@mail.gmail.com>
	<C29949EA-5717-4BA3-936E-354FCB107877@jetbrains.com>
	<38052CF8-66F3-40FD-8D2D-8FD58A622F7B@jetbrains.com>
	<AANLkTi=6nJAYKB_MTjXL3oftcWtr_wtdHaULYzRcP6oP@mail.gmail.com>
	<AEC0873D-4AFC-402E-9D7D-197A7D40DCDD@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 13:20:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5zO8-0001Qu-MO
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 13:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab0JMLUn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 07:20:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39792 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab0JMLUn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 07:20:43 -0400
Received: by bwz15 with SMTP id 15so3086022bwz.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=eoG8IP+BS22IhMhRSxEclsvJV0ZyShhZJzwbSq5ehI0=;
        b=us4kX0uGOjiyj+YSugSk1EDstdrZ/dQy5tnAfheOrZH2f02plIA8ULdGAyALXLgsB0
         6A061DczdPqDnbQgnObOZvVYarMTe83QPuZwk1VvVDPR75cbalMFgSoc6l4SayxiMNRW
         jd5pB4ptyQklRxLnKmoJmDxWYq4WZS3qrHq5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=LccSv5Z/M3DLFpq5LgCAGeSMpasfafR99sIEmA7VI9ABkOY9BUgMa3fBcp2JKpjVI8
         aawiGWZtiqfW9DDATmovMAybnptVXw5UupuGTbRhPMVdfO8FQ7sqc9sJLMsE6Buk/Sp0
         9TlIphRpsdVeBvc3mkK5vyI0H7HRCMM5GqETo=
Received: by 10.204.118.202 with SMTP id w10mr7711646bkq.40.1286968841409;
        Wed, 13 Oct 2010 04:20:41 -0700 (PDT)
Received: from localhost.localdomain (abve214.neoplus.adsl.tpnet.pl [83.8.202.214])
        by mx.google.com with ESMTPS id u4sm5935068bkz.5.2010.10.13.04.20.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 04:20:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9DBKBlH007406;
	Wed, 13 Oct 2010 13:20:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9DBJrK0007399;
	Wed, 13 Oct 2010 13:19:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AEC0873D-4AFC-402E-9D7D-197A7D40DCDD@jetbrains.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158927>

Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com> writes:
> 12.10.2010, =D2 19:25, Alex Riesen =DD=D0=DF=D8=E1=D0=DB(=D0):

> > [..]. What are you trying to do, BTW?
>=20
> I'm developing a plugin for Git integration for IntelliJ IDEA (an IDE=
 for
> Java and other languages).
>
> And the task I'm working now is to get the status of index and workin=
g
> tree. I want to make it as fast as possible.  To work with a Git
> repository I start a process with git native commands, so every comma=
nd to
> execute is additional cost.  (Maybe I could work with the filesystem =
and
> raw Git repository, but it would be an overhead).

Isn't IntelliJ IDEA written itself in Java?  Perhaps you could use JGit=
, the
Java implementation of Git (though it is not complete implementation ye=
t, if
I remember correctly).  It is EDL (new-style BSD) licensed, and is used=
 by
Eclipse and NetBeans.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
