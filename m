From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add --info-path and --man-path options to git.
Date: Mon, 2 May 2011 10:06:40 +1000
Message-ID: <BANLkTik-8WVsw-_P7=-pEiXFLeoQQRAVeg@mail.gmail.com>
References: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
	<7vbozmthhy.fsf@alter.siamese.dyndns.org>
	<20110501234833.GC11550@elie>
	<7v62puq8a5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 02:06:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGgf1-0005OC-5D
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 02:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978Ab1EBAGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2011 20:06:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50643 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab1EBAGl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2011 20:06:41 -0400
Received: by vws1 with SMTP id 1so3909080vws.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 17:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fx3wVk+EpjQKowBzLj4frio2bIFXUCqiqsqF74UYXNk=;
        b=cSmklwssjtSTArgNFbbZ9VvloHFORtqnPPPJKNUqsefllOdhPwZ9iS0HfqeM++H24+
         AOOzHY32SzgpJqSZ9I+bpMTkdlVGHogPXUdSVqeporeQ3DtqroXOBAUsofDqxTlpIvBb
         gxChY8WQnJkZq+gzv4PORRJrDvxM/kQM1RkJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jW+xacq7q1XGgehieDUYFRKDDRT5WF78oe83Ru1HW/4oVFViv0msuxrmC9fpGuuSeL
         W9yUHKMUuVIIin4/ioDGnqaMg1XrZ9ovBJtQO5x483bihQUq2ER021jZ39332uoQ7SJ1
         vcD0CldyfrV68mByX+aZJVslny+b1sxhU6q2s=
Received: by 10.52.99.98 with SMTP id ep2mr3280083vdb.159.1304294801077; Sun,
 01 May 2011 17:06:41 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Sun, 1 May 2011 17:06:40 -0700 (PDT)
In-Reply-To: <7v62puq8a5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172557>

On Mon, May 2, 2011 at 10:02 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> By contrast, man and info typically use standard search mechanisms:
>> man using $MANPATH and info using the dir.info file. =C2=A0The usual
>> interface to git's documentation through a man browser is not
>>
>> =C2=A0 =C2=A0 =C2=A0 man /usr/share/man/man1/git-add.1.gz
>>
>> but
>>
>> =C2=A0 =C2=A0 =C2=A0 man git-add; =C2=A0 =C2=A0# or "man git add" if=
 your man viewer supports it
>
> I think you are forgetting the case where the git-man-path the user u=
ses
> to install git may be outside /usr/share/man (e.g. $HOME/share/man). =
=C2=A0In
> such an installation, by setting $PATH to include your installed git
> binary (e.g. $HOME/bin), you should be able to say "git help -m git" =
to
> tell help.c to internally prepend $HOME/share/man to the $MANPATH bef=
ore
> it kicks "man". =C2=A0Does "man git-add" work without you knowing whe=
re that
> directory is (iow, without having $HOME/share/man on $MANPATH)? =C2=A0=
And if it
> does not, how would you learn what directory to add to your $MANPATH?
>
> Isn't that what this patch is solving? =C2=A0I am not sure where the =
similarity
> with the html documentation breaks donw. =C2=A0The same thing for inf=
o.

Good point. For non-distro installed installations of git, this would
be handy, even for read-only purposes.

jon.
