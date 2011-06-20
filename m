From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git-new-workdir for Windows (#9)
Date: Mon, 20 Jun 2011 11:20:21 +0530
Message-ID: <BANLkTinosK6uDdqoRwk8j20y08JwM2HxTw@mail.gmail.com>
References: <git/git/pull/9@github.com> <git/git/pull/9/c1372088@github.com> <BANLkTi=x+5yL3XuS8HF1=5S71rsY_=7O9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Smith <dansmith65@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 07:50:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYXNo-0004ez-OO
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 07:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018Ab1FTFuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jun 2011 01:50:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63465 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab1FTFun convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2011 01:50:43 -0400
Received: by wyb38 with SMTP id 38so1403606wyb.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 22:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=6ICquQXBFSKis5f5Jxhn2hIdqCeXiiFNWz25FvFQwp4=;
        b=vHq/98zteUncgK3nthVOIVvLGAulbx7lNIF56GnrnfE2vLGXGbbq8+VeD4c8DRr9pl
         m92Ysd9OPuna+Movc34JmP57miTwHDcNKx3fPhi+FI4+4d3kEsLQKqix9txcET6rOD1i
         lwKCS5cldXPkhJYegdfmmhh3lUfZKU/OFVQ4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oOkf8oFgw8VxAfFnTwTaNCT0JOuurT/nrQzpPaBmZ21MxTDqrxHZkmo4lJQt3+yyjQ
         og14bh1+p934bcFlrb02SoFQhftWTNMP11u/kzSSFSgniw9CGx+WdKnXuE/Lwopp556A
         5GXnQxIc4OBUfY5BChILNWXENhG/xSOxNlPvs=
Received: by 10.216.66.149 with SMTP id h21mr362976wed.91.1308549042114; Sun,
 19 Jun 2011 22:50:42 -0700 (PDT)
Received: by 10.216.18.16 with HTTP; Sun, 19 Jun 2011 22:50:21 -0700 (PDT)
In-Reply-To: <BANLkTi=x+5yL3XuS8HF1=5S71rsY_=7O9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176048>

Hi Daniel,

Daniel Smith writes:
> The git-new-workdir script creates copies of files instead of symboli=
c
> links, when run from Git Bash on Windows Vista. I modified it to use
> mklink via cmd.exe. =C2=A0I have an open pull request on GitHub:
> https://github.com/git/git/pull/9.
>
> I'm not sure how permanent that link is, so here is a link to the fil=
e
> in my fork of git:
> https://github.com/dansmith65/git/blob/master/contrib/workdir/git-new=
-workdir-win

Thank you for fixing this.  However, we can't accept patches via pull
requests on GitHub.  Please read Documentation/SubmittingPatches to
submit a neatly formatted patch so that we can consider it for
inclusion.  Also, please consider patching the existing
git-new-workdir script to work with GitBash instead of creating one
from scratch.

Thanks.

-- Ram
