From: Karoly Negyesi <karoly@negyesi.net>
Subject: git apply --index --reject does not add new files
Date: Fri, 5 Apr 2013 22:13:35 -0700
Message-ID: <CAOfzkkxMhVRdRYOJW_bi7FR00S87epmJYoP8R8X_fDM=ifa=Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:41:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWSQ-0001b9-GZ
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab3DFFN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 01:13:59 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:42660 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab3DFFN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 01:13:58 -0400
Received: by mail-qa0-f41.google.com with SMTP id bs12so488926qab.14
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 22:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:x-received:mime-version:from:date:message-id:subject:to
         :content-type:x-gm-message-state;
        bh=BOgHXHVkAoT62qR6+4bkng+6K0nDc1t0BWpVTMdAIqQ=;
        b=N13OO5AIK7xhWKpTe2DZvnTufl6rqT1OACEYn5siZUMUAeUxsh9go3iZhAUvPhkfCh
         UZHIVsaZjlgEy7yd17CylrGGy+v7S0l6aefJRM4ySyz2esYWsweoVuevWhwArMUo2HGV
         3xpPb+NW2AfJCvsHBDKceo8br4NX/sU79UZSi3iZjqpe82JMxbob4wxlkeKMF5EVl+nG
         GDB7tieljb9RSn04QHcYmzKmq3AH0L0sCnuqxaJ4xmCWSJzNJ97e9Ydm+lojc7hWndXn
         BdxLDNlu9z0WnXafDm6D3+eB1QP/59kOEBw8LUP2+jAP8u0d3Djcu6ryzuZNjnEKoJ2s
         HK8Q==
X-Received: by 10.49.49.72 with SMTP id s8mr12178717qen.54.1365225237933;
        Fri, 05 Apr 2013 22:13:57 -0700 (PDT)
Received: from mail-qc0-x232.google.com (mail-qc0-x232.google.com [2607:f8b0:400d:c01::232])
        by mx.google.com with ESMTPS id e3sm16029066qeo.0.2013.04.05.22.13.56
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 22:13:57 -0700 (PDT)
Received: by mail-qc0-f178.google.com with SMTP id d10so1917339qca.9
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 22:13:55 -0700 (PDT)
X-Received: by 10.224.219.69 with SMTP id ht5mr637441qab.88.1365225235401;
 Fri, 05 Apr 2013 22:13:55 -0700 (PDT)
Received: by 10.49.57.227 with HTTP; Fri, 5 Apr 2013 22:13:35 -0700 (PDT)
X-Gm-Message-State: ALoCoQnQj+A1Zs1vWOV2dgDqno8uUmQuZ/c9Zaq9VrYZ6vPGNoH6LC+CWmohrTeF4K5mYSqxsjhI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220222>

Hi,

I believe this to be a bug. git apply --index does add new files but
git apply --index --reject does not even those that apply without
errors.

Regards

Karoly Negyesi
