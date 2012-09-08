From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] doc: move rev-list option -<n> from git-log.txt to rev-list-options.txt
Date: Sat, 8 Sep 2012 23:11:09 +0700
Message-ID: <CACsJy8CmwvR+ZN5eoqpn=yj0GdmgWsOGQNpUK2GetktKuZ36iQ@mail.gmail.com>
References: <1346941683-24832-1-git-send-email-pclouds@gmail.com>
 <5049B54F.7020301@drmicha.warpmail.net> <7vwr05yctv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 18:12:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TANeJ-0007pJ-C2
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 18:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab2IHQLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Sep 2012 12:11:44 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35099 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972Ab2IHQLn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2012 12:11:43 -0400
Received: by iahk25 with SMTP id k25so481198iah.19
        for <git@vger.kernel.org>; Sat, 08 Sep 2012 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=n0tr83pPin/0jAHj7GSAr3Gfw4R/GKXFhZGtqqUg2Y4=;
        b=osZ1v/BlMLcock1sxx1FeaXUIa5uTgNw8N8WtpB2SRtbPD5xdsuCQXobFCOwSrz9nQ
         rm/h5YOjVRyWwxPPHqEL7iGtCbZR8elyFI34IGDExHpoDFTvoHmBXM+NForIce31bo+H
         hSv27xmyMnvo9FVy4zE+ih3YZAQ9Gc9TBrVOaJAE+0iu6GYmvMrA84TjHSeCJShmHLCY
         cd7G9xfYwXwkms5UZQPcpgjB5mhYwejcwgTPL18dyTdquBSM0vzV+i1o3ypwjm1CryWq
         LMexCFSjAyYnfmUdXziMy1ClfhU+TBPq8+wINVTvUDr3usg0aWG1DRil7hM535qFtvHw
         VBMg==
Received: by 10.50.85.134 with SMTP id h6mr2401014igz.2.1347120703077; Sat, 08
 Sep 2012 09:11:43 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Sat, 8 Sep 2012 09:11:09 -0700 (PDT)
In-Reply-To: <7vwr05yctv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205017>

On Sat, Sep 8, 2012 at 12:14 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>>  Documentation/git-log.txt          | 6 ++----
>>>  Documentation/rev-list-options.txt | 3 ++-
>>>  2 t=E1=BA=ADp tin =C4=91=C3=A3 b=E1=BB=8B thay =C4=91=E1=BB=95i, 4=
 =C4=91=C6=B0=E1=BB=A3c th=C3=AAm v=C3=A0o(+), 5 b=E1=BB=8B x=C3=B3a(-)
>>
>> That is one reason why "core.local=3DC" (repo specific) and "git -c
>> core.locale=3DC" (can be used in an alias) would be useful ;)
>
> Or "LC_ALL=3DC LANG=3DC git format-patch ...".

The only problem is I forget to do that from time to time (and doing
that bothers me too)

> It does not bother me (even though I do not read Vietnamese), but
> this has been brought up a few times, and we may want to revert the
> i18n of the diffstat summary.  It does not seem to add much value to
> the system but annoys people.

That's one step towards a better interface for non English speaking
users. "git log" interface for example still shows Author, Commit,
Date in English and these strings are shared with format-patch.
Reverting back to English to me is a step back.

This brings back to a series I posted about two weeks ago and got no co=
mments

http://article.gmane.org/gmane.comp.version-control.git/204285

I think it's a reasonable approach. Use English for machine interface,
otherwise a native language if available.

> After all, the "upstream" diffstat
> does not localizes this string (I just checked diffstat-1.55 with
> Jan 2012 timestamp).
--=20
Duy
