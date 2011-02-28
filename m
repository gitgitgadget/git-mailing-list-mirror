From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #06; Sun, 27)
Date: Mon, 28 Feb 2011 14:22:42 +0100
Message-ID: <AANLkTikW1GVzFoq=zUxvi7MTcUYBLO6fbjJPVZziLUk8@mail.gmail.com>
References: <7vy650k62n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 14:23:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu34R-0007QE-Qw
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 14:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932Ab1B1NXX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 08:23:23 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48020 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab1B1NXW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 08:23:22 -0500
Received: by gxk8 with SMTP id 8so1507477gxk.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 05:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=jNa15iATJ84Blp7c8cqkl8sXHQ1GE/X9tKuvoAYJ7Ps=;
        b=Kgvk+cCf6aex7/h3+oHK+m99Vhafz1MruP9cqYC9+FzDDu4v0XhRX0GxMDtJ3wp4N6
         tPxvKIQpHTBeSfj6Yl+dy5RFAyTcMs14NEbUKwoOm8VDVlAiN5/syEqNgs6hMNlAIJ6m
         0oZb3PPFAAiunOvNuAZkb7TdcFToABmztpF3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=noG/6G2kT369hKIsq5X6GeXytjs7wQ1EAxyxYNyw28d2rbFLCToPbR/qkpq8Hk56U9
         5FoX/sonAz0r2OK8cl9+txuYuJLnJl9Fu13yb+/o7IgtxySvxD+f47eGrBXv1nm4A4CZ
         qDdkXMeb9wCsEPiBbvEZInpoCkekyo075YYKs=
Received: by 10.150.8.10 with SMTP id 10mr7231090ybh.7.1298899402112; Mon, 28
 Feb 2011 05:23:22 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Mon, 28 Feb 2011 05:22:42 -0800 (PST)
In-Reply-To: <7vy650k62n.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168111>

Heya,

On Mon, Feb 28, 2011 at 07:48, Junio C Hamano <gitster@pobox.com> wrote=
:
> * jc/checkout-orphan-warning (2011-02-18) 1 commit
> =C2=A0- commit: give final warning when reattaching HEAD to leave com=
mits behind
>
> Likes, dislikes?

I can't find a message containing this commit title, can you link to
the relevant thread? I did find that in the last what's cooking =C3=86v=
ar
replied and said +1? I agree that this is something we want to do
though, I'd like all operations in git to be as data-preserving as
possible, and to be similarly helpful to users about not losing data.
I think this is a good step in that direction.


--=20
Cheers,

Sverre Rabbelier
