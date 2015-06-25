From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git name-rev not accepting abbreviated SHA with --stdin
Date: Thu, 25 Jun 2015 07:31:08 +0530
Message-ID: <558B60E4.9020604@gmail.com>
References: <558A2405.2090709@gmail.com> <xmqqsi9g8x51.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 04:01:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7wTf-0005SU-O9
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 04:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbbFYCBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 22:01:16 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33964 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbbFYCBO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 22:01:14 -0400
Received: by pabvl15 with SMTP id vl15so39944742pab.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 19:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=glGYK2XWNM3vYbf3aI7xFT2vWRSI2QBWZHFZh5nSz0c=;
        b=G6QMO28hCI6rYwHKaI/KxvgjdQ/8YWK1z2KDo6ttWwjRGZOnm914Rp1QqmvJhAF00C
         Tk6Mxwq3xuQof0yL1OI0sBsDO1LVnLKUadt0tHumeB6vbQoEdAOZWOoBa3/4LBBt91lG
         hL2nObuxgxFz+cyrYVGAQ83TUa3CqSRlP71RwwrfyaSBD5w7wICGQH3RmCG3ILqBKgwY
         rTlOWt43qRBSZtniqLr63VkqHpnTWePRwxGuaDNd3pevRGC0t5ojAiTKbxqPCOHcVO2W
         x752olYZuYN9Vkb1wRRKST2SW6NSQW2GrXZfYUAzl89QBkNXO89I7B+zwGvzZD/TMHIk
         ulig==
X-Received: by 10.70.54.196 with SMTP id l4mr84875042pdp.2.1435197672543;
        Wed, 24 Jun 2015 19:01:12 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.177.30])
        by mx.google.com with ESMTPSA id i10sm28140949pdr.78.2015.06.24.19.01.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2015 19:01:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqsi9g8x51.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272633>

On 06/25/2015 05:41 AM, Junio C Hamano wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
> 
>> This *is* documented, but I'm curious why this distinction is made.
> 
> I think it is from mere laziness, and also in a smaller degree
> coming from an expectation that --stdin would be fed by another
> script like rev-list where feeding full 40-hex is less work than
> feeding unique abbreviated prefix.

Makes sense; thanks.  Maybe if I feel really adventurous I will,
one day, look at the code :-)
