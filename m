From: Babak M <babak@melon.com.au>
Subject: Issuing warning when hook does not have execution permission
Date: Tue, 19 Aug 2014 16:05:21 +1000
Message-ID: <CAPyMVO+a+R-+UDVuNSfhyB=PX-NUZbt6VGXfOv19-mDKTqfj6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 08:05:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJcYE-0003Vo-Mp
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 08:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbaHSGFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 02:05:42 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:43196 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbaHSGFm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 02:05:42 -0400
Received: by mail-wi0-f180.google.com with SMTP id n3so4720608wiv.7
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 23:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melon.com.au; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=T8NNQOR+UOQC9qD0FOdFcIleDOCtfqGZ5plQotXg8Ts=;
        b=MTpJQsbSI/0cpShbo2Y39CdIf3M9+xFiVf+9TF18Oqh8A3Rq9lvHjHs62SQSeUYPe3
         Qy7RKyMdEdmza7DFvO8pzMprwqbCtupTBYNincu2w8nHgv6frfiCirE+pkb6hVXSpdU6
         WYpdln0P+p4l/Za6Cpqe1gtAScPCUc5Erq+n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=T8NNQOR+UOQC9qD0FOdFcIleDOCtfqGZ5plQotXg8Ts=;
        b=Eanf1uXeYMqXhLaXrmOAkFo2jNYSkP9l56xOe+XYBKTumk7UlWmQYGX1SEywPhMh+V
         5BNT41tqHF/9n0hKbInHSWOpwzRynLYd440Ex16SWYjvY1FJm1xLCaxmerpxqOgu1Xcp
         VHXDQ41thX3bycVtozWyNHgZN+qd+aRNJrTVDHqtInz9bovfrgmeVVMvi78bAmW1AZ8X
         f1yVr24PWpI1mY7992xqtGg1/6L7OP1kdqao5WZsE65ZpRUXPZyTTNcMer6TcFZ+4jbK
         eWAU6o8RKGKUeAV10RzynAVBPOpBvhptSA2zkOatQh0QBDK6OeyY48Fgvs1LnELrEGmu
         7kNg==
X-Gm-Message-State: ALoCoQl8NcyTPLYzECxxNE8ES07JpbtdAv6UbxqEZ1C4XPNzJ4m2zESWlyz4bV3vC8CsRJpwoDNR
X-Received: by 10.180.186.3 with SMTP id fg3mr4041901wic.78.1408428341260;
 Mon, 18 Aug 2014 23:05:41 -0700 (PDT)
Received: by 10.194.60.116 with HTTP; Mon, 18 Aug 2014 23:05:21 -0700 (PDT)
X-Originating-IP: [203.206.230.69]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255443>

Hi,

I saw that if a hook file is present in .git/hooks and it does not
have execution permissions it is silently ignored.

I thought it might be worthwhile issuing a warning such as "Warning:
pre-commit hook exists but it cannot be executed due to insufficient
permissions".

Not sure if this has been discussed before. I searched the archive but
didn't see anything.

Thoughts, suggestions? Is there anything like that already?

Cheers,
Babak
