From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Documentation/git-checkout.txt: Inconsistent naming of paths arguments
Date: Fri, 19 Jul 2013 14:40:18 +0700
Message-ID: <CACsJy8DdVxwsf5xyDSDCe97kTPGdjvwQcMEPRNCCGXjF1z4eyw@mail.gmail.com>
References: <CAJTcR-1RxLEaUe+c5yXEuKeC5Ert4FGm0=kUi7H-M-a+-Cp9-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Adam_Brengesj=C3=B6?= <ca.brengesjo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 09:41:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V05JE-0002Ye-8b
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 09:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab3GSHku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jul 2013 03:40:50 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:56207 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab3GSHks convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jul 2013 03:40:48 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so5469437oag.20
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xtBB03wvQOdSZ2FEi1zx2pntG/fBV5YfMcvbubT9i4U=;
        b=gIujHSLCdOYpkM8Mre0cwYiuU2f772OtmD00dRQzR34pB0kecFn14evmdLmSJfp0do
         6tH8F9Y4zWNFrs07kEnJh6SHLs3pmM8TvB2KEJkxYF4RCqDsbNQW7IE2aEhdr64tOpSw
         b8NxnbmKOFlAS/483Z+0MtojLt0cj2pB+Hhtthn+UuhiFnKW6VFYMk67zMRshLH6SK5E
         uMmIneD6f+B27pAe33AG/4W+fauyCwgytzbWyhZDyDf/WG3qaffvKztfM4Lmbuq/3JYZ
         y8u2iQ4Ri7HpGQaoFp5AOUM+F4O0LY+A+iq/hPqWeFX8vVMvpm+HI5bJsweaSszlVFO8
         Q3RQ==
X-Received: by 10.60.83.116 with SMTP id p20mr16686050oey.83.1374219648141;
 Fri, 19 Jul 2013 00:40:48 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Fri, 19 Jul 2013 00:40:18 -0700 (PDT)
In-Reply-To: <CAJTcR-1RxLEaUe+c5yXEuKeC5Ert4FGm0=kUi7H-M-a+-Cp9-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230784>

On Fri, Jul 19, 2013 at 2:16 PM, Adam Brengesj=C3=B6 <ca.brengesjo@gmai=
l.com> wrote:
> From SYNOPSIS:
>
> git checkout [-p|--patch] [<tree-ish>] [--] [<paths>=E2=80=A6]
>
>
> From DESCRIPTION
>
> git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>=E2=80=A6
>
>
>
> 1. Named <paths> in SYNOPSIS, but <pathspec> in DESCRIPTION. (It's
> referred to as <path> in the body text).
>
> 2. <paths> is marked as optional in SYNOPSIS, but <pathspec> is not.
>
> I'm not submitting a patch now, as I'm not sure which is correct.

If I'm not mistaken, "git checkout" takes pathspec in all cases.
--
Duy
