From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2015, #07; Fri, 20)
Date: Fri, 20 Mar 2015 16:24:16 -0700
Message-ID: <423416FC-1048-4D3A-B997-F1F796627242@gmail.com>
References: <xmqqr3sjcopt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 00:24:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ6HA-0008VN-0v
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 00:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbbCTXYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 19:24:19 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33366 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbbCTXYT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 19:24:19 -0400
Received: by pdnc3 with SMTP id c3so122074719pdn.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 16:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=7hQetPjgWF/XMJMY1ekY3goJ9HTKPL+L47KNiRefXuM=;
        b=deBe0eFVEcRW72k2M36Hwi0Kuoj9JWSOTuW3QgzDT0eCybVmoZ8sjSPIcFWB8LJCE8
         LYrHF/z2lBkspk5tFVFhtpRgQwQfesexhh0EAdYhk8Z6GDBxnWfc2SFNRV2203qZlNqX
         mjtcTJHvTUcvu5ptQfHfQL3BxPHinCpVoLdlDtWdSaDNqOlqu0iffsAtrPNN2LEw8nNs
         DrYAavXJQ3lqjRRmdc5ISwmNYSxhIzIW7DgWkUp6ysXKBZS7ZE7Mqzdo+WTu3BlypWQ+
         SBQaqTgomMrwBeXkdkpsIQevDbzYc5m2SDPQgCHnNxa3rNgyMfzqziEFdpjclXAq2i7v
         JRUw==
X-Received: by 10.69.12.199 with SMTP id es7mr624305pbd.138.1426893858665;
        Fri, 20 Mar 2015 16:24:18 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id fl4sm9838824pab.8.2015.03.20.16.24.17
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 16:24:17 -0700 (PDT)
In-Reply-To: <xmqqr3sjcopt.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265979>

On Mar 20, 2015, at 15:02, Junio C Hamano wrote:

> * bc/object-id (2015-03-13) 10 commits
> - apply: convert threeway_stage to object_id
> - patch-id: convert to use struct object_id
> - commit: convert parts to struct object_id
> - diff: convert struct combine_diff_path to object_id
> - bulk-checkin.c: convert to use struct object_id
> - zip: use GIT_SHA1_HEXSZ for trailers
> - archive.c: convert to use struct object_id
> - bisect.c: convert leaf functions to use struct object_id
> - define utility functions for object IDs
> - define a structure for object IDs
>
> Identify parts of the code that knows that we use SHA-1 hash to
> name our objects too much, and use (1) symbolic constants instead
> of hardcoded 20 as byte count and/or (2) use struct object_id
> instead of unsigned char [20] for object names.
>
> Will cook in 'next'.
>

Has this been merged to 'next'?  Even fetching github.com/gitster/ 
git.git I'm only seeing it in pu:

$ git rev-parse bc/object-id
d07d4ab401173a10173f2747cf5e0f074b6d2b39

$ git branch --contains d07d4ab401173a10173f2747cf5e0f074b6d2b39 --all
   bc/object-id
   jch
   pu
   remotes/github2/pu
   remotes/gob-private/pu
   remotes/gph/pu
   remotes/ko/pu
   remotes/repo/pu

-Kyle
