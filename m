From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] sequencer: revert d3f4628e
Date: Sat, 12 Nov 2011 21:43:13 +0530
Message-ID: <CALkWK0=QHUeKH6ccVLYJVW_RxXbEaLfwafTVzJ94+s49j=8QjA@mail.gmail.com>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-6-git-send-email-artagnon@gmail.com> <20111106004257.GG27272@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 17:13:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPGD7-0003kY-DU
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 17:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab1KLQNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Nov 2011 11:13:37 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39744 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab1KLQNg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2011 11:13:36 -0500
Received: by wwe5 with SMTP id 5so2624097wwe.1
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 08:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ij3+4MNXT/0FjKUVhhMLP8FffqdqKkHRvniJp0Rmxro=;
        b=p3ioY2udkMIRQ/QLQvQTQOBP55sAn8vzmKQ6iXzL/9lF5SghPxUekzZuflz2D4Mqeg
         oHMuVTARhl52srvydGM5uTEOuQCk5Rvsy/lmCLivmccRH7EugsdkMroOq+lfn51r5f7M
         Ha1bn8wTUDFPhrvIHBd1G5wxlU1LXuB/m+CRQ=
Received: by 10.216.188.145 with SMTP id a17mr2733051wen.24.1321114415180;
 Sat, 12 Nov 2011 08:13:35 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Sat, 12 Nov 2011 08:13:13 -0800 (PST)
In-Reply-To: <20111106004257.GG27272@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185308>

Hi Jonathan,

Jonathan Nieder writes:
> Is this patch just reverting a previous patch? =C2=A0If so, why doesn=
't the
> commit message use the usual format
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Revert "<commit message>"
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0This reverts commit <unabbreviated object =
name>.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0<explanation>
> [...]

I'd have loved to use 'git revert d3f4628e', but that ends up creating
a lot more work: recall the big move made by 1/5?  I'm trying to
"effectively port the inverse of the changes made by d3f4628e in
revert.c to sequencer.c" -- would you still like to see a git-revert
style commit message?  Don't you think it'll be misleading?

Sorry about the shoddy commit messages though: I'm polishing the
series now that I'm convinced that it's heading in the right
direction.  Hopefully, I'll have more to show soon.

Thanks.

-- Ram
