From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] core.precomposeunicode is true by default
Date: Sat, 27 Jul 2013 22:23:52 +0700
Message-ID: <CACsJy8AT--3Lus-3F4-8EHL_3--a-98RkJxaMMALaSjgV+D3WQ@mail.gmail.com>
References: <201307270321.32398.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jul 27 17:24:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V36M7-0005J3-OZ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 17:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab3G0PYY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Jul 2013 11:24:24 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:64095 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab3G0PYX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Jul 2013 11:24:23 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so997021obp.36
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 08:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=hL41YzYVIQ8bAERJ6aA2anJtxowbsMEeDy7/d+asJ6Q=;
        b=sajb/6o/h7clEEOsYN4r62W+mLSIcO+uoCFDNhWULwew6YH6oJYgWszQ8m5sgNtYF3
         dvee0PB9z2LZy2AJtM+SYNwvVVj+XGsuXMrt/dhuovGPEnsWGs56JwYv0hyvE4F+OtUF
         ElGmt2aHroeUXx3Qybcdi7OhfW0syBTPRVs19Hy0VD1OdAw02c2lkxPg1OP8eog2Idds
         B4L9N3+vNoLM4euPQUN1rMARaCPFLO5z3t21u78dbaRaS/v+H2CjZELb5MkAnyJmlwYC
         ej2eabWWGrV8XEeqJJGhp3r6xaNM6RgI/SdDWOIVycqKjtC7fT6oNGPQF/jPeHSx9k4C
         jGoQ==
X-Received: by 10.60.45.138 with SMTP id n10mr52026602oem.101.1374938662948;
 Sat, 27 Jul 2013 08:24:22 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Sat, 27 Jul 2013 08:23:52 -0700 (PDT)
In-Reply-To: <201307270321.32398.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231248>

On Sat, Jul 27, 2013 at 8:21 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> When core.precomposeunicode was introduced, it was set to false
> by default, to be compatible with older versions of Git.
>
> Whenever UTF-8 file names are used in a mixed environment,
> the Mac OS users need to find out that this configuration exist
> and set it to true manually.
>
> There is no measurable performance impact between false and true.
> A smoother workflow can be achieved for new Git users,
> so change the default to true:
>
> - Remove the auto-sensing
> - Rename the internal variable into precompose_unicode,
>   and set it to 1 meaning true.
> - Adjust and clean up test cases
>
> The configuration core.precomposeunicode is still supported.

Does this have any effects on non-utf8 users? I'm on utf-8, so this is
not really my concern, that is unless it changes something on LANG=3DC.=
=2E
--=20
Duy
