From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: local clone performance
Date: Wed, 26 Jul 2006 19:38:00 -0400
Message-ID: <9e4733910607261637w75c99a2ehcb25b6c81449d298@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 27 01:38:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5sx4-0005J7-S2
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 01:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWGZXiD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 19:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbWGZXiD
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 19:38:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:61597 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751243AbWGZXiB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 19:38:01 -0400
Received: by nf-out-0910.google.com with SMTP id l24so719807nfc
        for <git@vger.kernel.org>; Wed, 26 Jul 2006 16:38:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UxkCVDtOD7z+YL67TZwpvNVKTtL+4dOu0NU15xoxI/wJCw7EW6eQkCaQPFNNscB7efnBQxVt0+mWCbKc5u1iU6AALUQ7Ws5gXLpd+N4heVYkRKYb5Uj021IcD4gJglUXroMi9NdMxLzW7bBp2BIH18Ea+ZUzvcfRVH4b0Z4BSmY=
Received: by 10.78.170.17 with SMTP id s17mr3507539hue;
        Wed, 26 Jul 2006 16:38:00 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Wed, 26 Jul 2006 16:37:59 -0700 (PDT)
To: git <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24262>

Comparing git-clone to cg-clone

[jonsmirl@jonsmirl apps]$ time git-clone git foo
......
real    0m5.755s
user    0m4.548s
sys     0m0.512s

[jonsmirl@jonsmirl apps]$ time cg-clone git foo
....
real    0m18.970s
user    0m10.737s
sys     0m1.392s

Why does it take cg clone so long to set up the missing tags?
git-clone is over 3x faster.

-- 
Jon Smirl
jonsmirl@gmail.com
