From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git am should recognize >From
Date: Sun, 19 Sep 2010 17:32:11 +0300
Message-ID: <AANLkTinOa+s-28PYXHhtKr_POu2D33ibfgKDKk4Wqi=9@mail.gmail.com>
References: <AANLkTin_5qzDkMU_1stYZcJpfW-W7K0kxy=0K2dA7SwO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	"Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
	=?UTF-8?Q?Lukas_Sandstr=C3=B6m?= <luksan@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Himpel <chressie@googlemail.com>
To: Russ Allbery <rra@debian.org>
X-From: git-owner@vger.kernel.org Sun Sep 19 16:32:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxKwI-0007NQ-JA
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 16:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab0ISOcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 10:32:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63580 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab0ISOcM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 10:32:12 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3466459iwn.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=aaosy3OR2sRhOjZd+3kLeN4vug1d3IaDYlJB/Nx0J98=;
        b=vwasRRRi0iC7us62nrLMU6RI7kl3iXnhuxXa5I4zLBF2Bs6R1gtXXNCerh2ybLhwXB
         ZTldaHr4q/s08gGd24rPKRKr5dmmBFMAhs9FNribMygWzGfBI0dhISNwzee0oIp21aEs
         Uke3R688UZLXhlPB6szIiMxUahvBQJKHtPY50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XicdsTdAC+3yUlmupdPxT7zIXMw/zR9L4mJECZGptAeC3AfXNTncVA9rAu38+Y3oiN
         ptv/vyJp8H1OLytW+Iq2B4lfx6Py0r2JUSHRXOFm6HYoizdgZ12kysVnrq15X4DCIqaZ
         knpUKX4FapQScwlGeIIL6KsI8RvJOaVB9VZ+I=
Received: by 10.231.174.5 with SMTP id r5mr8507085ibz.132.1284906731960; Sun,
 19 Sep 2010 07:32:11 -0700 (PDT)
Received: by 10.231.15.12 with HTTP; Sun, 19 Sep 2010 07:32:11 -0700 (PDT)
In-Reply-To: <AANLkTin_5qzDkMU_1stYZcJpfW-W7K0kxy=0K2dA7SwO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156500>

Russ Allbery wrote:

> I process a lot of git format-patch patches as attachments,

Aside: it seems that many format-patch users are not using it to
generate an mbox with a template message, as originally intended;
instead, they just write a cover letter and attach the generated
patches to it. Are we not advertising the "am --scissors" facility[1]
well enough?

Maybe format-patch could provide another mode to produce patches that
do not include unnecessary headers (in particular, leaving out the
difficult "From " line and using UTF-8 instead of quoted-printable for
the "From: " line).

All that is irrelevant to the "git am" feature suggestion, of course.

Thanks for a reminder,
Jonathan

[1]
 > lorem ipsum etc etc
 ... reply as usual ...
 ...
 How about this patch?
 -- 8< --
 From: Patch Author <au.thor@example.com>
 Subject: foo: do "bar" better

 patch description
 ---
 ... patch ...
