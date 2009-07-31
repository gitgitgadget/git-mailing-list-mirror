From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: Fri, 31 Jul 2009 13:11:36 +0200
Message-ID: <40aa078e0907310411k54dc58fbq9a938c489df56b68@mail.gmail.com>
References: <20090726232154.29594.qmail@science.horizon.com>
	 <20090731104602.15375.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 13:12:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWq25-0001rR-4B
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 13:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbZGaLLj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 07:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbZGaLLi
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 07:11:38 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:52953 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbZGaLLi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 07:11:38 -0400
Received: by bwz19 with SMTP id 19so1125344bwz.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jpqlTlxMcgfrQT8cD3t1wdzM7jiR7Iyg7t4CouCpAEo=;
        b=xlG45xzQYjmhU0xRvyKI1HIAon8ByuzGOEqxISMQ+8VTKDPmfPBcftU/vGGQdYnNdO
         Al+HJTu5muNss6ohlWmDE6KmwzX2CPlnHvHnAhetkN1lgPGdILYqUMJoE2Ov4Vo7b9H0
         mUSL/OZVjYK4tOiFPigpDY54ehzahdCWJXTeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SMuvMWl4uMSfCcs/Gs42fMQ+jDky85XpzSf9nvVw37uATzvNLxoCj4gYAjG/xeL6hQ
         cByXrVAeWKlw+ge2RWd63kcu9+mPypfd2fPLZprkjdowHFumebWoTcpbzJZT6CrIyb6G
         ZWazoqri5ABVuHqLCyiQns27Ucmi0tcYvX9n8=
Received: by 10.204.60.194 with SMTP id q2mr2641554bkh.150.1249038696394; Fri, 
	31 Jul 2009 04:11:36 -0700 (PDT)
In-Reply-To: <20090731104602.15375.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124542>

On Fri, Jul 31, 2009 at 12:46 PM, George Spelvin<linux@horizon.com> wro=
te:
> I haven't packaged this nicely, but it's not that complicated.
> - Download Andy's original code from
> =A0http://www.openssl.org/~appro/cryptogams/cryptogams-0.tar.gz
> - Unpack and cd to the cryptogams-0/x86 directory
> - "patch < this_email" to create "sha1test.c", "sha1-586.h", "Makefil=
e",
> =A0 and "sha1-x86.pl".
> - "make"

$ patch < ../sha1-opt.patch.eml
patching file `Makefile'
patching file `sha1test.c'
patching file `sha1-586.h'
patching file `sha1-x86.pl'

$ make
make: *** No rule to make target `sha1-586.o', needed by `586test'.  St=
op.

What did I do wrong? :)
Would it be easier if you pushed it out somewhere?

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
