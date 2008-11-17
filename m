From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fixes to gitweb feature check code
Date: Mon, 17 Nov 2008 11:48:03 +0100
Message-ID: <200811171148.03649.jnareb@gmail.com>
References: <1226759165-6894-1-git-send-email-giuseppe.bilotta@gmail.com> <200811171028.19807.jnareb@gmail.com> <7vskpqzms5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 11:49:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21fb-0001tZ-Sn
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbYKQKsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Nov 2008 05:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbYKQKsN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:48:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:64163 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835AbYKQKsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:48:12 -0500
Received: by ug-out-1314.google.com with SMTP id 39so366845ugf.37
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 02:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kiyPcU3aqrBk+wzpmuMhtOBjjbMFO70393NyQXfhEQU=;
        b=rQI5xyw+G1vTQ8ls65RFDtUnxGQsIyvAg/vIxU7q5/uFrsVqq6XAMy1hjbvicQepgt
         KOLl4h9sobarTKupUBTLlTlEaNCGh8vwcHXzXdID8ekGa/0YCOX/8sNOgaU+GQmMT3TZ
         UhnTZPwtd8MkGeEo25E6fOwbiPaDOcg+53sTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JgPnLH9WJM0UUgMK/gCYn8osxUHtOc4leg41u0x0qGZo1GIk5yyhJnv03pWfuQenQK
         1f2YVn8BaDp4Jn2ZIK4eAJFOn0GOEjjYTZFyop1t14hfS9NJQ4XsmbDEcBCSKhtn3bGg
         NvkA2f22ScfeJiu0pb6KVmGs51LYcDO3K+L58=
Received: by 10.67.19.17 with SMTP id w17mr1218872ugi.0.1226918889142;
        Mon, 17 Nov 2008 02:48:09 -0800 (PST)
Received: from ?192.168.1.11? (abwi102.neoplus.adsl.tpnet.pl [83.8.232.102])
        by mx.google.com with ESMTPS id e1sm3831798ugf.7.2008.11.17.02.48.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Nov 2008 02:48:07 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vskpqzms5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101215>

On Mon, 17 Nov 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Dnia poniedzia=C5=82ek 17. listopada 2008 07:10, Giuseppe Bilotta na=
pisa=C5=82:
>>> On Mon, Nov 17, 2008 at 2:02 AM, Jakub Narebski <jnareb@gmail.com> =
wrote:
>>
>> [...]
>>>> First, you forgot the signoff, but you have addressed that already=
=2E
>>>>
>>>>
>>>> Second, I thought at first that it would be good for the patch to =
also
>>>> simplify %feature hash, using "'default' =3D> 1" instead of curren=
t bit
>>>> convoluted "'default' =3D> [1]", at the cost of bit more code for
>>>> defensive programming.  But now I think that if it is to be done,
>>>> it should be put as separate patch.
>>>=20
>>> Is this an ACK? 8-D
>>
>> I'm sorry. Yes, it is.
>=20
> Are you sure, even with those unnecessary changes from list context
> assignments to scalar ones?

Well, on one hand this change is not _necessary_, as it would work
without it. On the other hand it feels like cleanup (like e.g. using
tabs to indent but spaces to align, or word-wrapping too long lines).

So I think I'll pass the ball to you... your call ;-)
--=20
Jakub Narebski
Poland
