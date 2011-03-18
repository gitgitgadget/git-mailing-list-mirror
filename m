From: =?UTF-8?Q?Carl_F=C3=BCrstenberg?= <azatoth@gmail.com>
Subject: Re: gut submodule update and merge
Date: Fri, 18 Mar 2011 15:13:24 +0100
Message-ID: <AANLkTinK_ftV7rCHM2Q0PNRZQXLwCRzfoqogb=dkzXZM@mail.gmail.com>
References: <AANLkTimneYSkr11yDt1eL5d-r6pJrt2EMLGEOBfOxOoD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 15:13:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0aQk-0007kW-UU
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 15:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436Ab1CRON1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 10:13:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45465 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756506Ab1CRONZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 10:13:25 -0400
Received: by wya21 with SMTP id 21so3875019wya.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 07:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=G388sROPEtnZBjypfRqm0Tr6yY8NAFcM7VVl+MwyGmg=;
        b=NMoBeyGPZtmNqRBFlnv5gfMo4kmOkpLiK2FRXEa5aLriUtr0fzVFTP4lcC1NNKAtlX
         grw2iWNfFE8DtmXanMZ5RWNV4EjVXI9au2Mv9CCqy+EP94/jHIcpvL3CYtdJOd1tv8g6
         tMrRp2zAmTN3Gx2YXEJOKNVHhrqS8Pvt+kRAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=QPGAmOWW/dQff9dHkUvj0pE9r3DMArXtBDJebbmjkkpw1jJXoTM2ypujeYcgfcPxTC
         ZOhIa+OtAKwPf2BHRtZr2ZUjT4HUsC7aEze2tqm4GUSkPCWFwmibLsK8V2Mxd7Y2D6FB
         ki3AIFoO2YF2XM0Hf5+gj1m6zNHnrzNS4bP08=
Received: by 10.216.229.22 with SMTP id g22mr1377876weq.45.1300457604360; Fri,
 18 Mar 2011 07:13:24 -0700 (PDT)
Received: by 10.216.170.211 with HTTP; Fri, 18 Mar 2011 07:13:24 -0700 (PDT)
In-Reply-To: <AANLkTimneYSkr11yDt1eL5d-r6pJrt2EMLGEOBfOxOoD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169320>

2011/3/17 Carl F=C3=BCrstenberg <azatoth@gmail.com>:
> Hello,
>
> I've tried to setup in a n makefile a way to easy initialize and
> update submodules and at the same time keep eventual changes in the
> submodules. I though an "git submodule update --init --recursive
> --merge" would work,
> but =C2=A0this i notices created strange result if the submodules had=
n't
> been checked out in the first place. the result then was that it
> marked in index all files to be deleted.
>
> This behavior wasn't what I had in mind, and it resulted in I did
> following "fix" to resolve the issue (ugly):
> https://github.com/azatoth/jquery/commit/9977732a26820dd7f3ced2ce4554=
edadd62ae52c
>
> Is this the intended behavior? logically I think an clean "git
> submodule update --init --merge" should not try to merge if there
> wasn't anything to begin with.
>
> /Carl
>

If my question wasn't clear I'm sorry, All I'm wondering is if using
--merge when cloning an new submodule should behave this way or not. I
don't think most peoples intentions when using merge on an
non-existent repo should be to delete all file :)

/Carl
