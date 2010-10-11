From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] Makefile: point out "make" if "make configure" fails
Date: Mon, 11 Oct 2010 17:06:53 +0200
Message-ID: <201010111706.55119.jnareb@gmail.com>
References: <4CB2FEB8.3050705@drmicha.warpmail.net> <1286800665-7437-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 17:07:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Jy7-00039b-1G
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 17:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab0JKPHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 11:07:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56181 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab0JKPHH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 11:07:07 -0400
Received: by fxm4 with SMTP id 4so470856fxm.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 08:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vmUDEwaB4wOcreis9H7p0sVcehTeaOqBoKX6c2TiTUM=;
        b=n+0P2hTDVdh3Qm+AGMCfkH4SxvqH/kytagmI9VdlBj3nDQcxQaCal2HdTvNQIbWc1b
         LbbYzKsi6VPuiFUCnAc8DO5CF4N7hIjsoPajw8PUp64C+OVcUN7mV06zqzfatK9L4r3Z
         RkKnTtvpuj7PmZzEMKh6kDLARLhcOW7tJr+FY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tEJahrogpdGOF7wxWghBKYKKDepHCm78vlXVAerAETgkizzUyvfk7bgKOpYIcZbbBb
         R0l+KMXHOODuTgMH9Qw+Qatlr+0kO8Xy5xoeGe1481qP8zj+20DCtc6bywSWSNvYmtEL
         YlZuHHzbEwkhyoRSod6aRglg7MhQxXGSQ8ASU=
Received: by 10.223.113.78 with SMTP id z14mr1978333fap.92.1286809625583;
        Mon, 11 Oct 2010 08:07:05 -0700 (PDT)
Received: from [192.168.1.13] (abvy23.neoplus.adsl.tpnet.pl [83.8.222.23])
        by mx.google.com with ESMTPS id m8sm3031134faj.11.2010.10.11.08.07.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 08:07:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1286800665-7437-1-git-send-email-avarab@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158764>

On Mon, 11 Oct 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Someone trying to build Git may think the need autoconf when "make
> configure && ./configure && make" fails. But actually they can
> probably just run "make" directly.
>=20
> Change the "make configure" output so that when it fails the user is
> informed of this:
>=20
>     make configure && ./configure && make
>         GEN configure
>     ERROR: We couldn't run autoconf for you. But you're in luck!
>     ERROR: Git doesn't actually need autoconf to build. Just try
>     ERROR: running "make" directly at the top-level. The Makefile
>     ERROR: will guess your configuration based on your OS. If that
>     ERROR: doesn't work try installing autoconf and running
>     ERROR: "make configure && ./configure && make" again.
>     make: *** [configure] Error 1
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

I like this.

--=20
Jakub Narebski
Poland
