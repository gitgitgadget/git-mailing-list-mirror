From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/7] t1302 (core.repositoryversion): style tweaks
Date: Wed, 8 Sep 2010 09:45:16 +1000
Message-ID: <AANLkTinSAqEYnrU=S9mEOztK+hVGvNNh7OQ-hHgyUwKJ@mail.gmail.com>
References: <4C85357A.8090000@web.de>
	<20100906190655.GG25426@burratino>
	<4C854B36.6010606@web.de>
	<20100907014135.GA1182@burratino>
	<20100907015227.GF1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 01:45:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot7r0-00079c-18
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 01:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758294Ab0IGXpU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 19:45:20 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62366 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756573Ab0IGXpS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Sep 2010 19:45:18 -0400
Received: by wwj40 with SMTP id 40so8891351wwj.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 16:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=plBGQK8qoX5EoF1g1SIhm9Ph5L3Ben2Q0i5vcDXbMSo=;
        b=Zk2OfVnyyNs584TcvuuMb+uMqtCPMA2qEwHfJFvEFxM/gn/bXuZGOUiPmMDsVNkyUR
         txU0BO5rfH9sUw7GN5OA+PdoMJtQjaWXdnZKJKbhuZaejwEfhU8Mbw0p60apqQwPFVc9
         pcPnsJBlMfl5c7mgOAYCJsbMAEMPtjdGOwZhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HBWQJajfjO9Coe2zgw9RSiQCxroT4TTSt4o8XeRzYENyueLXJkiEkKE2v8aYOPt1T4
         yK0OGcG9VhcTmJHClBoZi4j00RK+UNheYigKx2PM8zlZJqPfF5B81toOt6Sl/ltwqgW8
         YOt1y321M5w6apxvz1Qw/htNQtsBs+WGkWXF4=
Received: by 10.216.1.12 with SMTP id 12mr1423854wec.1.1283903117135; Tue, 07
 Sep 2010 16:45:17 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 7 Sep 2010 16:45:16 -0700 (PDT)
In-Reply-To: <20100907015227.GF1182@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155749>

2010/9/7 Jonathan Nieder <jrnieder@gmail.com>:
> This test is from 2007, which is late enough for the style to be
> recognizably modern but still a while ago. =C2=A0Freshen it up to
> follow new best practices:
>
> =C2=A0- guard setup commands with test_expect_setup, so errors at
> =C2=A0 that stage can be caught;
> =C2=A0- use <<\EOF in preference to <<EOF, to save reviewers the
> =C2=A0 trouble of looking for variable interpolations;
> =C2=A0- use test_cmp instead of test "$foo" =3D "$bar", for better
> =C2=A0 output with -v on failure;
> =C2=A0- indent commands in subshells and let them span multiple lines=
;
> =C2=A0- combine the two "gitdir required mode" tests that do not make
> =C2=A0 as much sense alone.
>
> Cc: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Looks good to me.
--=20
Duy
