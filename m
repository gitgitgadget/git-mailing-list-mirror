From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] git push --track
Date: Thu, 14 Jan 2010 10:49:00 +0900
Message-ID: <fc339e4a1001131749s4da9526bs13406571773c38fd@mail.gmail.com>
References: <op.u6g8jnixg402ra@nb-04> <be6fef0d1001131727r128c7727td2b948018d308719@mail.gmail.com> 
	<87eilt5uzx.fsf@catnip.gol.com> <be6fef0d1001131737i59b2e843ib032c30027520b54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rudolf Polzer <divVerent@alientrap.org>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 02:49:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVEqE-0006r2-Qq
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395Ab0ANBtY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jan 2010 20:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755368Ab0ANBtX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:49:23 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:65078 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363Ab0ANBtU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 20:49:20 -0500
Received: by iwn32 with SMTP id 32so120996iwn.33
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Zi/9w9GfwVQ4rmzGFpL6+SKd1Z9y/OUzFUjIXLRZ1cc=;
        b=iwuHYULQYyFWlNfe0qhCCMD8iuN4ARDAKe3pVlzF6NuV1zElk0XB8xAR/2Fajeb4BE
         R83cfYJ8asQ3n6yFxJBKXjIUqEW6cABuWat6cjMx2cxuV1mIcldLBb5s/4rTrEspS6Dd
         sCE5jPb2ey5D+X498G/mQp5WUimiKWr0Rwr8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=drKsSVg+7+JKyy0fsTu9jrM+ER40x4zxM0o3sss8iTs+tXMvNa4W7tNTmkeuxJMWkD
         wCpTpBLks2NljGyLFNdorHHDFpD2TtiWbrhF3/vcAHZ2Qp9crJS5UviExf7td1ZCQ+v3
         3CD6SKdjw5nBlTSYChZuegfNXMVGcQJFdSC7U=
Received: by 10.231.120.84 with SMTP id c20mr104039ibr.47.1263433760077; Wed, 
	13 Jan 2010 17:49:20 -0800 (PST)
In-Reply-To: <be6fef0d1001131737i59b2e843ib032c30027520b54@mail.gmail.com>
X-Google-Sender-Auth: 7280a5358e199bec
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136922>

On Thu, Jan 14, 2010 at 10:37 AM, Tay Ray Chuan <rctay89@gmail.com> wro=
te:
>> I very often create local branches and only later decide that I'd al=
so
>> like to push them to a remote -- but just as often, or more often, I
>> never do so. =A0It would be extremely annoying if I had to make that
>> decision at branch-time.
>
> I'm not saying that the feature should belong to git-branch and so yo=
u
> have to make this decision at branch time - I'm saying that since thi=
s
> has got to do with modifying branches (sort of), it should be in
> there.

I, and it appears other people, want to make this association at
push-time -- that's almost always when I make the decision "I'd like
to track this" -- so the most convenient and intuitive thing would be
to have a --track option to push.

Of course there could _also_ be some sort of branch sub-command (or
another command) to setup or change tracking state without pushing.
But "push --track" is more important for normal usage I think.

-miles

--=20
Do not taunt Happy Fun Ball.
