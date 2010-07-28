From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Thu, 29 Jul 2010 00:27:06 +0200
Message-ID: <201007290027.12443.jnareb@gmail.com>
References: <4C472B48.8050101@gmail.com> <AANLkTikx5EtQ0yvdkqN1Q1QAudFZfbd+_jpoa9ztLrz1@mail.gmail.com> <AANLkTikEo=Qw56WCxkFdmGqQcQoiTsnBy+Dt6zHpkOii@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: skillzero@gmail.com, Avery Pennarun <apenwarr@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 00:28:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeF6W-00074y-17
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 00:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756583Ab0G1W1l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jul 2010 18:27:41 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56514 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065Ab0G1W1a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 18:27:30 -0400
Received: by bwz1 with SMTP id 1so4200606bwz.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 15:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LiHkKArbe723cpkcZnRxq3roBafVf8OqRl5PwGUiB6I=;
        b=ke+Qf0aJi/hMU3maHU6Royv6UIIo90fizrGLaT5CCTQQ+WPOddefL7BNfFCWgXz+d6
         yiDDmPlgdm9H+P6PtoaUkNHw7Q3dU+kSmIGdV/LJiXYRy+Q8t061eOb2weUoR6egSxaR
         Lzknprq88qawwMO0HhPrq76lFE2n326l9i6CU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=imNIytOdulsTBfkSKMya7Ek1nCtI+CSVGazyknYQ1JS1iuRJamWNJi1QZ/S7SFZXK4
         B9iydj6yOyH/HeBDg8D7VzO7pp3/1Zcak8jWRzTdDZPvw8UcggtRicw1GK1IGrGWAhkC
         u9Wk486rxuB+5Tr5yt2EC87+QBtIay0fllFIU=
Received: by 10.204.143.19 with SMTP id s19mr8103180bku.181.1280356048933;
        Wed, 28 Jul 2010 15:27:28 -0700 (PDT)
Received: from [192.168.1.13] (abvz244.neoplus.adsl.tpnet.pl [83.8.223.244])
        by mx.google.com with ESMTPS id x19sm64586bkv.9.2010.07.28.15.27.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 15:27:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikEo=Qw56WCxkFdmGqQcQoiTsnBy+Dt6zHpkOii@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152123>

Dnia niedziela 25. lipca 2010 03:47, Nguyen Thai Ngoc Duy napisa=C5=82:
>=20
> By the way, how hard is it to use git-replace to implement narrow clo=
ne?

I don't think that git-replace should be used to implement narrow clone=
,
although it could probable be abused to do so.  The refs/replaces=20
mechanism is about static replacements...

--=20
Jakub Narebski
Poland
