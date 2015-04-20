From: Dmitry Gutov <dgutov@yandex.ru>
Subject: How do I resolve conflict after popping stash without adding
 the file to index?
Date: Tue, 21 Apr 2015 00:02:54 +0300
Message-ID: <5535697E.2030204@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 23:03:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkIqS-0000Ei-18
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 23:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbbDTVDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 17:03:03 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37078 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbDTVDC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 17:03:02 -0400
Received: by widdi4 with SMTP id di4so106751339wid.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 14:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=JBM1116JZE5Mi8ubPwEVPniHkWfIR4AG+ayfs3ck1u4=;
        b=P6+1LPMm1XnS3W2B2nQS/7yOz4/fehax3MApgModWvZIZInPYO5ygxx9/2+zKZhVV7
         VKbIWsgXOvS82An8EvN354xuQG5HHOFHukuA9zlTB2fikzincpxHP0sZsKPdEu5QLzTW
         4h52fERxZJ3j8K0cfXO8Ew4p7Es1iHMluS60/hyAs071aRxCSXSVq/iKAaWNtgm2H8yw
         82Wv7z7Ojh1Y8e/e/GYWgQUBxPM3sIr5QWrH6orGnGrNPTAP81x/u6IAXxBTlaCXQN7I
         h4EyoNMAHCePyQhGvt6cFJIXHKKBhck7ArcYLdK6y+szHFo3h0zSC7s5OrfsaPaqlMfy
         o+fw==
X-Received: by 10.180.76.231 with SMTP id n7mr14213988wiw.44.1429563780609;
        Mon, 20 Apr 2015 14:03:00 -0700 (PDT)
Received: from [192.168.1.2] ([82.102.93.54])
        by mx.google.com with ESMTPSA id xy2sm28837111wjc.14.2015.04.20.14.02.59
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2015 14:02:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:36.0) Gecko/20100101 Thunderbird/36.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267500>

Hi all,

After the user does 'git stash pop', it may result in conflicts.

However, in many cases they may not intend to commit the stashed changes 
right away, so staging the applied changes is often not what they intend 
to do. However, the conflict is there until you mark it as resolved.

What's the proper thing to do there? 'git add file.ext' followed by 'git 
reset file.ext'? Or simply 'git reset file.ext'?

Either will reset already-staged changes from the said file, which is an 
irreversible operation.

Best regards,
Dmitry.
