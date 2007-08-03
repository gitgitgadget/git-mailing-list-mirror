From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Fri, 3 Aug 2007 14:21:25 -0700
Message-ID: <E3C81783E0454702B1F38D0B68CE1AC0@ntdev.corp.microsoft.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>  <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com>  <46B2D4D9.4020103@trolltech.com> <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com> <Pine.LNX.4.64.0708031334530.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <marius@trolltech.com>, <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 23:21:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH4aQ-0002ey-Tp
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 23:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761886AbXHCVV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 17:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761792AbXHCVV2
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 17:21:28 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:3094 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757510AbXHCVV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 17:21:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so961892wah
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 14:21:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=ngtqPWSBAYIz/56X9HcoqJH7HmsnbMzyxp5LhwgH0evrbmy3JyTDjKJxxN0m8gL7q0S1cYc61md2mtmwEqXe2d3Wk0HiuQLMy9tbEyAOupfgVutxwVRkV6boMbgdO1iD+UarY+b1wBLJIXkvHqMTP7W5gcXBuM6oL3t2nQgasaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=idFMbkwhLIP/JGHbkcfpEW8padUYNvmq1wyQn5A51mQ4AJb7wi46VDUcCiwFLynLP42G72Gi1Qt1du4XEBmi59VvqucYOPFKsitE1WqU/q94wGmLhVO5uIohjKxea2kQizWoQtpYoTiQQvXMINlx8DCIAOP+ayNhXLl5NUOnQvI=
Received: by 10.114.190.6 with SMTP id n6mr3359136waf.1186176086636;
        Fri, 03 Aug 2007 14:21:26 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id a8sm6596194poa.2007.08.03.14.21.25
        (version=SSLv3 cipher=OTHER);
        Fri, 03 Aug 2007 14:21:26 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708031334530.14781@racer.site>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54758>

> * replace rxvt by that stupid cmd window
> Sneaky.

This was a result of my customization that I have forgot to remove.
In general cmd window is more familiar/convenient for Windows users.
IMHO, our goal here should be "as native (Windows) as possible". Cygwin fills "as close to *nix as possible" niche.
But in any case it's such a minor detail that I don't really care much.

- Dmitry
