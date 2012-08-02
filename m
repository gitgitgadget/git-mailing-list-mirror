From: =?ISO-8859-1?Q?Andreas_Gr=FCnbacher?= 
	<andreas.gruenbacher@gmail.com>
Subject: Re: GNU patch close to next stable release (2)
Date: Thu, 2 Aug 2012 22:02:12 +0200
Message-ID: <CAHpGcML5PVAgd9x75=5k1-ev+Px4V+26KJhhyZk-O54p0WxfxQ@mail.gmail.com>
References: <CAHpGcM+DkL_CCisCjF9m0j3NRJUNAdfL05T0cfLjLfVORQHrpw@mail.gmail.com>
	<7v8vdyfqa9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bug-patch@gnu.org, git@vger.kernel.org, bug-diffutils@gnu.org,
	Paul Eggert <eggert@cs.ucla.edu>,
	Jim Meyering <meyering@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:02:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx1bA-0004fU-2w
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 22:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab2HBUCO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Aug 2012 16:02:14 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58207 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752553Ab2HBUCN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Aug 2012 16:02:13 -0400
Received: by lahd3 with SMTP id d3so5536183lah.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1iT2MFEKzsNzumstfjewjepzsT6uXXSp8tovTl41nII=;
        b=EDvGb/a5fLRMf0xuAyIDBsrXh75hafkS28qQT8sLBNGX16T8W8oDamX0lqHLClANrr
         U4GytiucOHTV2eo7JeYzDxNtnVQKXU/JmkDknOns/iAWLvzbJ42V/tqMCTugjJEN/ZV0
         Zjih+A7geuU9L3Bu2ReTPQPPxsurNM7TOVNmryX92ZLUcqQsCcl2YdMuNJj3PgGoXY1Y
         q9g8F8E+5q6k0LCT66/ZDgsxo34td6t5X6jZt7MaG6g6ZHUDFb1B1ISojnazhnwqdybN
         +iiNb9wdkpm4AiLNbgwOt+BKYetmv8YEJD4tmsbfxeraCY7Xamc+G89+QLGInORq2gDU
         ti8A==
Received: by 10.112.43.67 with SMTP id u3mr10107642lbl.16.1343937732181; Thu,
 02 Aug 2012 13:02:12 -0700 (PDT)
Received: by 10.112.149.38 with HTTP; Thu, 2 Aug 2012 13:02:12 -0700 (PDT)
In-Reply-To: <7v8vdyfqa9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202788>

Junio,

2012/8/1 Junio C Hamano <gitster@pobox.com>:
> Andreas Gr=FCnbacher <agruen@gnu.org> writes:
>
>> * Support for double-quoted filenames in the "diff --git" format: wh=
en a
>>   filename starts with a double quote, it is interpreted as a C stri=
ng
>>   literal.  The escape sequences \\, \", \a, \b, \f, \n, \r, \t, \v,=
 and \ooo
>>   (a three-digit octal number between 0 and 255) are recognized.
>
> Is this also available in non-git diffs?

I have only enabled this for git-style diffs for now. GNU diff doesn't =
do
filename quoting so far and if it eventually implements a slightly diff=
erent
form of quoting (which I wouldn't recommend), we might be in trouble.

> IIRC, this extension to allow funny characters in pathnames was
> proposed by and discussed with Paul Eggert (listed as one of GNU
> diffutils maintainers at www.gnu.org/software/diffutils/) and git hap=
pened
> to adopt it earlier than "GNU diff" itself did.

Paul and Jim, any thoughts about adding filename quoting to GNU diff an=
ytime
soon, or about the format?

Thanks,
Andreas
