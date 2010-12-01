From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCHv2 3/3] cvsimport.txt: document the mapping between config
 and options
Date: Wed, 1 Dec 2010 10:02:40 -0500
Message-ID: <AANLkTimEU8RhhaJkv6WdKw3V-6stptRA0Z5SYbLxXNAR@mail.gmail.com>
References: <4CF2ADC9.8020504@drmicha.warpmail.net> <317523448870044a68311f811b42bd9461b90d43.1290973138.git.git@drmicha.warpmail.net>
 <7v7hfv3mli.fsf@alter.siamese.dyndns.org> <4CF4AE49.7090406@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 16:03:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNoD9-00076t-OU
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab0LAPDD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 10:03:03 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab0LAPDC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 10:03:02 -0500
Received: by iwn35 with SMTP id 35so29941iwn.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 07:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ejp49Cml9lSVZoFq54Jh8IhcIoh2kk1BagKm1JFNRTM=;
        b=u7OkfyTNywFUwEjFUSE7mwrXyI3v1SndHzfaAJid69tqzhEcrEw8W6yl7F2+HtnL2K
         41Uma4SsLyY9pXfiuHyk+lUZPqjxYebT7r0P6/MHX1PnIhyxd0Y1pz6A5Sdx9WIP2Jkq
         Pe4tu+1MwhW/a+mDHEd1/vsqBVg60sUQInDaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Phg95B/i41Q+D839T9xtQ14VQ3nRJrk4KJrdkQPYSCusZ06EGLehSyJlrQW4ipD/+k
         KsV8DQFCrUihVNLl/rSoU3qjfqZesVwMUpLs0cUQuK+uReB3CUiJoiJA1i9/S/4TRX9x
         00BAL3VuMrnA9GdVpnTkAp+gJ+GHWMgMcZ6MM=
Received: by 10.231.10.193 with SMTP id q1mr8918113ibq.70.1291215781289; Wed,
 01 Dec 2010 07:03:01 -0800 (PST)
Received: by 10.231.33.1 with HTTP; Wed, 1 Dec 2010 07:02:40 -0800 (PST)
In-Reply-To: <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162527>

On Tue, Nov 30, 2010 at 8:43 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> [cvsimport]
>> =A0 =A0 =A0 r =3D origin
>> =A0 =A0 =A0 capital-r =3D yes
>
> I think we can live with that. =A0If it is easier to implement, that'=
s very
> good.

Sorry, had not seen this discussion. Though I will obviously defer to
you guys, I don't like it -- not short term, not long term.

Short-name opts should not auto-read from git-config -- it's a misfire.



m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- School Server Architect
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff
