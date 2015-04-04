From: Martin d'Anjou <martin.danjou14@gmail.com>
Subject: Re: gitk drawing bug
Date: Fri, 03 Apr 2015 21:28:00 -0400
Message-ID: <551F3E20.5010306@gmail.com>
References: <CACZ2eqdm_DXfa0o9J3NXfxD0XG-iAbPNUhySg026qhkqZAYWJA@mail.gmail.com> <CAMMLpeQ3J_x5xee=V+Sn4=FTRNM-yQSm_yXSwFpiCNJz2AD7Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Git mailing list <git@vger.kernel.org>
To: Alex Henrie <alexhenrie24@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 03:28:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeCsc-0002qC-9K
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 03:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbbDDB2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 21:28:06 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34930 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbbDDB2F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 21:28:05 -0400
Received: by patj18 with SMTP id j18so132309911pat.2
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 18:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0FS6cpUWamzvARyUkGxthbqH1TsR8Rb8kDcpEc2WYJE=;
        b=n4z97H4LCeRIIqT6iVw+AUCxARd6uouCmrEKCLST3Zb4f/7d5GLTnEWGdSjyn+qbLF
         h4M9Z0trq/0LwftTb6jQYTKSJSnM4sK7tflTnmXUT/IUhzYqYLyxKNL8pyN5LsMnUcc9
         2XEuPGpfnsnlWAaBdb8CIXkmQ6t8Qv4gh5BH0DKP9D3IpezswpZhTDCIUI64MABMUCqW
         4vCcN1GoXMJEqmvyN9Z21sQTFF8FUrzLxUiXlPB1UW9qjMSmFFXiqBZAfelZyGrgeDGN
         jzXwWn277AoJg5q09rByN5Kmo405nhWYxvz+L3d38VNeJds3FfGN1jEJisustaD3Yna+
         2eng==
X-Received: by 10.66.148.165 with SMTP id tt5mr8468984pab.38.1428110884458;
        Fri, 03 Apr 2015 18:28:04 -0700 (PDT)
Received: from [192.168.1.151] ([184.175.20.107])
        by mx.google.com with ESMTPSA id t5sm9285469pde.51.2015.04.03.18.28.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 18:28:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAMMLpeQ3J_x5xee=V+Sn4=FTRNM-yQSm_yXSwFpiCNJz2AD7Gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266757>

On 15-04-03 07:05 PM, Alex Henrie wrote:
> 2015-02-18 12:27 GMT-07:00 Martin d'Anjou <martin.danjou14@gmail.com>:
>> It appears I have uncovered inconsistent behaviour in gitk. Looks like
>> a bug. I have a picture here:
>> https://docs.google.com/document/d/19TTzGD94B9EEIrVU5mRMjfJFvF5Ar3MlPblRJfP5OdQ/edit?usp=sharing
>>
>> Essentially, when I hit shift-F5, it sometimes draw the history
>> differently (still valid, but drawn differently). There is no change
>> in the repository between the shift-F5 keystrokes.
> Did you ever contact the gitk maintainer, Paul Mackerras
> <paulus@samba.org>, about this bug?
>
> -Alex
I do not remember contacting Paul Mackerras, but thank you for doing so.

Martin
