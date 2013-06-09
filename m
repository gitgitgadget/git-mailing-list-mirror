From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 16/22] git-remote-mediawiki: Modify strings for a
 better coding-style
Date: Sun, 9 Jun 2013 00:44:53 -0400
Message-ID: <CAPig+cT5YQb9ZTX=x0bSv6Y=stWpR77wKt0xt-CuFhMidc3Ocw@mail.gmail.com>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
	<1370641344-4253-17-git-send-email-celestin.matte@ensimag.fr>
	<CAPig+cT6Qw1w4x95oT7PctMz_HnpU0Vwv5Bh=n-uqZQWJjFnBw@mail.gmail.com>
	<51B394E5.8040104@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 09 06:45:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlXV1-0006Zj-KL
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 06:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974Ab3FIEoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 00:44:55 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:46059 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab3FIEoy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 00:44:54 -0400
Received: by mail-lb0-f172.google.com with SMTP id v20so893329lbc.17
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 21:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M3K/8ODJHQHmdlcrMzsIZ8mlGr5DX2/LAEOibXgkCtk=;
        b=qVDR1BQgj+56IFRhsW+JSopRPxp7ARIGj1doYdJXQMFpWuZLirxCrjVf1ToA41fC8e
         /BZlAzqIP4eCz9BZK3t6e2YxmaxPbeKPz0lkqQMh554M7JkqH4Z1BbTkfeNl8kNf6CON
         +c4PHT0/KL4D18F9HYCzVV8/5T6vfS3NxmLa7NWswn5VV5vciM3vjPuei2iu/417IJGN
         SOsnluG0/z2ITIe2U6ygqd1hYkBBV1PcROFySxdUT1HTXW1Mc2Fa5ruVBu3FhObPvlWU
         KyLwWrp+IuTxidmFGAlo6qEmA57e3gNPQkRqdZNuxGZLiM0rIkXi/MsAwq7JiM3GJwlY
         gM/A==
X-Received: by 10.112.89.226 with SMTP id br2mr4038383lbb.12.1370753093283;
 Sat, 08 Jun 2013 21:44:53 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sat, 8 Jun 2013 21:44:53 -0700 (PDT)
In-Reply-To: <51B394E5.8040104@ensimag.fr>
X-Google-Sender-Auth: 0wQ1vDMALG_gppiixG9AMnrFYyU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226880>

On Sat, Jun 8, 2013 at 4:32 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> Le 08/06/2013 02:39, Eric Sunshine a =E9crit :
>> On Fri, Jun 7, 2013 at 5:42 PM, C=E9lestin Matte
>> <celestin.matte@ensimag.fr> wrote:
>>> - strings which don't need interpolation are single-quoted for more=
 clarity and
>>> slight gain of performance
>>> - interpolation is preferred over concatenation in many cases, for =
more clarity
>>> - variables are always used with the ${} operator inside strings
>>> - strings including double-quotes are written with qq() so that the=
 quotes do
>>> not have to be escaped
>>
>> Distinct changes could (IMHO) be split into separate patches for eas=
ier review.
>
> This commit is a real pain to cut into 3 distinctive ones. Is this
> really necessary?
> I will do it if it is, of course.

[I think you meant that it would be split into 4 patches.]

The final decision is up to the submitter (you) and the people signing
off on and accepting the patch (Matthieu and Junio).

Speaking merely as a person reviewing the patch series, I can say that
mixing conceptually unrelated changes into a single patch makes review
more onerous since it requires repeatedly switching mental gears
(often from line to line or even within a single line). Patches
involving simple "mechanical" changes typically are easy to review,
even when the patches are lengthy. In this case, however, that length
coupled with the mental gear switching, makes the review process more
burdensome that it need be.

Even if you decide ultimately not to bother splitting the patch,
ease-of-review and one-conceptual-change-per-patch are useful notions
to keep in mind for future submissions.
