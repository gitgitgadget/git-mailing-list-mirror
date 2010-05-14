From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Thu, 13 May 2010 22:34:27 -0400
Message-ID: <AANLkTil1i_vFAvT1CotYdK47LnufVKc17-1168rOVcMX@mail.gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com>
	 <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com>
	 <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org>
	 <961B7250-F65E-4C67-8C5C-6701F68C2FC0@gmail.com>
	 <alpine.LFD.2.00.1005131438330.3711@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 14 04:34:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCkjT-00029t-Bg
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 04:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883Ab0ENCea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 22:34:30 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:34186 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756722Ab0ENCe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 22:34:29 -0400
Received: by wwi18 with SMTP id 18so233680wwi.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 19:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=vcYMLL3/+P27y+DqrLuvBufx32NL2OQJUCObWki436M=;
        b=rkO2FzJY54UR+V102r4tQc+YmRkIUI3U7+MPOg19z8UaR0MsPfiPT0mvxeWA+py8Bd
         +ofAIeajqiS6LUQljBm6wj7VV7Ap6zrWiTOm3SXcPScPctsehmN32dxeZ3alyjvTt+H9
         NS1isieJ0jo786MlzFW+Uxa283Es+L7gCv768=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=yHyzV/wzHAkXtfslE7ae19AY+UdMgCnOqsjbxCXu522PEL8ktRo2sjtXlrqO3PJlQX
         T20TalyzssJyo/3nGIvJZouX72lteGdaGYq1oSNnJhtCS3+Iatn7onSfK7kgPyn9NUhL
         EM6N2DOS5Tn6FyIWUcwjxGwOf7czHZNxGvRyY=
Received: by 10.216.90.70 with SMTP id d48mr426088wef.199.1273804467735; Thu, 
	13 May 2010 19:34:27 -0700 (PDT)
Received: by 10.216.7.207 with HTTP; Thu, 13 May 2010 19:34:27 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1005131438330.3711@i5.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147038>

Probably a newbie question, lots to read, lots already read, but I
really want to verify if I have this correct. So in a nutshell, in the
gitattributes file

*   text
*.foo  binary

means autoconvert everything regardless of the autocrlf setting,
except for .foo files ? So now we can dispense with the autocrlf
attribute altogether if we so wish?

- Bob
