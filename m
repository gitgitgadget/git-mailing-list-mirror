From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: Re: Is there some env variable like GIT_LANG (like LANG)?
Date: Mon, 21 Mar 2011 21:30:38 +0100
Message-ID: <AANLkTikXsYONY5rUSF5138bQ=R4gCopOO8fu=3np+c98@mail.gmail.com>
References: <4D879E11.6040609@dirk.my1.cc>
	<7vipvcp8e3.fsf@alter.siamese.dyndns.org>
	<4D87ABA5.1030609@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:30:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1lkT-0003Vl-F8
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 21:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab1CUUal convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 16:30:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53860 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab1CUUak convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 16:30:40 -0400
Received: by bwz15 with SMTP id 15so5342143bwz.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e6EoKKfp6ZFX0abokX7QT8jYWlsopSlv6ef9M78hNZw=;
        b=KdWUwwWfXQXIW4ptXBtCFQ8arpsfzuMuwaxoXh3UsfGlPyNQ2xWdGPmHcfx4UL4TPj
         Ql46rdkCG9zpP1JVyDwzhy+byWaaM+m9V2DS84zo8Xkf6a0LMoU3NWz2xMzi7WAYmCXe
         ayomt3cz4MS06t6a0l4nisimWTTtAj33SQIYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lCYFDLzWMHyflyN43vJQHLOltr1lMkHYMlz/puO593/OX8/a5z8YqpWnYQLTyF2wyk
         yBoE1ZFLBxAFNXL4jC46SO+PVqhYoT4gIWseHafDLv3cGdsP5bL2VhWZpuvUAlspRJGr
         VivfIam5j+/UNBuUkFdTsV50jbY39Mi4ysc6Y=
Received: by 10.204.166.66 with SMTP id l2mr4104022bky.6.1300739438452; Mon,
 21 Mar 2011 13:30:38 -0700 (PDT)
Received: by 10.204.114.207 with HTTP; Mon, 21 Mar 2011 13:30:38 -0700 (PDT)
In-Reply-To: <4D87ABA5.1030609@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169664>

2011/3/21 Dirk S=FCsserott <newsletter@dirk.my1.cc>:
> Am 21.03.2011 20:43 schrieb Junio C Hamano:
>>
>> Dirk S=FCsserott<newsletter@dirk.my1.cc> =A0writes:
>>
>>> What would you think of it?
>>
>> Strongly negative. =A0I don't want force people to set GIT_LANG HG_L=
ANG
>> CVS_LANG and 47 different FROTZ_LANG environment variables.
>>
>> I would rather just set LANG=3DC LC_ALL=3DC in the terminal I use gi=
t in and
>> leave everything else in whatever locale the rest of the system is i=
n.
>>
>
> Ok. Accepted. Was just a question. I see your point.

Alternatively, you might like something like the following in your .bas=
hrc:

function git
{
    LANG=3DC command git "$@"
}

--=20
/Lasse
