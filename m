From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: More git status --porcelain lossage
Date: Sat, 10 Apr 2010 19:39:59 +0000
Message-ID: <h2t51dd1af81004101239pe340cc54lcbb1a5b3702ec091@mail.gmail.com>
References: <20100409190601.47B37475FEF@snark.thyrsus.com>
	 <l2k5f14cf5e1004101148h5cf8dc4bm1836cf1c5fc8abfb@mail.gmail.com>
	 <20100410193039.GA28768@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Simon <turner25@gmail.com>, Eric Raymond <esr@snark.thyrsus.com>,
	git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Sat Apr 10 21:47:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0geF-0003UR-IE
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 21:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703Ab0DJTq7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 15:46:59 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:64309 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab0DJTq6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 15:46:58 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Apr 2010 15:46:58 EDT
Received: by bwz19 with SMTP id 19so36204bwz.21
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 12:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=N/2fmqb2YYnws6EcilwRyK3OfwIx/tYZoDTXRmmE7W0=;
        b=Dm0vPlTy6QrkTo7IdLYl8ZdpWhD9peRtB+7FiIoXwryYLIl68jrOxstPQrbU7KLb6O
         8ffD3AVaNugk6Bm2C2vidg/KkuR4XUrm20mTWpODbs/hUWa8Gnc3Pvd0I4ke9di3nDb2
         9rI4ejwU9P6aA9X/rUVJiOjGi0KuF7OFDzXjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HstAUhAxP/rNZIeLIYrOcfYmGyBVcdp98ApmRS0ZS2Moi5+za23K5X24kTTjk0uaqw
         zwbEmoJsTgPf0MZ6Bg0JNmL+frMiBXadHiueXwMRbiOlqnXZMSxgsx0HwzroMJl3SJIY
         N34pPo/bZ6CUxFfz7mfYaZPl/p0EMDLqv1pNE=
Received: by 10.204.121.195 with HTTP; Sat, 10 Apr 2010 12:39:59 -0700 (PDT)
In-Reply-To: <20100410193039.GA28768@thyrsus.com>
Received: by 10.204.6.193 with SMTP id a1mr2050809bka.104.1270928399785; Sat, 
	10 Apr 2010 12:39:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144584>

On Sat, Apr 10, 2010 at 19:30, Eric Raymond <esr@thyrsus.com> wrote:
> Simon <turner25@gmail.com>:
>> Why not use an XML output?
>> Plain text is easier to parse, but XML may give this extra durabilit=
y
>> you are looking for?
>
> Because XML is awfully heavyewight, and XML parsers tend to be slow.
>
> If we were going to buld on a metaprotocol, JSON would be better. =C2=
=A0IMHO.

A lot of web services (like some Catalyst-based applications) support
all of these equally. If Git had machine readable output like this it
would be nice if every git-* program just had --format=3D* where * coul=
d
be xml, json, yaml, sexp, perl etc.

The program would just construct a native datastructure and then there
would be an output driver to generate the textual representation.
