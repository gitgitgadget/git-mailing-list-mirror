From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Should git-citool be in mainporcelain in command-list?
Date: Mon, 6 Sep 2010 22:00:19 +0000
Message-ID: <AANLkTimRoAgAtrkpyd08mVG93prQ40B1y=ReLRdNfbWt@mail.gmail.com>
References: <AANLkTi=Hn_GG1y3gkVxgnsKyVD+VutG5SU5HhmhRfktH@mail.gmail.com>
	<20100906213937.GF26371@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 00:00:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osjjn-0001Ew-If
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 00:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717Ab0IFWAW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 18:00:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45300 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456Ab0IFWAU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 18:00:20 -0400
Received: by iwn5 with SMTP id 5so4638039iwn.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DDlYxvbTL+rh1vzKkCB/jhMsIrQq5TNjPj3IpQZBWsE=;
        b=dBXCqRAIpA9zFUuINsoPorhcdQThj3y2k+DCwDd0qO7o5vRc7sfw1b+bWHaktwGq45
         F2dwzWBubcI5MEu5KO8McLMMeW4OYka/y58nSyP2Ij6Qv+pHG24eLPcPAiLZjFJ/d0mi
         FNR9Yk6lwwovDxPJOsWuNm2Zk2JfrSBZxSj10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=e7zfiZ+xnuuyG1zUaeU/b+ZdauyDCY04y8tELfofYSH9I9mFMoLcdTPxC/iKuhEXRR
         TCae427hciHOPkrXXMP5p04iVY5ONSgPv5N9GYxEbcmEJaUfz/UKgC/dCTosBnTL4SSN
         RqmhesQ/bBLHK45p0E7tdV547iiHjETkimk2A=
Received: by 10.231.149.12 with SMTP id r12mr6901726ibv.185.1283810419788;
 Mon, 06 Sep 2010 15:00:19 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 6 Sep 2010 15:00:19 -0700 (PDT)
In-Reply-To: <20100906213937.GF26371@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155630>

On Mon, Sep 6, 2010 at 21:39, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Maybe there should be an aliases category:
>>
>> =C2=A0 =C2=A0 $ grep -e git-gui -e citool command-list.txt
>> =C2=A0 =C2=A0 git-citool =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mainporcelai=
n
>> =C2=A0 =C2=A0 git-gui =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mainpor=
celain
>>
>> A very minor nit, just something I ran into while gettext-izing and
>> wondered "what's that".
>>
>> But I'm probably the only one that's used command-list.txt for
>> anything non-Make related in a while :)
>
> Its main purpose is to populate the command list in git.1:
>
> =C2=A0 Main porcelain commands
> [...]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git-citool(1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Graphical alternative to git-commi=
t.
> [...]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git-gui(1)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 A portable graphical interface to =
Git.
>
> What do you think this should say? =C2=A0(Honest question --- I
> haven't thought hard about it.)

I haven't either, and I don't use git-gui or the git citool alias. I
didn't even know about it until yesterday.

The entries in git(1) don't indicate that citool is a convenience
alias for git-gui:

       git-gui(1)
           A portable graphical interface to Git.

       git-citool(1)
           Graphical alternative to git-commit.

Maybe it shouldn't be listed there at all to avoid confusion, or maybe
it should be in an aliases category to clearly indicate its function
as a convenience alias in the manpage.
