From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 35/42] rev-parse: prints --git-dir relative to user's cwd
Date: Sat, 30 Oct 2010 11:42:49 +0700
Message-ID: <AANLkTinircf2H9GcqOym036o=av1dvNx9xDVOVXok6xt@mail.gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
 <1288334934-17216-36-git-send-email-pclouds@gmail.com> <AANLkTikO5N3JWYCJ0c8AQXra274NfAx9X0aUQTwsOGiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 06:43:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC3Hg-00011T-6O
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 06:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991Ab0J3EnM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Oct 2010 00:43:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60542 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab0J3EnK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Oct 2010 00:43:10 -0400
Received: by wwe15 with SMTP id 15so4231853wwe.1
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 21:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=k7TRI04eUC+M457/cJzAMqinaXS3naPXGkXphPmHXS4=;
        b=HGNaRriTPRFyElZQY72wKYnV1a9c8JyF1IiGSC3SNcoJFp4EZOrJHUELcag2ZHkwBF
         agmJtosT/46+m8kpn4aCTo/PAdv3mY/jjV7Lmbsgn+TUFC7xnwZn0Ho+3qFmKVO5/uCM
         B+/L0ndtoi8rCxPHnW/v24BVlVQpIlL34u00I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VvZc+iwZpF8taXALyMww4AXxBySKr7Mrs0ZlswYeNL5HGw/RrMwzkZghgAtCo2Bg92
         uL8ADdNrjGKUln2lvmL5kzfOWyOsLJPdDevZgusjFiqwJ1Fwx8VQ8Ydb+Jdb4ueezVX3
         nd8K8HWQ/MmqjhWBol6jQFo34iJqUCtllNup8=
Received: by 10.216.153.147 with SMTP id f19mr111018wek.40.1288413789470; Fri,
 29 Oct 2010 21:43:09 -0700 (PDT)
Received: by 10.216.135.77 with HTTP; Fri, 29 Oct 2010 21:42:49 -0700 (PDT)
In-Reply-To: <AANLkTikO5N3JWYCJ0c8AQXra274NfAx9X0aUQTwsOGiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160387>

2010/10/30 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> 2010/10/28 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:
>> git-rev-parse.txt does not say much about this. But I'm sure
>> git-sh-setup.sh wants "git rev-parse --git-dir" be relative to user'=
s
>> cwd.
>
> We don't usually use "I" in commit messages, was this meant for after
> the triple dash, or does this commit message just need work?

I used "I" because I was not confident that this must be done this
way. Perhaps after we agree that all users of "git rev-parse
--git-dir" expect the same, commit message can be rewritten to reflect
that.
--=20
Duy
