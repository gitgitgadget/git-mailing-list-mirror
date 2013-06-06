From: Sarma Tangirala <vtangira@buffalo.edu>
Subject: git diff bug?
Date: Thu, 6 Jun 2013 17:26:41 -0400
Message-ID: <CANd8icJ_1mqT9m-n3wPPdjzG1oNjwxfQeUA6YL6KVxbq0iEa1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 06 23:27:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkhiA-0001zX-2e
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 23:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266Ab3FFV1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 17:27:05 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:39619 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3FFV1E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 17:27:04 -0400
Received: by mail-ve0-f182.google.com with SMTP id ox1so2587508veb.27
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 14:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :x-gm-message-state;
        bh=fNthQqaBE8kyyfc/twAMS7we0aRnluDKFHKMDH6scTU=;
        b=as5IW5A/O70wuJiQqN8SAYqTfYKrQv8Lo7ZG7VT86kmt2Jm+xwFAC+KLb8n57HU8+s
         QGg9sOTztIJH3XdRfSiS/ldY7MDfarHiupHuPiCU1vE4XJPU3FGbMbqiGr5wNWTCXeya
         DVbhbRHj03gONHlSktZ9+znjNaYyWqXg0Bt8ik3NVp+hhZNwEf20qdxED2s7nIzYhCWJ
         6ZFHcNLLBxuFHxudqAoRmu7PyZ11YHwro8Xc0RvdpcY3c0EGwYQ2iT3RoRTzidd7MW3L
         WM1JHaKTmqz++kTLY61i3/rwPq3ik6Qa4thqfWgCIbA5K8XC3MUAVtvgfffIYTbDPcok
         fEew==
X-Received: by 10.52.18.137 with SMTP id w9mr19306498vdd.50.1370554021691;
 Thu, 06 Jun 2013 14:27:01 -0700 (PDT)
Received: by 10.52.23.143 with HTTP; Thu, 6 Jun 2013 14:26:41 -0700 (PDT)
X-Gm-Message-State: ALoCoQkHE4N2e9YpijUvEwt3OvM2gK6+1jod/pbE0eX3uGTuN0tFAnVq52qn8srf+xGAmop39CdO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226562>

Hello All,

If I did 'git diff HEAD^..HEAD -- file' should git not report some
kind of warning if it could not match the file? For example, if 'file'
were infact 'dir/file' and 'file' were unique, would it not be a good
idea to report that in the present working directory 'file' were not
found but 'dir/file' were a match?

Apologies if I missed this in the man page.

Thanks

--
010
001
111
