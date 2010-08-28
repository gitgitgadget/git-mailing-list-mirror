From: Elijah Newren <newren@gmail.com>
Subject: Re: git pull --rebase differs in behavior from git fetch + git rebase
Date: Fri, 27 Aug 2010 20:40:49 -0600
Message-ID: <AANLkTimz4P3EGnZntQubL06ZqXREiDTDVk+fb9VVLDKN@mail.gmail.com>
References: <4C772A01.5030207@workspacewhiz.com>
	<alpine.DEB.2.00.1008270124450.20874@narbuckle.genericorp.net>
	<4C77DE60.6020809@workspacewhiz.com>
	<AANLkTimEO==c7Pzi99VfvDp7S9HN=V2j6t0kk--w1kb9@mail.gmail.com>
	<4C783C66.3000008@workspacewhiz.com>
	<AANLkTimBv3EVWaEnateD95sUi_LkmNw8RKJZYrW4dUFy@mail.gmail.com>
	<4C786F36.3060107@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dave Olszewski <cxreg@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 04:41:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpBLy-0007yZ-1B
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 04:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab0H1Ckw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Aug 2010 22:40:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39015 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623Ab0H1Ckv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 22:40:51 -0400
Received: by fxm13 with SMTP id 13so2371291fxm.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 19:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DPtyUuYbjnkZxzBQgjyHwQ/ZGTANUB1fUdxqVcGmzKQ=;
        b=Lg51lA5BCZCACtDevqH/NCFb1jPAdtKvrHs3E3YllMdtLrp/erKR0HAHo8VI8f8rlF
         AHZIeVMUJkXXty77w7opYgKqYlgLZUhOaOxr9rhh/GjEH7ZbECUQoyFwUrgf77pmcWZB
         F5Iz0AxnB4R/0YxmeTMJjws3qydV7wEeZ8ch4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qM+pJHlVPV4fWDR3XdLy95dFpV9buiMpZ/T1eKb8QWq2QZhjz8UG3jBQd4bYGUBqlx
         l9gEr/kGwIR3ixlt1qUvjFJR+jMdFt1uA6O9RgbZ70A1T9mCxBsIfGO6DVhniiNs5GKo
         z1gamhJ0L4DccbDrsV0YGnf0FcTN36TEzdius=
Received: by 10.223.113.13 with SMTP id y13mr1338827fap.37.1282963249867; Fri,
 27 Aug 2010 19:40:49 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Fri, 27 Aug 2010 19:40:49 -0700 (PDT)
In-Reply-To: <4C786F36.3060107@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154630>

On Fri, Aug 27, 2010 at 8:06 PM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> Okay, there is _not_ a problem with the patch in 1.7.2.2 for the "bro=
ken"
> repository I have in front of me right now, but I wish I hadn't trash=
ed the
> other broken repository someone else had. =C2=A0:(
>

> Sorry for causing an issue, but I definitely appreciate the fix alrea=
dy
> being available.

Not a problem; it's totally understandable.  Believe me, I had a whole
bunch of similar problems when trying to deal with this bug when
people were hitting it at work (e.g. trying to duplicate by cloning,
which never worked since the bug depended on reflog state).

In any event, I'm glad it's working for you now.  :-)

Elijah
