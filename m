From: Harry Jeffery <harry@exec64.co.uk>
Subject: git log --author=me
Date: Mon, 2 Nov 2015 13:27:20 +0000
Message-ID: <563764B8.4010101@exec64.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 02 14:34:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtFG6-0001oA-Kb
	for gcvg-git-2@plane.gmane.org; Mon, 02 Nov 2015 14:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbbKBNeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 08:34:46 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33619 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbbKBNep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 08:34:45 -0500
Received: by wmeg8 with SMTP id g8so59278446wme.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 05:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exec64_co_uk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=CwDuoT2s3QPFCpS4isVT3pK8LcRHayOC1oBfBY8zTf4=;
        b=P+nJxhUsIy1EMVvOYLj9F+jmzc4tK996gfj0ENgUlbdIhcCfN7YX9SOm7Os3EFN/IW
         vEV1gKLT56swhdFzoujkWRPVKAyCb5FKjaY8kfuRDXtBHeWDrbCJCPsycno0h//G2103
         ydM4PuCVFFUZt5OsNlkOGcdv8uYin/iA4WeN++2XtCSxSC8D29PEfymMxli08uzoTHmN
         RGhvISbKhwIp0anXf7qt+78dO2rym0uVjEXCkVm6H8wXQ3WBw51p6drrfhh1X4nyxB4P
         vfEYLOXY4u3dV50R2YKSAJG+8M9DywgrZwjFhO12uJUAUva+x3FHg4ugqabRzH+3pxC8
         6f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=CwDuoT2s3QPFCpS4isVT3pK8LcRHayOC1oBfBY8zTf4=;
        b=NRO+IJZPa/WtJnauxJJw8bJM/D+mIxr3bk96uv8tu4zVfl/rg5n2xx4Ykr6gM9kUYT
         NEKRQUUt+TTD/I4caA5AL/w7SrW+LNxVpuqvbfAIrKPl+ATTX021/gmRnaowTRYBeHci
         FkXERA5kXuHNQphDm+QwusXQtbo+/ukT0qVsEk9l2K/N9O+aGVPfF/JMc0SYFR++99Dg
         Cm+srIBZFUDcRSKHm7B1PFVqgviYLMUJzfyDQ489lpYMIWUwlMDPFiNFlW1hlB4n5UHP
         Ai5XLDjN0e1zgl2D+jIa8bRF1X/fbX/bjp17g7ZQgLAUUYzrbBGudNChs+ozPa7t1Uo/
         yKSA==
X-Gm-Message-State: ALoCoQlHIq+XI8LeLKS8kKMihogoYUBizcnum+nefMNbebYbpWihVJ7+GV+LdS94t2QIskQiVCuQ
X-Received: by 10.28.218.83 with SMTP id r80mr14526618wmg.55.1446470848272;
        Mon, 02 Nov 2015 05:27:28 -0800 (PST)
Received: from [192.168.43.34] (92.40.248.232.threembb.co.uk. [92.40.248.232])
        by smtp.googlemail.com with ESMTPSA id it4sm22403679wjb.0.2015.11.02.05.27.27
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 05:27:27 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280689>

Hi,

I've written a patch that allows `me` to be used as shorthand for 
$(user.name) or $(user.email) in the `--author` and `--commiter` fields.

The purpose being to make finding your own commits quicker and easier:
     git log --author=me

Is this a change that would be accepted if submitted? The only thing 
it's currently missing is unit tests.

Regards,
Harry
