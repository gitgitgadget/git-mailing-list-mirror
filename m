From: David Aguilar <davvid@gmail.com>
Subject: Re: [msysGit] [PATCH] gitk: fix the display of files when filtered by path
Date: Wed, 14 Dec 2011 20:18:40 -0800
Message-ID: <CAJDDKr6rVaX_=SZZeEAs950yuNDvi8sOkzrUK7LnCrK6MYfscg@mail.gmail.com>
References: <87hb14wg4l.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
	msysGit <msysgit@googlegroups.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 05:18:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb2mO-0001Tf-0f
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 05:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757839Ab1LOESm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 23:18:42 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51391 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755957Ab1LOESl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 23:18:41 -0500
Received: by ggdk6 with SMTP id k6so1408610ggd.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 20:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=R2VesHSnVYeJKH71wPFZqNwRnxq1K9K3CyuXX4i5ZZo=;
        b=mRX1iOyeZeT8fOO9QUjh91C1k4KWmHE37Qt5tZtHuHoArpz1ZF/YKahId2jutLORvZ
         irK88E4QnG7rr2FJSiO1fF+oKTFDsFfT5Z400j0++t9HIEQcn4LyzYQkhDwF3/96GFgI
         FZ4+dc8EdBMinas8SlqErSNhLL1ldRikoEQO0=
Received: by 10.101.87.8 with SMTP id p8mr475404anl.3.1323922720972; Wed, 14
 Dec 2011 20:18:40 -0800 (PST)
Received: by 10.146.76.12 with HTTP; Wed, 14 Dec 2011 20:18:40 -0800 (PST)
In-Reply-To: <87hb14wg4l.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187188>

On Tue, Dec 13, 2011 at 8:50 AM, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Launching 'gitk -- .' or 'gitk -- ..\t' restricts the display to file=
s
> under the given directory but the file list is left empty. This is be=
cause
> the path_filter function fails to match the filenames which are relat=
ive
> to the working tree to the filter which is filessytem relative.
> This solves the problem by making both names fully qualified filesyst=
em
> paths before performing the comparison.
>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

Wonderful!

I've run into this problem a number of times (as have some co-workers)
but I never bothered to report it since I felt guilty for never having
worked up a patch.

I tested this and it worked.

=46WIW,

Tested-by: David Aguilar <davvid@gmail.com>


Thank you Pat!
--=20
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 David
