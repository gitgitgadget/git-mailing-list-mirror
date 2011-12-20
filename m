From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] Documentation: make git-sh-setup docs less scary
Date: Tue, 20 Dec 2011 20:45:05 +0100
Message-ID: <CACBZZX5BSfh8S9Kf1Wbi+NPEKpxJNXU8TD8-hkC2o1Mi91Or6A@mail.gmail.com>
References: <c53feb0de8006c205fd26c2c07dcd78bd86b6c24.1324378986.git.trast@student.ethz.ch>
 <c8867738c264a76f9662080b64e00615ec1aa28f.1324378986.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 20 20:45:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd5cy-0006iC-DH
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 20:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab1LTTp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 14:45:28 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:55795 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab1LTTp1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Dec 2011 14:45:27 -0500
Received: by werm1 with SMTP id m1so2223004wer.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 11:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=T2ya0WVNI1lx+ZERKcJAv6xitg40zR5BIXmLyBzAYQ0=;
        b=r8kihjCU/XNISYsaScZ5dqbbc7bWdMkNT/zs3voQ1d8H9gfl+FVzQeYBcrQL/NZ36R
         nVRIe3POK7bcVf4dsHDREneEOBUP6GJiefs2t1BxcQ7WFwq0yQsi0KNfSV79cT2brcvq
         /d/kklXdspSNgzWVAkt+cD7E+6iUD85OOYTIA=
Received: by 10.216.136.28 with SMTP id v28mr7439176wei.58.1324410326177; Tue,
 20 Dec 2011 11:45:26 -0800 (PST)
Received: by 10.223.77.91 with HTTP; Tue, 20 Dec 2011 11:45:05 -0800 (PST)
In-Reply-To: <c8867738c264a76f9662080b64e00615ec1aa28f.1324378986.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187520>

On Tue, Dec 20, 2011 at 12:09, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> At least one IRC user was scared away by the introductory "This is no=
t
> a command the end user would want to run. =C2=A0Ever." to the point o=
f not
> reading on.

Arguably that's the point isn't it? To not have people who aren't
maintaining Git itself waste time on reading it.

Anyway I don't care how it's worded, but if you're going to patch it
you should probably do these too for consistency, since they
copy/paste this same blurb:

    $ git --no-pager grep -l 'This is not a command the end user would
want to run.  Ever.'
    Documentation/git-mergetool--lib.txt
    Documentation/git-sh-i18n--envsubst.txt
    Documentation/git-sh-i18n.txt
    Documentation/git-sh-setup.txt

And actually we might want to do all those with some asciidoc include
mechanism.
