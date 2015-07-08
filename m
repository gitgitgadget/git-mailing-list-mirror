From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 01/11] t6302: for-each-ref tests for ref-filter APIs
Date: Wed, 8 Jul 2015 19:29:58 +0530
Message-ID: <CAOLa=ZQ=Mjx-L8Xn9kA86b7nv_bF24Mje1rU-Rmcq4kMqp8qMg@mail.gmail.com>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
 <1436285177-12279-1-git-send-email-karthik.188@gmail.com> <559CDAC1.8030600@web.de>
 <vpqwpybf25f.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 08 16:00:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCptq-0007Zd-7C
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 16:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934568AbbGHOA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 10:00:29 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34000 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934509AbbGHOA2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 10:00:28 -0400
Received: by obbkm3 with SMTP id km3so150804689obb.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=U24b7MoLkh4UvMj/BDpDqmgtZTS/b7mLuaxT6mXfl0U=;
        b=mQB7xg5haCstL6dSqT6dJGBfiYLs3CV6Qe734/OmH3oS+XtEK+XJeA5BLIfPi8PO87
         3EUlQkp9Kr2xti52G8w1O6NKwB97cUC/0uJn0s+1VjCDad/4SdsXME1R3dQPVIN3i55p
         sIGbcEQbg+jZ0knWJ0CIIcCxwLR7mi6DkrMe8/fnXXSbeXxo7sXESs3G1RUO9Sv3r318
         v7AD7b4ANPRsJa1RYafq4guLeBjqTO7i9poA4qR/mEAOv7Mn9cIP4DQAZI0RW99zXNoI
         XWMC7FOG91IgsSsTkU1JEb6fjzex5zY1gohs7X+nZ680aCALs8HGl/RGu03WqBGmsKO4
         JA/Q==
X-Received: by 10.182.29.68 with SMTP id i4mr9525880obh.57.1436364027776; Wed,
 08 Jul 2015 07:00:27 -0700 (PDT)
Received: by 10.182.95.174 with HTTP; Wed, 8 Jul 2015 06:59:58 -0700 (PDT)
In-Reply-To: <vpqwpybf25f.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273687>

On Wed, Jul 8, 2015 at 2:37 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> Could we have a tweak for people without gpg?
>
> I guess we need stg like
>
> if ! test_have_prereq GPG; then
>         skip_all=3D'skipping for-each-ref tests, gpg not available'
>         test_done
> fi
>
> since we need GPG in the setup test and almost all other tests will r=
ely
> on it.
>

Does this need to be there? I see a lot of test files which need GPG, a=
nd since
this test file contains tests which rely on it, without it, it would
be kinda useless
anyways?

--=20
Regards,
Karthik Nayak
