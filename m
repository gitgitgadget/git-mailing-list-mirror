From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 3/8] gitweb: right-align date cell in shortlog
Date: Sat, 27 Jun 2009 14:49:52 +0200
Message-ID: <200906271449.52832.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <cb7bb73a0906261106n5e12948dydd02bd8d1b19a5e6@mail.gmail.com> <200906271414.53717.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 14:50:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKXMf-0005SZ-I5
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 14:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbZF0Mty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jun 2009 08:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754369AbZF0Mtx
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 08:49:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:58749 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbZF0Mtw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 08:49:52 -0400
Received: by fg-out-1718.google.com with SMTP id e12so187415fga.17
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 05:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qPubkeBYSIkiV+BukfIG7TKbcj53Co6A2T5WlxQLEZ4=;
        b=xnoylSS3ZLkffhuQRyF5zPZ2R6VQhLgRyHkjaGLCVf5NCcTzDaJ8FUYsL7A/yOhU5U
         jM4RwKMS1++BMJ7JJ1AOTqX4MnWiKHU6YjaZyONuJg2XXG76hEeU03xifVWkcg4dECh+
         uyzLr6d/JJs5sY4HhQ4HmwvMKDe86vFcKwCBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DjtlOJtS7nmEWKSrqwl+XV32Tnjw6VSqbGMbYBJpwBGqvQbzh7/NRKPR7TNnrMb4V3
         Wa5NX918yuiAM07LqWPhGFxrsfLLKDbt1J0IIn3bZKK5sNKdS79IevDP+428U82ZAe+B
         CAOFJEUEjlLtLCnGk0WD1DH89ACnEGBxiX3gw=
Received: by 10.86.23.6 with SMTP id 6mr101945fgw.19.1246106994783;
        Sat, 27 Jun 2009 05:49:54 -0700 (PDT)
Received: from ?192.168.1.13? (abwd106.neoplus.adsl.tpnet.pl [83.8.227.106])
        by mx.google.com with ESMTPS id 12sm2205965fgg.14.2009.06.27.05.49.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 05:49:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200906271414.53717.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122364>

On Sat, 27 Jun 2009, Jakub Narebski wrote:
> On Fri, 26 June 2009, Giuseppe Bilotta wrote:
>> 2009/6/26 Jakub Narebski <jnareb@gmail.com>:

>>> Last, and most important: I don't agree with this change. =A0In my
>>> opinion it does not improve layout (and you didn't provide support
>>> for this change). =A0Right-align justification should be sparingly,
>>> as it is not natural in left-to-right languages.
>>=20
>> Of course, in my opinion it does improve layout.

[..]
> Compare:
>=20
>   15 min ago
>   6 hours ago
>   10 hours ago
>   2 days ago
>   2 weeks ago
>   6 months ago
>   2009-06-12
>=20
> with
>=20
>     15 min ago
>    6 hours ago
>   10 hours ago
>     2 days ago
>    2 weeks ago
>   6 months ago
>     2009-06-12

It looks IMHO even worse if, because of limited screen width, 'date'
column needs to be wrapped.  See

  6 months
  ago

versus

   6 months
        ago

--=20
Jakub Narebski
Poland
