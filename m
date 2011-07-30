From: =?UTF-8?B?5a2Z55Cm?= <qsundw@gmail.com>
Subject: git fatal: error in sideband demultiplexer
Date: Sat, 30 Jul 2011 18:16:58 +0800
Message-ID: <CALQf3zknO9ZxXCLWy3Bep2eMhrt-jfLkRWJBOf-f2ebku7YZHg@mail.gmail.com>
References: <CALQf3znEm2ZqS1nvon0iB-6ddm-rJyTAPYgCENy2xF0AZb1U+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 12:22:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qn6gJ-0003z5-Aw
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jul 2011 12:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab1G3KRB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jul 2011 06:17:01 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55542 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1G3KQ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2011 06:16:59 -0400
Received: by fxh19 with SMTP id 19so2997589fxh.19
        for <git@vger.kernel.org>; Sat, 30 Jul 2011 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=vr4gSyYdPCZhIagIGUzPsASAeWpAjFrgPukd6kTUwzc=;
        b=XmaMnSL1SuOaU2Ai+ghYu5I690wgCkhea0dAb3OGp8FQ5GD2tli5F1PxaEry75qkSz
         BZImh+NUtz9bJuEapQeLjrqa09S1Ot2aZJVlp8k83YjrZxmRQnN22WNxi7r7+iyhzSe2
         HOEKS3tbqBRfhhYLfKyjoOsjctP4pHgJ3Nz74=
Received: by 10.223.43.1 with SMTP id u1mr3309872fae.38.1312021018696; Sat, 30
 Jul 2011 03:16:58 -0700 (PDT)
Received: by 10.223.87.67 with HTTP; Sat, 30 Jul 2011 03:16:58 -0700 (PDT)
In-Reply-To: <CALQf3znEm2ZqS1nvon0iB-6ddm-rJyTAPYgCENy2xF0AZb1U+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178187>

Hi git experts,

I ran into one=A0annoying=A0 issue when using git to clone=A0repository=
 on windows 7.

I tried to clone the repository in the intranet.
git clone git://10.59.8.235/test/t10
The returned information is as below:

Cloning into newdb...
remote: Counting objects: 1231592, done.
remote: Compressing objects: 100% (239755/239755), done.
Receiving objects: 100% (1231592/1231592), 2.70 GiB | 4.93 MiB/s, done.
fatal: read error: Invalid argument
Resolving deltas: 100% (935560/935560), done.
fatal: error in sideband demultiplexer

Everything looks good expect the two errors. And at last, nothing is
copied in the local folder.
The server is running by myself in another Windows 2008 Server with
1.7.6.msysgit.0 installed. And I tested the clonging on another SUSE
Linux, it works normally when cloning the same repository.

I googled and found no answer to the issue. I'm not sure where the
cause is, due to the server side config, or the client side config?
Can you expert guys give some=A0diagnosis=A0on the issue?

Thanks,
Cheney
