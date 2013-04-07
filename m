From: David Foster <davidfstr@gmail.com>
Subject: Git/Mac refuses to install on OS X 10.8 (Mountain Lion)
Date: Sat, 06 Apr 2013 18:55:47 -0700
Message-ID: <5160D223.3090203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 03:56:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOept-000647-0o
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 03:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251Ab3DGBzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 21:55:52 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:40643 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765123Ab3DGBzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 21:55:51 -0400
Received: by mail-pd0-f170.google.com with SMTP id 10so2605855pdi.15
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 18:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=iQZgCUWm1Ri/QLnLJaaM4y7ZW5RHetTUAtDXB2s/tYM=;
        b=NFCL+mGsEr9WkptB1Bp3fGNcJTesx/WB+06fU+OqhvS8rXDxViIU2aqt+/W2757olA
         f9F+v/rQaKAkYwTEOoKbupqSA37B9iKThURLKITTsE9pTUZy5H6EifDD8KK0/bZkk6Og
         rSAsYP8kozDHtE3/06iADg7+ezApvzE1qNnENkI7Ls72CJliwtkzO8JywjPlJYcigxRQ
         yuIpX2gksPZfbQE6SfM8TpmKjYT4e4Duh9on+JMBpp46tUfgYJtNUqnUYhgokZl0FiOr
         o+pqts3Gcn6jaRqg5gbAE8LlhGyYfpbRGTT72hObHfqhcz/1ZxVm4laiYWCdFcoau/Va
         Ufkw==
X-Received: by 10.67.4.227 with SMTP id ch3mr17791613pad.59.1365299750378;
        Sat, 06 Apr 2013 18:55:50 -0700 (PDT)
Received: from Cathode-2.local (c-66-235-53-6.sea.wa.customer.broadstripe.net. [66.235.53.6])
        by mx.google.com with ESMTPS id ak5sm5202626pac.4.2013.04.06.18.55.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Apr 2013 18:55:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220273>

The default security settings on OS X 10.8 (Mountain Lion) disallow the
installation of unsigned packages, with no override.

Git/Mac 1.8.2 is not signed and therefore will not install without changing
the OS default security settings.

See screenshot:
http://postimg.org/image/wcb34kzy5/

-- 
David Foster
http://dafoster.net/
