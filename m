Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C566718E02
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C91CBA6
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 11:44:25 -0700 (PDT)
Received: from [192.168.5.3] (c-73-70-62-113.hsd1.ca.comcast.net [73.70.62.113])
	(authenticated bits=0)
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 3A1IiPti024046
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <git@vger.kernel.org>; Wed, 1 Nov 2023 11:44:25 -0700 (PDT)
	(envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-70-62-113.hsd1.ca.comcast.net [73.70.62.113] claimed to be [192.168.5.3]
Message-ID: <5c8a94e6-6691-45e6-bcb3-04fa472ae9ad@rawbw.com>
Date: Wed, 1 Nov 2023 11:44:24 -0700
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Git Mailing List <git@vger.kernel.org>
From: Yuri <yuri@rawbw.com>
Subject: 'git stash' in one subfolder fails because some other subfolder has
 unmerged files
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Here is the log:

[yuri@yv /usr/ports/audio/giada]$ git stash push -m "audio/giada: Update 
to 0.26.0 has run-time issues" -- /usr/ports/audio/gia
da
audio/triceratops-lv2/Makefile: needs merge
audio/triceratops-lv2/pkg-descr: needs merge
audio/triceratops-lv2/pkg-plist: needs merge
science/py-dftbplus/Makefile: needs merge
science/py-dftbplus/distinfo: needs merge
science/py-dftbplus/pkg-descr: needs merge






I asked git to stash only the audio/giada subfolder. Unmerged files in 
science/py-dftbplus and audio/triceratops-lv2 shouldn't prevent stashing 
files in audio/giada.







I believe that this is a bug.







Thanks,
Yuri

