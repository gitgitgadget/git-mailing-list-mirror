From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for translation
Date: Thu, 7 Jun 2012 19:31:56 +0700
Message-ID: <CACsJy8A+FTjD3dzBWtL7X35YE9E3t0Gcx-DA6T_+Nt=X3Wp1jQ@mail.gmail.com>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com> <7vr4u23f0i.fsf@alter.siamese.dyndns.org>
 <20120529203759.GC22151@burratino> <CACsJy8AGKQHKx9XU+baUagcmi6Sc-=faNshpED=Q46JpV_31WA@mail.gmail.com>
 <20120602124440.GA28996@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 14:32:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScbtB-0006GE-Kv
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 14:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab2FGMc3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 08:32:29 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:48230 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652Ab2FGMc3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 08:32:29 -0400
Received: by weyu7 with SMTP id u7so318888wey.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZanVKhI8J+qwRzZ5B+MOBtcZ+U5+uu5Q0K9hOKckya4=;
        b=dm0sLbkxOdfW24kiNl2nKUe5qXdpUomno9TRkTh3w1N7JWLggecdFMSJllI1IPGEGZ
         1GYcUEyGll6BnnmsPOJmQJagiQimsTrqarz7QaBU1l+f6h3qSo+wKJ7PWqk5TiGl6sh2
         JBl3kk11DsamCBIEbck8AfvmTJO6PNjqbqODSpTQFkgaGlRYcc/SkaThnSqYHtSs6Gjt
         Ic1OgEFmiDy178SONrqZzupPDEkg7hG0phGPthtquFF/SIfZJK2a9tJQK/C1M2NucF1f
         K3hRDO0FnRWg/hIT/3Vy9O2jUXubFcu1c0lE3KL5PrIZC8AkzNOkoxpwlpvUJQCr60Wl
         kD5g==
Received: by 10.216.141.164 with SMTP id g36mr757245wej.119.1339072347965;
 Thu, 07 Jun 2012 05:32:27 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Thu, 7 Jun 2012 05:31:56 -0700 (PDT)
In-Reply-To: <20120602124440.GA28996@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199401>

On Sat, Jun 2, 2012 at 7:44 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Nguyen Thai Ngoc Duy wrote:
>> On Wed, May 30, 2012 at 3:37 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>
>>> At least "git archive --list" should probably be kept untranslated
>>> to lessen the translator workload a bit. =C2=A0Good catch.
>>
>> Should it?
>
> No, since to do so would break GETTEXT_LOG_UNTRANSLATED and it's not
> worth it. =C2=A0That looks like a great tool, by the way --- thanks f=
or
> finding it.

No changes to the series then. Junio, pu material perhaps? The
breaking gettext poison thing is different and I plan to kill gettext
poison soon (whether i succeed is another question of course).
--=20
Duy
