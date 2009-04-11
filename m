From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH] Update delta compression message to be less misleading
Date: Sat, 11 Apr 2009 14:42:08 -0500
Message-ID: <449c10960904111242y38279c9cxc0a464255c2aa4db@mail.gmail.com>
References: <7v4owzr72g.fsf@gitster.siamese.dyndns.org>
	 <1239291939-613-1-git-send-email-dpmcgee@gmail.com>
	 <7veivzdmed.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:43:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsj7D-0001bP-Nl
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963AbZDKTmM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 15:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbZDKTmM
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:42:12 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:56410 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbZDKTmK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 15:42:10 -0400
Received: by ewy9 with SMTP id 9so1594485ewy.37
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/I0P+D6j/4QVgrz+eKuy1fBhHEZXIZFbWrJgqQaoNCs=;
        b=d9szMreOjcvVNqqj1SeVWBzhaKOkpv1ZwRrNqZ/jGxI7deTl1c/TqFFMEpJDoaoyBG
         dkHxM4hSxVVdRofdIv2CothUloeuLfrlRrwqe3oRGkGK9ggEErnBM065/5gdmo23BbKs
         pw/KvU/SkfTD/2l7Iv/WTC0l0hS+wDPi4kDJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Yhlxm46QnypPk3c5qIznNtlPFQIR05P8abx58QiXyIkZZmX3mm1lw859+TmPHnN3i1
         RUMoErnN4U5RpPtZQ0XhvPkHm9jvLEVu8Ao7URCZ4jPhAgR7Z39qVgHy14CoTc2drgGr
         H3tp28iK/4kWRojAkCPFH47GvooHQL6UdO7zg=
Received: by 10.216.19.130 with SMTP id n2mr1155071wen.151.1239478928823; Sat, 
	11 Apr 2009 12:42:08 -0700 (PDT)
In-Reply-To: <7veivzdmed.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116339>

On Sat, Apr 11, 2009 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Dan McGee <dpmcgee@gmail.com> writes:
>
>> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
>
> Empty log message?
>
> I am scratching my head because this came as a reply to:
>
> =C2=A0 =C2=A0...
> =C2=A0 =C2=A0> This I have absolutely no issue with.
> =C2=A0 =C2=A0>
> =C2=A0 =C2=A0> Acked-by: Nicolas Pitre <nico@cam.org>
>
> =C2=A0 =C2=A0I do not have problem with the wording either, but then =
the commit log
> =C2=A0 =C2=A0message needs to change, I think. =C2=A0Care to re-submi=
t?
>
> and your original read quite nicely:
>
> =C2=A0 =C2=A0Subject: [PATCH 2/2] pack-objects: report actual number =
of threads to be used
> =C2=A0 =C2=A0Date: Sat, =C2=A04 Apr 2009 11:59:56 -0500
> =C2=A0 =C2=A0Message-ID: <1238864396-8964-2-git-send-email-dpmcgee@gm=
ail.com>
>
> =C2=A0 =C2=A0In the case of a small repository, pack-objects is smart=
 enough to not start
> =C2=A0 =C2=A0more threads than necessary. However, the output to the =
user always reports
> =C2=A0 =C2=A0the value of the pack.threads configuration and not the =
real number of
> =C2=A0 =C2=A0threads to be used. This is easily fixed by moving the p=
rinting of the
> =C2=A0 =C2=A0message after we have partitioned our work.
>
> =C2=A0 =C2=A0(pack.threads is on autodetect and would be set to 4)
> =C2=A0 =C2=A0$ git-repack -a -d -f
> =C2=A0 =C2=A0Counting objects: 55, done.
> =C2=A0 =C2=A0Delta compression using 2 threads.
> =C2=A0 =C2=A0Compressing objects: 100% (48/48), done.
> =C2=A0 =C2=A0Writing objects: 100% (55/55), done.
> =C2=A0 =C2=A0Total 55 (delta 10), reused 0 (delta 0)
>
> =C2=A0 =C2=A0Signed-off-by: Dan McGee <dpmcgee@gmail.com>
>
> I was expecting to see something with a similar structure. =C2=A0An u=
pdated
> title, an introductory text and the problem description, and the
> description of the solution. =C2=A0Then "Acked-by:" you already recei=
ved.
>
> The new title looks correct, the problem description from the origina=
l
> should still apply, but the solution is different, and that needs to
> change.
>
> I've committed it like this:
>
> =C2=A0 =C2=A0Author: Dan McGee <dpmcgee@gmail.com>
> =C2=A0 =C2=A0Date: =C2=A0 Thu Apr 9 10:45:39 2009 -0500
>
> =C2=A0 =C2=A0Update delta compression message to be less misleading
>
> =C2=A0 =C2=A0In the case of a small repository, pack-objects is smart=
 enough to not
> =C2=A0 =C2=A0start more threads than necessary. However, the output t=
o the user always
> =C2=A0 =C2=A0reports the value of the pack.threads configuration and =
not the real
> =C2=A0 =C2=A0number of threads to be used.
>
> =C2=A0 =C2=A0Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> =C2=A0 =C2=A0Acked-by: Nicolas Pitre <nico@cam.org>
> =C2=A0 =C2=A0Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Thanks.

Sorry about that. I felt like the patch was a lot more
self-explanatory now, since it was a text change and not a behavior
change. It was my fault for forgetting the Ack.

-Dan
