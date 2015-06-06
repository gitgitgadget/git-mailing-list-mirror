From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 0/9] add options to ref-filter
Date: Sun, 07 Jun 2015 01:33:22 +0530
Message-ID: <5573520A.90603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 22:03:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1KJa-0001RN-RC
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 22:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbbFFUD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 16:03:28 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35994 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954AbbFFUD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 16:03:27 -0400
Received: by pabqy3 with SMTP id qy3so69162617pab.3
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 13:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=GaSC96lb1SGE+Fhmx9LJtt8hM8ZsOzmKWoNgbL3d5Sg=;
        b=m5U19df662Hx2sJYkLYSSSchY1aGfkc/F8SbMjQT9Eh+8jp4kFANIdLw4SWQHUIylA
         vOncPdZMa1yG4RMiFauzp43ut2pmDouovxNb6o/DI1xQsP5dxWkyyZiBJaXh7CA37jKV
         AyWvR4VjWmKCKVIzTGWuKJtZIJOTK/FzuGahIR/awL+5tIHZgGnnI5HvlOwDgEkwqV92
         EO7/VacMVQLMsjHuJod2xuuVCd8+h1K+Pj4QAtTdnYY1czZ6Qe/T3tVxxiHAXIFGrtm4
         NlUBWjID+tfejUu1W2tbLpQd+aaDfZG+D5bxaNiswvttX2TIl4flFYexrBIS2rE64iuT
         OYwQ==
X-Received: by 10.70.36.10 with SMTP id m10mr16266024pdj.34.1433621006561;
        Sat, 06 Jun 2015 13:03:26 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ms7sm10350471pdb.11.2015.06.06.13.03.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2015 13:03:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270942>

This is a follow up series to the one posted here
http://thread.gmane.org/gmane.comp.version-control.git/270922

This patch series adds '--ponints-at', '--merged', '--no-merged' and
'--contain' options to 'ref-filter' and uses these options in 
'for-each-ref'.

-- 
Regards,
Karthik
