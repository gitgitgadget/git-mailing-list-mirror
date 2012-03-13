From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 2/2] Documentation/diff-options: reword description of
 --submodule option
Date: Tue, 13 Mar 2012 16:36:48 -0400
Message-ID: <CAFouetgSw7MMzHWOJox6DiPmBWD=6j4mST1KFZYsZyLmKHRrEQ@mail.gmail.com>
References: <1331665251-11147-1-git-send-email-tim.henigan@gmail.com>
	<1331665251-11147-2-git-send-email-tim.henigan@gmail.com>
	<7vipi8uv12.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 21:36:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7YSm-00069w-Uq
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 21:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab2CMUgv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Mar 2012 16:36:51 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58120 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2CMUgu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Mar 2012 16:36:50 -0400
Received: by eaaq12 with SMTP id q12so616516eaa.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 13:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UGTHsGKSrC0P7b4cDcoIcDk3Q9j9ApE2Zsw0ciUPips=;
        b=wqck2WphTOuwpB7+wEr7lcVeucu/XFEsdCcXSMG2lphByhgigU6aIYGSvpKE9tTf5W
         EswT5oo00WG14ppHhL0fcE+9t6+uiuoQ6/hCreWAduDD7iYuiKoTNA4W5LdAKLg+g748
         i8LWhWFAi2GYqM/aE9IyBL2cHIut2u1YbBQHzbtt2Dk9nw/OszVqWfmzIIZh36QKluS2
         0zz9aJM48tI7vp+J+gVTVmhLbjH8FpwgV6pCJW6XnRcxZmgTC7NwQdzn0bwVT27/eoQh
         6lkdvbZRQwVww3Ae7X/wCtCsk2LVvcy/LvMM9ujoinM5Y2nzBFCiHHHSez8ZYpVZRvbW
         Xc1w==
Received: by 10.50.153.166 with SMTP id vh6mr7010781igb.44.1331671008684; Tue,
 13 Mar 2012 13:36:48 -0700 (PDT)
Received: by 10.42.218.65 with HTTP; Tue, 13 Mar 2012 13:36:48 -0700 (PDT)
In-Reply-To: <7vipi8uv12.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193065>

>> =C2=A0--submodule[=3D<format>]::
>> - =C2=A0 =C2=A0 Choose the output format for submodule differences. =
<format> can be one of
>> - =C2=A0 =C2=A0 'short' and 'log'. 'short' just shows pairs of commi=
t names, this format
>> - =C2=A0 =C2=A0 is used when this option is not given. 'log' is the =
default value for this
>> - =C2=A0 =C2=A0 option and lists the commits in that commit range li=
ke the 'summary'
>> - =C2=A0 =C2=A0 option of linkgit:git-submodule[1] does.
>> + =C2=A0 =C2=A0 Choose the output format for submodule differences. =
<format> can be one
>> + =C2=A0 =C2=A0 of 'short' or 'log'. The default value is 'log'.
>> + =C2=A0 =C2=A0 'log' lists commits in the commit range like linkgit=
:git-submodule[1] `--summary`.
>> + =C2=A0 =C2=A0 'short' shows only the SHA1 of the source and destin=
ation.
>
> Does it risk being unclear to say src/dst here without defining, or i=
s it
> sufficiently clear from the context (the previous line says "range")?

I chose those words based on descriptions in some of the other diff
options (see `changes` and --src-prefix in the same file.  That being
said, the description you gave is more clear.


> You lost "not giving this option at all is the same as --submodule=3D=
short".

I removed that part on purpose.  I wasn't sure that it needs to be
documented here since it is about how the 'diff' command normally
behaves rather than about the '--submodule' option itself.


> Here is my attempt, but I do not think I particularly did a good job =
at
> this.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Specify how differences in submodules are =
shown. =C2=A0A `--submodule`
> =C2=A0 =C2=A0 =C2=A0 =C2=A0or `--submodule=3Dlog` option uses the lon=
g format, which lists the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0commits in the range like linkgit:git-subm=
odule[1] `--summary` does.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Omitting the `--submodule` option, or a `-=
-submodule=3Dshort` option,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0uses the short format, which just shows th=
e names of the commits
> =C2=A0 =C2=A0 =C2=A0 =C2=A0at the beginning and the end of the range.

Some further minor changes to your version:

 =C2=A0 =C2=A0Specify how differences in submodules are shown. =C2=A0Wh=
en `--submodule`
 =C2=A0 =C2=A0or `--submodule=3Dlog` is given, the 'log' format is used=
=2E  This format lists
 =C2=A0 =C2=A0the commits in the range like linkgit:git-submodule[1] `-=
-summary` does.
 =C2=A0 =C2=A0Omitting the `--submodule` option or specifying `--submod=
ule=3Dshort`,
 =C2=A0 =C2=A0uses the 'short' format. This format just shows the names=
 of the commits
 =C2=A0 =C2=A0at the beginning and end of the range.
