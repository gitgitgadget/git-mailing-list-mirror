From: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v7 0/4] cat-file: teach cat-file a '--literally' option
Date: Sat, 04 Apr 2015 11:11:24 +0530
Message-ID: <551F7984.5070902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 04 07:41:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeGpw-0005fU-34
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 07:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbbDDFl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 01:41:29 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34664 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbbDDFl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 01:41:28 -0400
Received: by pdbni2 with SMTP id ni2so142992051pdb.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 22:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=Z64WCdeuvfkVDRNm8lIB5PsaoV0XAeGiJ26A1bKRh88=;
        b=MzMKFe/C5jcMbggstrOir3q+eN0j2t/kjZcmfPMx82Ebhe5AToy1MiZvqeEeQd+JVa
         RRiM88+8OeOclWVkm0nnQEuwlA9J22Y/JKf5teG6B1zSJZi09OOyj4BMMfpw6eIlwQsn
         3YgK038fZ94QfKQSFkpIjSKF4WI7LQ0oWcViO7IGLExi1Yu6SG6JaHXjMswLxzVQHc6e
         8rDMZycZ1Aukx6Dqw9B63YxK+wpUAj/hGmbppeA+0uB0TUuKB/iKzp5KS0VnnqzI1zCa
         xSzakZ610xj02m75B6H1OMmN1pMFeJlOpJtV5NNTSI84kZBArAgbeAjC3QZxLktQ0pn3
         TcyA==
X-Received: by 10.66.235.36 with SMTP id uj4mr9593319pac.123.1428126088372;
        Fri, 03 Apr 2015 22:41:28 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id n3sm9762946pdm.90.2015.04.03.22.41.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 22:41:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266761>

Changes made :

* Fixed the problem with packed types, which failed a few tests.
* Misspelled email.

Thanks for the suggestions and comments on version 6.
