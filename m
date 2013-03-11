From: Dmitry Ilin <dmitry@mylovecompany.com>
Subject: Textconv
Date: Mon, 11 Mar 2013 13:46:09 +0400
Message-ID: <513DA7E1.7050206@mylovecompany.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 10:46:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEzJY-00037O-RU
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 10:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab3CKJqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 05:46:15 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:37534 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362Ab3CKJqO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 05:46:14 -0400
Received: by mail-la0-f49.google.com with SMTP id fs13so3582720lab.22
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mylovecompany.com; s=google;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=7zuNIX2YjnlkuzSsZx0dCDsHPL41Zb1t78+DB33G3i8=;
        b=ON2zfGzHFPMK0vZpbK+4NbPrzYnQjTYCQ16R/xD2kyn+bCOHdvpONdrolziq9eJcWj
         lFpxmO4HKTTFFS2mpxLqPWf5Zi6yW0eRCIzlUtWF5F/CxyPNNb84atosHtZ67rKiDYQ0
         3OYHMt4cOiMgDtOx619y9KQYpW2RD3J/G5Y9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=7zuNIX2YjnlkuzSsZx0dCDsHPL41Zb1t78+DB33G3i8=;
        b=kWRS7DMclVyEiVICNNxWpBbG4rbc/bjMcjAdqCW1Dfr7U/TzTUYZVsagH+B6yeX9WE
         xNVsiQsA0Pu9fUCycTmTcS7yNqHeBkcKyUAoVBozlhlbOFEhgsz4+re42ALXc8AxWabk
         rScS7Qwyx4WjReBoilhoxnqVTnOOrRXVHBCbhHyIafYoLti3xoKT++nfRwBc4A6jg7Rt
         tUxIa4wNn6UBfeUERHr3hv+swbdq47jWGfom5UBv9SoZAQ3FXiaGJ3wxLL0Raf6WgyGP
         OcskqtWOu2RjFxoo3KOe8r9kswAeWUGYEM/ZtgdmWNnAYxcfroXlmJ1iI2mdRM3RSN/o
         FZ6A==
X-Received: by 10.152.48.113 with SMTP id k17mr9652376lan.29.1362995172486;
        Mon, 11 Mar 2013 02:46:12 -0700 (PDT)
Received: from [192.168.1.11] (broadband-178-140-233-175.nationalcablenetworks.ru. [178.140.233.175])
        by mx.google.com with ESMTPS id gm20sm6964195lab.7.2013.03.11.02.46.10
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 02:46:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
X-Gm-Message-State: ALoCoQnlRMsjCGylE+3FtH09Aw9Waizv+4eDofc3xmEPAcVc4Ko7aGbSuuodD/1Nismf3BFGwv6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217863>

Hello!

Most of GUI for Git using 'git show' command to show differences between 
versions. For example: WebStorm IDE. But for now there is no way to 
specify text conversion command in git config for 'show' as it done for 
'diff'. It makes problems when we dealing with encrypted repositories.

Is there any alternative way to configure git repository? Or if it 
impossible will you implement such kind of feature?
