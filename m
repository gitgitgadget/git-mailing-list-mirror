From: John Tapsell <johnflux@gmail.com>
Subject: Re: Confusing git pull error message
Date: Sun, 13 Sep 2009 21:57:37 +0100
Message-ID: <43d8ce650909131357m50428ffbs9c939be051254eb7@mail.gmail.com>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
	 <20090912211119.GA30966@coredump.intra.peff.net>
	 <7v1vmar353.fsf@alter.siamese.dyndns.org>
	 <20090913204231.GA8654@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 23:04:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmwF5-0003i3-4B
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 23:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133AbZIMVEG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Sep 2009 17:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755096AbZIMVEF
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 17:04:05 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:56821 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbZIMVEE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2009 17:04:04 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Sep 2009 17:04:04 EDT
Received: by yxe29 with SMTP id 29so3137466yxe.16
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7/BXIPNMWdkpwadwKM8H/pkgkXnbTl8lI4vAhXHRox4=;
        b=dBaQTII0UCDQik2gvLuUCWxo9TpFwM2u/rre6Q1Q2d2cQwh3rwfBNb3VfVg+qu9w4I
         FJ0Xa3nQWBXQZOmIbnB/sWKhSgydAFMRK7UnfIZDSetL4DzS3VYRS7UrmKAFO/KVvjN9
         lx5YQc5m1PNUT+62PIOlLf1sby4ROe2qLY8DU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dHN0L6AtF2SVNLRYK10ZjoYv0sfjdMyCiAavd8IzimGg3/P/f6aDkwwnZTrEbeX9Hp
         WrLfbdHuulAR3268cuDuRNXzgNldFz2B6R7RjkCcrLW7tQt8fgEAsmys/7PpFgcdTfxV
         ubY0LQShOka/Oramd+ortz2BlqIG+zSZSq6BQ=
Received: by 10.150.65.19 with SMTP id n19mr8752399yba.119.1252875458236; Sun, 
	13 Sep 2009 13:57:38 -0700 (PDT)
In-Reply-To: <20090913204231.GA8654@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128413>

2009/9/13 Jeff King <peff@peff.net>:
> On Sun, Sep 13, 2009 at 01:38:48PM -0700, Junio C Hamano wrote:
>
>> I saw some discussion on improving the wording. =C2=A0Here is what I=
 plan to
>> commit.
>
> Thanks for picking this up, I meant to re-post with improvements.
>
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "Your configuration=
 specifies to merge the ref"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "'${upstream#refs/h=
eads/}' from the remote, but no such ref"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "was fetched."
>
> What you have here is precisely what we observed. But I think one of =
the
> complaints was to say more explicitly "that ref doesn't exist on the
> remote", which I think should be the case if we have got to this poin=
t
> (anything else would have triggered an error in fetch).

Yeah, it kinda sounds like git is just being lazy, and can't be
bothered to fetch it :-)
