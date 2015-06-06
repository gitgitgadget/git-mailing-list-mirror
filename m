From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v5 0/10] create ref-filter from for-each-ref
Date: Sat, 06 Jun 2015 12:34:24 +0530
Message-ID: <55729B78.1070207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 09:10:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z18F8-0002oC-Uv
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 09:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbbFFHEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 03:04:33 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36026 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbFFHEb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 03:04:31 -0400
Received: by pdjm12 with SMTP id m12so66972763pdj.3
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 00:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=qOtOCJkk0QOYEfPedpJ8kVjRrcpQ51LLPnRn6ptRgz0=;
        b=GOYwWtsSM25NsTpGBIciBdY4uthKIH2dfZF8CN01V4Jla7hcVtiALd78LiEjLWVDLK
         tFlt3UA+73aX9/Hd2dKOBo8WWGS/j/lQF9OFqEUvUJ4yrKVjjfmkJF2Ip0W1NS9pXCkh
         ocdMDJDE0BXT9od7R2EINB80kdfnap7FkPjtJLsbNhsB+tq/ijONruFEHF1VdJD3hc5x
         vZ6lL5Fqn/3BGinam/U9Zm17go38nxf/poWpLsEMXM/Ja0ltUnyOwE+tS8UEP4fWbRJC
         c8qzNUcseujrVRVw5StT/S72B5xpDfOk0FntcTtMrAINGzzQfpmZr3+hHKYew1Ea0m4n
         rHsg==
X-Received: by 10.66.243.69 with SMTP id ww5mr12160049pac.106.1433574267967;
        Sat, 06 Jun 2015 00:04:27 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id np9sm8661653pdb.9.2015.06.06.00.04.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2015 00:04:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270903>

Version for of this patch can be found here :
http://www.mail-archive.com/git@vger.kernel.org/msg70280.html

Changes in this version:
*	Rename functions to better suit the code.
*	implement filter_refs()
*	use FLEX_ARRAY for refname
*	other small changes
-- 
Regards,
Karthik
