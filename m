From: nn6eumtr <nn6eumtr@gmail.com>
Subject: disabling nls in git?
Date: Mon, 23 Jul 2012 00:21:11 -0400
Message-ID: <500CD137.3070109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 06:20:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StA8b-0000Gr-KF
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 06:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321Ab2GWEUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 00:20:46 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:45858 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab2GWEUq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 00:20:46 -0400
Received: by qaas11 with SMTP id s11so891276qaa.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 21:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=HLf06d4ypCab4E3bj0iv0UAnMW2jAyd/XGzyjsMTNCY=;
        b=sK+dBfTdGTMvwM7rNNoarSliHS9JfNFVuy1tHu1WYW1mlL1yj2vAWnHiHJVvIb1VmU
         Cr7pu6NbVQsInr6PDUubbctoCZWAWRrHWaSRYZ9LfWooRhBTZnhRtscPaLno1lCzrVRQ
         3DEfnuDdQh9P6y1LHf5KuTqHyzed3MPt++3fW6HGZXsTpsFsI0mQwsOFNjujhQhVWL+q
         KXIFIvRMhPxOa/nGWQn8TkURNk3rkz/sTd5dB8j75Waax7yJsyylhp+6f4vezbzOMevP
         MiahNMUGyoS4zh8C4M1AQgosktL5PTlS7CcmCFmmz+XRkKczeZH4eOUAIlRgcrnhF0/y
         wMnA==
Received: by 10.224.0.202 with SMTP id 10mr22726765qac.5.1343017245198;
        Sun, 22 Jul 2012 21:20:45 -0700 (PDT)
Received: from [192.168.0.3] (cpe-24-90-181-153.nyc.res.rr.com. [24.90.181.153])
        by mx.google.com with ESMTPS id gs4sm9626464qab.16.2012.07.22.21.20.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 21:20:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201892>

What is the best way to compile git without nls support?

It doesn't seem to be possible with configure, though running "make 
NO_GETTEXT=y" seems to work. Is there a more elegant way to do it?
