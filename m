From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] t/depend-add-using-export
Date: Sat, 9 Oct 2010 14:21:06 +0200
Message-ID: <AANLkTik=tdfYHEKKLOMKBSm55mXptROKGis5gmusGFPK@mail.gmail.com>
References: <1286588598-4005-1-git-send-email-odabrunz@gmx.net>
	<AANLkTik6R89vPhwKyWOheHPkxQ9JPpmrQVmXon8Vn4+A@mail.gmail.com>
	<20101009105456.GA7328@santana.dyndns.org>
	<AANLkTi=Xhd8DY+f1ZYR6dEhHvC-=50iHLnhdv8GTacNX@mail.gmail.com>
	<20101009121003.GA19991@santana.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	martin f krafft <madduck@madduck.net>,
	Per Cederqvist <ceder@lysator.liu.se>
To: Olaf Dabrunz <Olaf@dabrunz.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 14:21:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4YQQ-0003q4-6o
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 14:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755311Ab0JIMVI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Oct 2010 08:21:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60186 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab0JIMVH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Oct 2010 08:21:07 -0400
Received: by iwn6 with SMTP id 6so1378744iwn.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ge5eD5NmzRfkPdQuYJ0/SXgbejAixnG13bucotNUPic=;
        b=PS4mB2tsSPEjHXfYd8S8vmaNsTkZ3aOPqhO8JbJlEPB9HqK3YNhJ9HLGpWV+ey8UtN
         LPCHt5CdIN+kndu8Soh564mZ0XH+iTKbKj0/S0FZSSPGVGcXxPBUhco8eHj9yB+ndP53
         GBCSR1uT30Uz/8I7QVw8e3wqeDjVhs1FFZP9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fwNEoOp45xGXBfVgiwwEy7rYQcsrUisu6X4+GvoBHYczjlTdUv3tc6p1a8hWCvTPVQ
         SUOHRXXjFeXCpAM+ExnCU21OwkJcJqs1BdzRJ0TJAAteEmt3A54ZR/Yi0pKJYSRi1vYm
         7BMqHIDHVX32RYVb5oLwDepRbU2fIaRCRJzdQ=
Received: by 10.42.108.72 with SMTP id g8mr630432icp.436.1286626866165; Sat,
 09 Oct 2010 05:21:06 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Sat, 9 Oct 2010 05:21:06 -0700 (PDT)
In-Reply-To: <20101009121003.GA19991@santana.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158584>

[ Just bringing back all Cc's ]

On Sat, Oct 9, 2010 at 14:10, Olaf Dabrunz <Olaf@dabrunz.com> wrote:
> On 09-Oct-10, Bert Wesarg wrote:
>> On Sat, Oct 9, 2010 at 12:54, Olaf Dabrunz <Olaf.Dabrunz@gmx.net> wr=
ote:
>> > [...]
>>
>> When I understand this correctly, this hand made merge commit on bas=
e,
>> has also the just removed dep as parent. But the tree does not inclu=
de
>
> The hand made merge commit on base only has a removed dep as a parent=
 if
> that removed dep is brought in again directly, as the new dep that is
> added here. The only parents of the hand made merge commit are: the t=
ip
> of the current topgit branch's base and the new dependency.
>
> =C2=A0 =C2=A0hand made merge commit on base =3D =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git-commit-tree $tree_from_merge_on_export=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0-p $topgit_base_branch -p $new_dep
>
> In general, the new dep may already have merged in a dep that we
> previously removed from our topgit branch. So the previously removed =
dep
> is brought in indirectly by merging a branch that contains it.
>
> This patch tries to cover both cases. The latter case and requirement=
s
> for tg depend add to cover it were discussed by you and Uwe in this
> thread:
>
> http://lists-archives.org/git/688698-add-list-and-rm-sub-commands-to-=
tg-depend.html
>
>> any code from that dep. So git merge-base would select this commit a=
s
>
> If the new dep _is_ a previously removed dep, the code of the new dep=
 is
> contained in the hand made merge as well.
>
> If the new dep _brings in_ a previously removed dep, it depends on ho=
w
> the previously removed dep was merged into the new dep we are trying =
to
> merge now. If our new dep merged in the previously removed dep but us=
ed
> the "ours" merge strategy to supersede that dep's contents, it does n=
ot
> bring in any code from that dep but only brings in that dep as part o=
f
> it's history.
>
>> the merge base.
>
> Yes, as the previously removed dep is now -- directly or indirectly -=
-
> part of the history of the hand made merge on base.
>
> I should really draw graphs. But here is the mail anyway (release
> early...).
>
> Olaf
>
> --
> Olaf Dabrunz (Olaf <at> dabrunz.com)
>
>
