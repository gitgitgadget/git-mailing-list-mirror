From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Wed, 1 Sep 2010 16:06:51 +0530
Message-ID: <20100901103647.GA17260@kytes>
References: <1283334825-18309-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	robin.rosenberg@dewire.com, srabbelier@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 12:39:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqkj0-0002Ce-UU
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 12:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab0IAKjD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 06:39:03 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47994 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab0IAKjB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 06:39:01 -0400
Received: by pwi3 with SMTP id 3so708349pwi.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 03:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eU0gJcUIKcoyA8vna8yrLAttCY31Jzc8HpIR//ROlok=;
        b=mJt+t851T+kGREL4kVep9XFVFloiuI4GC6B1MDf2MF/gvXk6aMaauEQGMOIwk6GD0w
         Q6trosHUDIc6TQd8UnuOO4lWElzrtbo+1xlaTA4CMN06vtaY49a8c6QlS3wnaad4z+rm
         jefhAlGllbaejRaBVAZSYw127X2ZPMUcU6ZCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=a7xOFvYGxpI0TirPNuNhBPDkY95wSRQcCxz/hhM6WK2wgxbFZYSrouph9fmRcNiZQ3
         JEJkZ+aBRlEzwltqhYhYZKi1ZYOV0RyD/r4P1Ns4nVnpkfIQu4n+hhmHVSnfjBxhbB9+
         EUeCK+YWjJCk8njsTd34uHcaq268LE648hW5E=
Received: by 10.115.75.20 with SMTP id c20mr2400415wal.16.1283337540902;
        Wed, 01 Sep 2010 03:39:00 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id d2sm8198178wam.14.2010.09.01.03.38.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 03:38:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283334825-18309-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155037>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy writes:
> This bases on the original work by Robin Rosenberg:
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/73471
[...]

It might be more profitable to mention the Message-ID instead.
<1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>

-- Ram
