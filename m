From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Make "terminator behavior" the default with --pretty=format: ?
Date: Tue, 22 Feb 2011 16:43:59 +0000
Message-ID: <1298393039.2286.14.camel@wpalmer.simply-domain>
References: <AANLkTimFYsG3x0uGX32Ozo6C_shHd4k8jnXNhYmy7Q80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Hrvoje =?UTF-8?Q?Nik=C5=A1i=C4=87?= <hniksic@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 17:44:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrvLQ-0004iL-S8
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 17:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431Ab1BVQoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 11:44:05 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53343 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725Ab1BVQoE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 11:44:04 -0500
Received: by wwb39 with SMTP id 39so413307wwb.1
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 08:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=00hu26xjm6P6XTnnv4maL6BPeSe+ygajj/51ZUTw3v4=;
        b=hwKb57WBIkQtQ9tVMZpt7cQELbhlOvwetrYqrqQj87jpk1CWhunDjWDM/ypVZB07SB
         BA8xdD+GXCFLRyyzPZxBkKpkZgDSUr/VJJZ1MKRmYTSWS3vH95eWZkalvoHPt8MTZD8e
         pJKqIEposrjQYWD7ULX6+fWr4JAF9iJ0tAdqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ibsVr01iuYVOwNhyb59qvCuSSAoXNzKclqtEtiDColtu075Blfp1fV4VF8ncjE//wN
         sTZgexTgkXI9I1DUCYCKQnSolXXTXh2onsIP7Lsr4k7AxdB85Edij3GmIklxK6654SPK
         +9vPJ1yOVmN8fDGUDkN+OCBxBOBoqKg7Wvh3M=
Received: by 10.216.179.144 with SMTP id h16mr2441628wem.64.1298393043109;
        Tue, 22 Feb 2011 08:44:03 -0800 (PST)
Received: from [192.168.2.64] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id r6sm2687134weq.20.2011.02.22.08.44.01
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 08:44:01 -0800 (PST)
In-Reply-To: <AANLkTimFYsG3x0uGX32Ozo6C_shHd4k8jnXNhYmy7Q80@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167562>

On Tue, 2011-02-22 at 16:43 +0100, Hrvoje Nik=C5=A1i=C4=87 wrote:
> Is there a reason, other than backward compatibility, for
> "--prety=3Dformat:" to have separator rather than terminator semantic=
s?
>=20

The "default behaviour" is the behaviour which occurs when one /doesn't=
/
specify something. For example: --pretty=3D"%H %an" uses terminator
semantics.

I agree that --pretty=3Dsformat: might be less ambiguous, though.
