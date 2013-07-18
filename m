From: Rahul Bansal <rahul.bansal@rtcamp.com>
Subject: Git tag output order is incorrect (IMHO)
Date: Thu, 18 Jul 2013 20:57:00 +0530
Message-ID: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 17:27:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzq6q-0003jZ-09
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 17:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758329Ab3GRP1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 11:27:07 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:50370 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756756Ab3GRP1G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jul 2013 11:27:06 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so3322270pbb.14
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 08:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version:x-mailer:x-gm-message-state;
        bh=WXzFoF3MedFdYvCy99AOvZZB7zaFYDgedAcISSED9Pg=;
        b=E6HkTq1GKg2sRvciWtFudQmj7nEHhdfx22xFf37AtS5DnOh5y6emdz5Cy4ZA0x+RXO
         SrY8x71Utj6eYpdZbpX1VynU1eukag3+iaaJoA2n/iol3+7HvJ2dWhnIZLyf3QlCxPMV
         YiHyPxejXvNRKNH7q6OtZFfKiFUEgooUc7PBIZwaCQvUv1bfzWgZzJNHmr5MqK30Ohi/
         /3sSEx2Mhhn4Qe7fHmEE0YAknKg6E9sT8DPxpz+RKT/oDe0m4amx2Aqy7uHtEggDXX3I
         MlpDhAgzvrG/pkKOGxcFZw4MhNn7J8JBhUWCamKYTd7cT7txmpCcp3by/kJAUfcNBzbh
         DPtw==
X-Received: by 10.68.219.194 with SMTP id pq2mr12727425pbc.151.1374161225151;
        Thu, 18 Jul 2013 08:27:05 -0700 (PDT)
Received: from [192.168.0.11] ([115.115.82.210])
        by mx.google.com with ESMTPSA id om2sm14332252pbb.34.2013.07.18.08.27.03
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 08:27:04 -0700 (PDT)
X-Mailer: Apple Mail (2.1508)
X-Gm-Message-State: ALoCoQkT9gv0WUTyPkHwbdosziEOCYV+NdHRYaCEnupGPxhBhq6Qj1hLIVaoRinoeXAlHUD3JqhI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230694>

I am posting here first time, so please excuse me if this is not right place to send something like this.

Please check - http://stackoverflow.com/questions/6091306/can-i-make-git-print-x-y-z-style-tag-names-in-a-sensible-order

And also - https://github.com/gitlabhq/gitlabhq/issues/4565

IMHO "git tag" is expected to show tag-list ordered by versions. 

It may be case, that people do not follow same version numbering convention. Most people after x.9.x increment major version (that is why they may not be affected because of this)

Another option like "git tag --date-asc" can be added which will print tags by creation date. (As long as people do not create backdated tag, this will work).

Thanks,
-Rahul