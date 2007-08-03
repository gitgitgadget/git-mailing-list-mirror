From: Dmitry Kakurin <dmitry.kakurin@gmail.com>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile git)
Date: Fri, 3 Aug 2007 14:14:15 -0700
Message-ID: <5AB2AD5AE96F4C2DAAE83AD66341C6E8@ntdev.corp.microsoft.com>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site>  <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com>  <46B2D4D9.4020103@trolltech.com> <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com> <Pine.LNX.4.64.0708031240450.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <marius@trolltech.com>, <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 23:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH4Ta-0000Tb-Gr
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 23:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763516AbXHCVOW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 17:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763970AbXHCVOW
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 17:14:22 -0400
Received: from qb-out-0506.google.com ([72.14.204.235]:5916 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763516AbXHCVOS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 17:14:18 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1067476qbe
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 14:14:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=AH+XlDndg1ThG9paztPWNfB021MBIeDYdHAvIU0gqpSdOv4ZTXTszKDmExPObKGynbmAzGUWMxcOXZ1/AkRDJJNet00i/Pn+Ag+m2ee0LG9xN3ba7rnMv/SvO6a4hvCno2YKsaLp6jSgOJiNqdxFDteLSDZTQuTnATWAQvVEjac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:to:cc:references:in-reply-to:subject:date:mime-version:content-type:content-transfer-encoding:x-priority:x-msmail-priority:x-mailer:x-mimeole:from;
        b=XmXRPDID/XjxfZF3GFWmyjhJenJoEXm3anFS7jLi0Ggyc5oGGCu+k587mJqCqz8jFNCk/9GMBRz/5BW9KALJndggHrHJDsZzkR5l/QCJ+1smDP3iqmESdoBaFuJFH7xYJrOa4vlmvvcipff9S21/+uqzoRDXLyU4edX9QzeMcsw=
Received: by 10.115.79.1 with SMTP id g1mr3369595wal.1186175656746;
        Fri, 03 Aug 2007 14:14:16 -0700 (PDT)
Received: from dmitrykl2 ( [71.112.20.227])
        by mx.google.com with ESMTPS id y11sm6621059pod.2007.08.03.14.14.15
        (version=SSLv3 cipher=OTHER);
        Fri, 03 Aug 2007 14:14:16 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0708031240450.14781@racer.site>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16480
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54757>

> With Vista fix you mean both adding the USE_MINGW_ACCESS define and 
> copying cc1.exe to /bin?

Only the first one. I didn't copy cc1.exe because it could affect non-Vista users in a negative way.

- Dmitry
