From: Norbert Thiebaud <nthiebaud@gmail.com>
Subject: Re: libreoffice merge issue ...
Date: Mon, 14 Feb 2011 11:33:24 -0600
Message-ID: <AANLkTi=SVDBgVYZpPUrCnKZyAaos=VKCLTvP4Bm7_Mk0@mail.gmail.com>
References: <1297699635.31477.253.camel@lenovo-w500>
	<4D5965CC.4030706@hupie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: michael.meeks@novell.com, git@vger.kernel.org,
	kendy <kendy@novell.com>
To: Ferry Huberts <mailings@hupie.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 18:33:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp2Ik-0003xe-4B
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 18:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264Ab1BNRd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 12:33:26 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65499 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab1BNRdY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 12:33:24 -0500
Received: by iyj8 with SMTP id 8so5036418iyj.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 09:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2/+C9t8vHxnDgXpEuJvBefXgqFi6X5vxzys4F/6ROo0=;
        b=D/+OzH6rxm+XvF0/ptJLLVnLIKuKOxoC3sHqA2vX/yc2lkUGQhdu7VkmW+OanhLgu1
         knj1tPZLfeQfScRyqxSFFVR//XKdA8cCHxknfaElLbwYwN8J4++G2cJxJVqYka3RfGfa
         ITTg/+p38Hnj0f1GZSgbCHIthSde8lRRv9noY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l+HrPLX2HQTJ4J3/3WxdtNIMeKc2E7c2QqbeTENsowQamSrbd9ohtVIFBDT5peIr3w
         Z0ESF7OuuBHJ+Wr1X5otvT/VI2zFMCzs96lF9oyMNs9+HkfWk2oGLl+/bN4aKcxsJ99x
         jnPQggECEvUEDcfLZfkCoO6Kk42Y4OshK+3U4=
Received: by 10.42.222.66 with SMTP id if2mr5279255icb.487.1297704804314; Mon,
 14 Feb 2011 09:33:24 -0800 (PST)
Received: by 10.231.14.132 with HTTP; Mon, 14 Feb 2011 09:33:24 -0800 (PST)
In-Reply-To: <4D5965CC.4030706@hupie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166741>

On Mon, Feb 14, 2011 at 11:26 AM, Ferry Huberts <mailings@hupie.com> wr=
ote:
>
>
> On 02/14/2011 05:07 PM, Michael Meeks wrote:
>> Hi guys,
>>
>> We are having quite some fun merging git branches with LibreOffice, =
and
>> I stumbled over this just now with master git with hash:
>> 00e6ee724640701b32aca27cc930fd6409c87ae2
>>
[...]
>> =A0 =A0 =A0 yields:
>>
>> @@@ -147,11 -147,7 +147,15 @@@ SvToken & SvToken::operator =3D ( con=
st S
>> =A0 ****************************************************************=
*********/
>> =A0 void SvTokenStream::InitCtor()
>> =A0 {
>> ++<<<<<<< HEAD
>> =A0+#ifdef DOS
>> =A0+ =A0 =A0SetCharSet( CHARSET_ANSI );
>> =A0+#else
>> =A0 =A0 =A0 SetCharSet( gsl_getSystemTextEncoding() );
>> =A0+#endif
>> ++=3D=3D=3D=3D=3D=3D=3D
>> ++ =A0 =A0SetCharSet( gsl_getSystemTextEncoding() );
>> ++>>>>>>> stage/premerge/dev300_m98
>
>
> this is the annotation of the conflict

The point is that there should not have been a conflict to start with.
git 1.7.3.4 agree that there is no conflict.

Norbert

>
> grtz
>
> --
> Ferry Huberts
>
