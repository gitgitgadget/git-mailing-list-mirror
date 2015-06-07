From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 0/11] create ref-filter from for-each-ref
Date: Sun, 07 Jun 2015 17:33:41 +0530
Message-ID: <5574331D.3020705@gmail.com>
References: <5572F904.1080608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 14:04:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ZJM-000520-09
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 14:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbbFGMDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 08:03:47 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35884 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbbFGMDq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 08:03:46 -0400
Received: by pdjm12 with SMTP id m12so82270768pdj.3
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 05:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=uQyKczuyBwWZ8mm8J8FU1dIlywCCBBdAvZmhRoxndVI=;
        b=han0l0VpxKDoiBR0/qQQlPHETcz7uVI0I7kPrI6iISCDrj1dvXld5JaS7HKl3ocqPJ
         W6GG4WwFZElKBcjDCNMGfl5jmlpwB/Sxbbw92lvI0tJ/PKgHM+FCpv2M/GHSvxCXvjGv
         H8JhxlDmUDNXqzLuZhGy3fWlyyPeMeANaKuJ4DYFNtElJR/L5MtH65R+U0OLpepJEDR2
         G7VS9cx0W8qUhB9BvfeS98K7tYAalCT3OsmdGAcyDcQevUZjrrOmZcgqyz4vWdiSdN1l
         oW4qTiBQsnD8rfKfMW/8BZfKhbvoU+rY1taWvIttHUxmA46FK3sBzDgB/EyJEsYMHCY/
         JIGw==
X-Received: by 10.70.101.106 with SMTP id ff10mr21201797pdb.162.1433678625667;
        Sun, 07 Jun 2015 05:03:45 -0700 (PDT)
Received: from [192.168.0.104] ([106.51.130.23])
        by mx.google.com with ESMTPSA id xv9sm11683274pbc.2.2015.06.07.05.03.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2015 05:03:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <5572F904.1080608@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270967>

On 06/06/2015 07:13 PM, Karthik Nayak wrote:
> Version four of this patch can be found here :
> http://www.mail-archive.com/git@vger.kernel.org/msg70280.html
>
> v5 : http://www.mail-archive.com/git@vger.kernel.org/msg70888.html
>
> Changes in v5:
> *    Rename functions to better suit the code.
> *    implement filter_refs()
> *    use FLEX_ARRAY for refname
> *    other small changes
>
> Changes in v6:
> *    based on latest master branch (github.com/git/git)
> *    rename variables named sort to sorting.

Patch 09/11 and 10/11 had a some code swapped, weird. Have mailed
new patches.

-- 
Regards,
Karthik
