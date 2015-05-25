From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP][Patch v2 0/2] Ref-filter: unification of 'tag -l', 'branch
 -l' and 'for-each-ref'
Date: Mon, 25 May 2015 18:09:20 +0530
Message-ID: <556317F8.2070609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 25 14:39:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwrfH-0007Ip-ES
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 14:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630AbbEYMj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 08:39:26 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35014 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbbEYMjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 08:39:25 -0400
Received: by pdea3 with SMTP id a3so69315749pde.2
        for <git@vger.kernel.org>; Mon, 25 May 2015 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=hGcq2JSetibpJV/VpYQT+GPkafID5VqjGJCyudrOfbA=;
        b=qVH0QdCT54KQbF9YiizKB6LqjUS+mVtyKnJjkC75eG9aALe6bwt539lC2alEHlcmFO
         Vt7ir061b05pInPhqrNMh/Jw6MU8RpCmrdPDOnNZWk3kG2E+nl0Bpi+GYP1AsHfmfG3H
         09/tKAVV2GOAToRzXjvH1PgArIBvap+4H2hJHXqnvNJhOwaviDnerexqHpiBdXuVJyoM
         hYDRVXxXzYt6sULkZrudO4dn3MFxFh2YFEPlRrtG9e1MuysArRRFK9cmZzKbTEIYEjPz
         6GPeQYT77EmCvZysPK2mR//M5U9LV4hbGeJ+wdUpvHZIOquDXITYFyB4cTqKl3HmRR9+
         P/VA==
X-Received: by 10.70.48.68 with SMTP id j4mr39418129pdn.111.1432557565352;
        Mon, 25 May 2015 05:39:25 -0700 (PDT)
Received: from [192.168.0.106] ([103.227.99.94])
        by mx.google.com with ESMTPSA id wt1sm9998505pbc.4.2015.05.25.05.39.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2015 05:39:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269836>

Hello,

After the 1st version of the WIP patch ($gmane/269461) this is a follow up.

Changes since 1st version :
*	restructure to have 'struct ref_filter_data' which has a list of refs 
'struct ref_list list', and the filters to apply 'struct ref_filter filter'
*	reformat the commit to be better structured and easier to track
and more 'git blame' friendly.
*	other small changes.

Also I'll be maintaining a repo on Github where I'll be pushing code 
more often. https://github.com/KarthikNayak/git

--

Regards,
Karthik
