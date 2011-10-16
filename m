From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 7/8] mergetools: use the correct tool for Beyond Compare 3
 on Windows
Date: Sun, 16 Oct 2011 12:12:56 +0200
Message-ID: <CAHGBnuN3m6tyA5HMo+zmE8k_PPPesP3fOh6Y15uCixUgTN3+tg@mail.gmail.com>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
	<1318632815-29945-8-git-send-email-patthoyts@users.sourceforge.net>
	<7vobxix0pk.fsf@alter.siamese.dyndns.org>
	<4E996012.8090002@gmail.com>
	<87fwiuig41.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Oct 16 12:13:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFNiH-0000It-6i
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 12:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850Ab1JPKM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 06:12:57 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44743 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab1JPKM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 06:12:56 -0400
Received: by vcge1 with SMTP id e1so1418588vcg.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 03:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y5jGrIIBw5hawJx1ctnB4L0SiVnY0Mo+Cx8jWh1ovw8=;
        b=M3X3o6HrT7Z1isnk+kPNYiOxeo0pNNBXAMbqdpHG7VeGt2qN+ccvkv0r1f2gUUQIMT
         sAqn0GlOz0eCNDwJd50wzPtPIODb1FpUBKcAi4jWrs8Ske1PUYVVV8bGog9Dh69nq6tZ
         4kvh/YYlGwGDaiugzumSg0dwjge5Dhy+9fT58=
Received: by 10.220.152.193 with SMTP id h1mr1096477vcw.270.1318759976174;
 Sun, 16 Oct 2011 03:12:56 -0700 (PDT)
Received: by 10.220.188.69 with HTTP; Sun, 16 Oct 2011 03:12:56 -0700 (PDT)
In-Reply-To: <87fwiuig41.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183701>

On Sat, Oct 15, 2011 at 14:39, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:

> And checking the linux distribution shows only a bcompare executable so
> testing for the presence of 'bcomp' will be fine.

That's what I was implying, sorry for not being more clear. I also
checked the Linux version of BC3 to verify that it only contains a
"bcompare" executable.

-- 
Sebastian Schuberth
