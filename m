From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: NO_REGEX defaults on obscure platforms
Date: Wed, 08 Sep 2010 10:20:08 -0700 (PDT)
Message-ID: <m3hbi0m9uw.fsf@localhost.localdomain>
References: <AANLkTimYY_KHwqWWXTxFqW67FHYtJJkLuA-6WVc6wzO5@mail.gmail.com>
	<HYj6Cf-QUJiUlQ7fPRq5qJw3IurvsqhLa1qIg9c6ajPY6g_B2-OehA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Gary V. Vaughan" <gary@thewrittenword.com>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Robert Schiele <rschiele@gmail.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Sep 08 19:20:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtOJm-00081K-Vq
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 19:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab0IHRUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 13:20:14 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51868 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0IHRUM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 13:20:12 -0400
Received: by wwj40 with SMTP id 40so309155wwj.1
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 10:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=fXvhUAwRWiET8q61xgFrXnriATzWmL817ZAw0DukC/o=;
        b=PsC6Q1Jg2488P7QSQakwI+GqN+REZG6DXdAGIvIUHGov0gGky+Hp+rT0riR4IcOxul
         SrlXgnNcLyWV+fr+hpiTw4b76hdlJXkcXEesMYybjRgyKce7RG3dFwicPcGdGUKpQsAh
         +oBYQgQZDGy6THVWSZ9fo7hsBarmQXFOhGE24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=jhOLcslio6fWHZ1Ofm6GsDWgYGhaWjTIVYKFy+QzJkh0qpFP1IPorGaVNId8FDAbQz
         ejuo6rxH5oe0Tenq3GA4bCXIujv1mpUsVmrC4k/EYwXtgBLF1fEGBvEFC37RL3B5SHOG
         hGLqzz+P5qsYJlve4LePxvCR74rZoGQg2tgNo=
Received: by 10.227.157.147 with SMTP id b19mr2460wbx.49.1283966411005;
        Wed, 08 Sep 2010 10:20:11 -0700 (PDT)
Received: from localhost.localdomain (abwu94.neoplus.adsl.tpnet.pl [83.8.244.94])
        by mx.google.com with ESMTPS id p52sm188237weq.20.2010.09.08.10.20.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 10:20:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o88HJum0016845;
	Wed, 8 Sep 2010 19:20:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o88HJK9l016833;
	Wed, 8 Sep 2010 19:19:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <HYj6Cf-QUJiUlQ7fPRq5qJw3IurvsqhLa1qIg9c6ajPY6g_B2-OehA@cipher.nrlssc.navy.mil>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155801>

Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:
> On 09/08/2010 10:12 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>> On Mon, Sep 6, 2010 at 07:41, Junio C Hamano <gitster@pobox.com> wro=
te:
>>=20
>>> There are a few leftover bits in 'next' that need to be merged to '=
master'
>>> before we declare a real -rc cycle, so tonight's pushout is -rc0.
>>=20
>> One thing that's almost certainly wrong in v1.7.3-rc0 is the NO_REGE=
X
>> defaults. It's a non-issue for people who run the configure script,
>> but the Makefile probably has the wrong defaults on some obscure
>> platforms.
[...]

>> Alternatively, just check for REG_STARTEND in regex.h (or the includ=
es
>> it pulls in):
>>=20
>>     $ grep REG_STARTEND /usr/include/regex.h
>>     #define REG_STARTEND (1 << 2)
>=20
> Unfortunately, IRIX actually defines REG_STARTEND in its regex.h, but
> the feature does not seem to work.  This also means the configure scr=
ipt
> will give a false negative and indicate that NO_REGEX should _not_ be
> set, when it actually should be.

Well, that just means that the test for NO_REGEX in configure.ac
should be more involved than just checking if REG_STARTEND is defined:
it should test if regex can truly handle null bytes.  There are some
examples of such test programs: see e.g. check for NO_C99_FORMAT
above.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
