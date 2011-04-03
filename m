From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 10/51] i18n: git-am core say messages
Date: Sun, 03 Apr 2011 10:33:04 -0700 (PDT)
Message-ID: <m3ei5j44wz.fsf@localhost.localdomain>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
	<1301849175-1697-11-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 19:33:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6RAo-0004if-PK
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 19:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab1DCRdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 13:33:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60776 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab1DCRdH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2011 13:33:07 -0400
Received: by wwa36 with SMTP id 36so5698938wwa.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=PrOu+EKak2YrhsJTxcH4/nms9QEb7gm00QM/+dXTMMQ=;
        b=TMKAmRU+aLK+hhY7uy307ro6dn25DWbbQIiL4T5hzlqcDdhaaSI3UXYLVOsfdc4fGA
         MEWW29f5qpxIPbxj4SvpFaUMYYoni3r5JKdrAthVqeVDbiVokDfWDDI5EYicC8t6lz+S
         7bPpo+gc+t10fcumsayccJWInv51vOg4mSg28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=pJ0LCj71igLa7gnJVcIax2e94yAaVmTVcjB3o3NgdHrXiugD33stFUtU9NG31X5sZb
         HEt6kD9x5oxftN8p4mQbHRYg7/N1iqQULJ1z8ESxBpBdY1ak2WRTucxFhrjPSBk+hWZj
         DIk+htjOgspK+Qpg/1pG4h6UkT8Vxhiv6ZvFw=
Received: by 10.227.59.210 with SMTP id m18mr591976wbh.112.1301851985976;
        Sun, 03 Apr 2011 10:33:05 -0700 (PDT)
Received: from localhost.localdomain (abwn202.neoplus.adsl.tpnet.pl [83.8.237.202])
        by mx.google.com with ESMTPS id e13sm2452568wbi.23.2011.04.03.10.33.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 10:33:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p33HWXs8006837;
	Sun, 3 Apr 2011 19:32:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p33HWDcp006833;
	Sun, 3 Apr 2011 19:32:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1301849175-1697-11-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170760>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> Make the core git-am messages that use say() translatable. These are
> visible on almost every git am invocation.
>=20
> There are tests that depend on the "Applying" output that need to be
> skipped along with this translation.


> -	say "Applying: $FIRSTLINE"
> +	say "$(eval_gettext "Applying: \$FIRSTLINE")"

> -			say No changes -- Patch already applied.
> +			say "$(gettext "No changes -- Patch already applied.")"

I guess that you canot simply make 'say' to do the translation because
one doesn't know if getext or eval_gettext is needed, isn't it?

--=20
Jakub Narebski
Poland
ShadeHawk on #git
