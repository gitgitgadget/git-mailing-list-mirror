From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/6] Unify argument and option notation in the docs
Date: Thu, 21 Oct 2010 17:21:29 -0500
Message-ID: <20101021222129.GA13262@burratino>
References: <87fwwhszsf.fsf@gmail.com>
 <1286559080-27257-1-git-send-email-stepnem@gmail.com>
 <7v1v80wjuw.fsf@alter.siamese.dyndns.org>
 <8739sgtp8i.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 00:25:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P93Ze-0006DD-B1
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 00:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758539Ab0JUWZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 18:25:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57251 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab0JUWZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 18:25:17 -0400
Received: by gyg4 with SMTP id 4so79039gyg.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7p5C/zsS4Cmqgib6tcJ5HJDjsS42pQfQhN2w+f0WVp8=;
        b=HRvlx2nlvASLeemX7ZSD2sxcWny/mIo31CEB6z/gonpBAqyzU78pIsZesNk9ekOAPL
         DWijdnq3TI3yMxdJROR5lQNeeMtdgiu9vPdca4w31gRvPAw1yQFrMHf0CUQQ1IEfJgro
         p7wFCG2xdPj2MTyljPtBXGme2FDdGQEMCdhP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YAc61/eQhqIfz3ROduv5432+WHtxLxbopG1VD0fFsyZ8+VhHsPmjEhzg6yd8ZVl42a
         Ut8tcYjQKdr7Gew8uW0KhnMJL+RpYt2oNY92JAri/Pb2S8SAqtrLfbdhl+/lzEHi/Abn
         qwlKuDFB8RaxCiM/v7EKZf01u5RL9KA3IxbdE=
Received: by 10.42.215.68 with SMTP id hd4mr1098086icb.372.1287699916843;
        Thu, 21 Oct 2010 15:25:16 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id y14sm811303vch.28.2010.10.21.15.25.14
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 15:25:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8739sgtp8i.fsf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159581>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec wrote:

> :-) I was actually considering just that, so I'm glad you mention it.
>=20
> I can try to compile an initial version of such a document, based on =
the
> commit message of the original single-patch version
> (<http://article.gmane.org/gmane.comp.version-control.git/158467>) an=
d
> including some more cases/examples.
>=20
> Where do you think would be the most appropriate place for it?
> Just add a section to CodingGuidelines, or a separate
> Documentation/WritingGuidelines or something?

Sorry for the slow response.  Documentation/CodingGuidelines makes sens=
e
to me, since it affects the usage strings in code.
