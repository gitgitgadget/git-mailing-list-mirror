From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: smtp server on windows
Date: Sat, 04 Sep 2010 17:15:29 +0200
Organization: Home - http://www.obry.net
Message-ID: <4C826291.6080606@obry.net>
References: <4C8251A0.1020809@obry.net> <AANLkTi=5f3+g9HrssNKj99PHr_2ymxGWmM=NjHwc94j2@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 04 17:15:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OruSd-0005YH-2P
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 17:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab0IDPPM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 11:15:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58181 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab0IDPPK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 11:15:10 -0400
Received: by wwj40 with SMTP id 40so4196892wwj.1
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 08:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :organization:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=Std5The1kvYNxcJF6smRCBu8GpyQLcIAjN1a/NmmcnM=;
        b=T+em+AkVSbpe2EmNO7YKb3KQCMZm5+YsKH1/J5aFRxOb9fBRYKuXEiNyTNWMq/e3gc
         5nKiQ/4ZgNoZj9MwcEMtPl8IWru5JJkQaxkvBmuR9+5iJwRDd9lvmGQlSqTk1YgWLiMB
         jvYxV+l8mRLbH+kPoV4n/lRVYGwvjEZQjxfQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding;
        b=A/cd9rlOIohgSsvaGT2yGQB4qIgHcufDZY6LzboffChI6J7aMG0DNDIDFHXaQ3YaoP
         iq3AsTx1KKQQ35TR3YmRHgH2S8Cc4PYerj4NNPFx5vh9HjqxB2QuycGLH1TVdpVsui/l
         gMap/UcG48rgDBX8gw1EHQ3S/UBrcwuHNI97k=
Received: by 10.216.164.66 with SMTP id b44mr1104712wel.81.1283613309421;
        Sat, 04 Sep 2010 08:15:09 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
        by mx.google.com with ESMTPS id o15sm2044712wer.39.2010.09.04.08.15.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 08:15:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <AANLkTi=5f3+g9HrssNKj99PHr_2ymxGWmM=NjHwc94j2@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155332>

Le 04/09/2010 16:24, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason a =C3=A9cri=
t :
> No, but you could modify this bit in git-send-email.perl:
>=20
>     } elsif ($smtp_server =3D~ m#^/#) {
>         my $pid =3D open my $sm, '|-';
>         defined $pid or die $!;

Ok, thanks for the quick answer and the pointer. I have zero knowledge
in Perl so I probably won't be able to do that. I'll see...

> Or, to make it work right now: just make a wrapper script.

Right, I wanted to avoid that.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
