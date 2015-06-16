From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 00/11] add options to for-each-ref
Date: Tue, 16 Jun 2015 19:49:31 +0530
Message-ID: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 16:20:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4rii-0002qN-RH
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 16:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310AbbFPOUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 10:20:05 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:34637 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756180AbbFPOUC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 10:20:02 -0400
Received: by obbsn1 with SMTP id sn1so12306311obb.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 07:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=cC9yiMM2zn6HZoxgL7qU+SpyDVXbUW5Q4fjHr+2qIQY=;
        b=ieTpmU1kt4k+VWbseizjfM9amM8AGqEjJZrfIYUy7E8EN8S10JcOSUHgBJXAXQz0qM
         JI0B5L5GsnAwBh0iMCsvCm/2j4uwGvYVAHKld2q89pz1aEsEDfleY+KQEWnzVnmmSlcO
         i+B32swiSP9950En+V0wa3P9ZGSnVkYHeO1FJa4TyWOI27QuPi78jXgoi7QEuaBvWcSv
         k3RFeaRQdlnwLAxaBYvZEAhetRUNjl7NpL+e/5XLsp+i3xYcsFPpGs5NQ+smnalCzq/H
         qBRDnUbWYwLeryM1WA+kG+OwuhJopgAGhXJ/lv+X3Y8krsDXRlmRzIp6fRSJWRLEux9o
         CD4g==
X-Received: by 10.182.22.33 with SMTP id a1mr467625obf.41.1434464401757; Tue,
 16 Jun 2015 07:20:01 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Tue, 16 Jun 2015 07:19:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271754>

This is continuation of the patch series 'Create ref-filter from for-each-ref'
found at : http://thread.gmane.org/gmane.comp.version-control.git/271563

The previous version of this series can be found at :
http://thread.gmane.org/gmane.comp.version-control.git/271575

Changes made:
* Add PARSE_OPT_HIDDEN back in 09/11
* Whitespace changes and added missing information in 01/11
* Reduce redundancy in 05/11

Thanks to Junio C Hamano, Matthieu Moy, and Christian Couder for all
the suggestions.

-- 
Regards,
Karthik Nayak
