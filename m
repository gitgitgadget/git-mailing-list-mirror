From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH GSoC 1/3] gitweb: Create Gitweb::Config module
Date: Thu, 3 Jun 2010 18:59:38 +0200
Message-ID: <201006031859.39278.jnareb@gmail.com>
References: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com> <20100603152030.GD20775@machine.or.cz> <AANLkTikUmFA658jzd27cu1NmjJsV8T9Hkrd7z2WNY3R7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 19:00:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKDlt-00011b-Uu
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 18:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031Ab0FCQ7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 12:59:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53622 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224Ab0FCQ7s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 12:59:48 -0400
Received: by fxm8 with SMTP id 8so259419fxm.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 09:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LmHS5MLy4BRllzB0ojJtGNPcFeWuA/Eps9KDWWsW/DE=;
        b=ts6z3N3JsGv4eBzBZXgMbcjRGNbNGzYrnN/whxEZFUUuaRizqUuRaTYckOO7l7Lvdm
         UyEIqHO1Nvvk9GGse3ZOPQE5W6YmXYqe+0NRwzeTy5ojepGBVZ+Ew75opM0YVeD6liX6
         5094YvK3cCHgunMAWtGdguzSCskQRHd0UyX2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=U9yKJbuOwbr1vvbLosHN0JPxDJgMNGXTFZM76LOndj9wB/YTH6Z8QSCbQjAHvHYsn6
         DbZN6kCipoHQODkkxhw9faTP8ywsibACqBHpJNmnUNVxcrRfFnVsQKu7SeAY5bBPnU+W
         dc+LZIJGWigotwA4D2YjQdHVx6ahtG1hhmJWc=
Received: by 10.223.63.17 with SMTP id z17mr10598519fah.66.1275584387190;
        Thu, 03 Jun 2010 09:59:47 -0700 (PDT)
Received: from [192.168.1.15] (abvx149.neoplus.adsl.tpnet.pl [83.8.221.149])
        by mx.google.com with ESMTPS id r25sm940944fai.11.2010.06.03.09.59.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 09:59:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikUmFA658jzd27cu1NmjJsV8T9Hkrd7z2WNY3R7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148346>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Jun 3, 2010 at 15:20, Petr Baudis <pasky@suse.cz> wrote:
>> On Thu, Jun 03, 2010 at 07:25:54PM +0530, Pavan Kumar Sunkara wrote:
>>>
>>> +our @ISA =3D qw(Exporter);
>=20
> This is also re-arranging deck chairs on the Titanic, but 'use base
> qw(Exporter)' is nicer.

Or simply 'use Exporter qw(import);', as Perl 5.8+ supports=20
'use Module LIST' form.

--=20
Jakub Narebski
Poland
