From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] t/t5800: skip if python version is older than 2.5
Date: Tue, 17 Aug 2010 19:10:49 -0500
Message-ID: <AANLkTim+YQHxkY6WWF4Yfo74jZnAE8ufdnabp9mneBgu@mail.gmail.com>
References: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
 <injaoVtrfs7Li4aYBNxEQeawf3YbhxcYbL79Jvef2ML9502YRtjqEol2RVKBzXfH_PfbMep0lvU@cipher.nrlssc.navy.mil>
 <AANLkTimwNBAKwhKwsquDS4k3x0_iDo3rEyqFfhMcsb38@mail.gmail.com>
 <20100817232838.GH2221@burratino> <AANLkTim77g+z3KXyCOy4G-caCncyFa0FfqPMFatZnwLN@mail.gmail.com>
 <20100817233717.GJ2221@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 02:11:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlWFR-0004Rq-4v
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 02:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab0HRALM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 20:11:12 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44813 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab0HRALK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 20:11:10 -0400
Received: by ywh1 with SMTP id 1so4615ywh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kZZtnxSF/9u0ZiSYIBbQub1zKAw0d0AndsRYtZ3Ba2c=;
        b=NWAvUozY+lqa8MJ5EPSiDmykbv/VK6MMYi3wNtdT3PEUdYMhodv3mPGUl9eyoPUCNQ
         1/oX5AlLs61FwRNqmgiJnUQv5mKwo1JG8BXW++4lhAMhyh6Icw32kuge2afFMVa47tub
         9mAHalC7JwWghzwL3VYEFkhnT/mTy6kKYbslw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=B6OQ5jZ2+HnLDhQ9aV6broepGvVyY1SEy9XO7afkGTRvBj7UNDU0lIEzJVaitLlRww
         a/7NUGuNgvpCRz79P2dm9oN+8JNUpw1ZuRax0wAj/Ghn0PG0xF40q98uzKBIFEnReKiA
         bhHklegu4zTeD1jKnEe7XmKuZS+zcVdKMdWK4=
Received: by 10.150.2.19 with SMTP id 19mr7948793ybb.53.1282090269171; Tue, 17
 Aug 2010 17:11:09 -0700 (PDT)
Received: by 10.150.98.8 with HTTP; Tue, 17 Aug 2010 17:10:49 -0700 (PDT)
In-Reply-To: <20100817233717.GJ2221@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153799>

Heya,

On Tue, Aug 17, 2010 at 18:37, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> I see. =C2=A0Maybe this is fixed by v1.7.2-rc0~33^2~1 (Makefile: add
> PYTHON_PATH to GIT-BUILD-OPTIONS, 2010-06-09) from later in the
> same series.

Ah, correct. So that should have gone before this one. It works if I
check out and build that one. Thanks.

--=20
Cheers,

Sverre Rabbelier
