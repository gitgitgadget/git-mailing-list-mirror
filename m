From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/4] [PULL] ab/i18n-prereqs, prerequisites for ab/i18n
Date: Sun, 14 Nov 2010 11:50:11 -0600
Message-ID: <20101114175010.GF26459@burratino>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 18:50:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHgj3-0001VL-Hd
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 18:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590Ab0KNRup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 12:50:45 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60282 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434Ab0KNRuo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 12:50:44 -0500
Received: by gwj17 with SMTP id 17so676053gwj.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=G+fQvlheJpgE2lEa4xd1c/oy2ftrUHQlREn92MIuCYs=;
        b=aFdNavS67QOexRo72wnGAT0/Dpjeoc+R2dSk/ATp64D2JReGzK+wp+judEfDHzxMcx
         mxfWgpdvVxp/KEbvcVbZCMVBQ5f4PnPyYGy4bsV/THarKn85dHvc6umLkLw0H2jt+cuQ
         RgNeP7AsqHsPOc0Bm8SFJGLLng6TYTFvPCzis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Yw+1fulFkhkJYuax7Dr5OSbfgbyvHsY/cNLSBnAwztkMhC2yyEefJIFfamkn1+kHXC
         xfQoIwwP2w4oFbF1Oul6IMbA75uGzmUhRrShJlkojKmZMg8DYIb6AhC2Xa7JjgeTrZbw
         r1l7ez19LeQugsls5nIW4AwjQ9Pa0ykWF8Mlo=
Received: by 10.151.154.1 with SMTP id g1mr7900283ybo.180.1289757043656;
        Sun, 14 Nov 2010 09:50:43 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id i9sm3939839yha.42.2010.11.14.09.50.41
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 09:50:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289745857-16704-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161426>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> These are the first four patches in the ab/i18n series which aren't
> strictly related to it, but merely fixes to issues I encountered.
>=20
> I'm submitting these separately now in the hope that they'll make it
> to the next & master branches before ab/i18n. Having these separately
> reviewed should be easier for everyone.

Thank you!  Hopefully others can pitch in and extract more patches
like this from ab/i18n.

I've sent comments on all four patches.  I agree with the spirit
of all of them and would be happy to see them tweaked and integrated
soon (patch 2 does not even seem to need tweaking).
