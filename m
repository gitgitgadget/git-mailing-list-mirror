From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 2/5] Use variables for the lists of tools that support
 merging / diffing
Date: Mon, 23 Jul 2012 20:30:37 +0200
Message-ID: <500D984D.4070909@gmail.com>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com> <500CFAB4.4050905@gmail.com> <7vvchemnmn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:30:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNP9-0002Rx-SF
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754568Ab2GWSap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:30:45 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:54928 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab2GWSap (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:30:45 -0400
Received: by weyx8 with SMTP id x8so4471393wey.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=G93C416UusWXt5j+4tOJyD2Ik+9ZVImb4V8RD80kGNc=;
        b=02P3/1vplGGKHnrUgxBPhgFpOF04RGXMm2B/Incj+SsAVPyhn4OybZaVnPjp9Rapcp
         KWezbBdp2IiaiAmKimldZl1MbHoS7hkeI5cqHJ7W4W6QeK8UONcRP6B7NtHjC2TySzv/
         9piS3kJprIunlk8W76mJwkxpi8e6mNxmOBpVK3nMndAnLf/F85y4PnFHKsP0xw7ME3vA
         h6aEKXyMj705554dVbNXUkMpvOu9yzO7dVL3vRSqsymfcErM1z8WnvvVrgVGMheVZaFy
         nXEv9TfasEWvENONJfqtQWq7PxqztmWEuw/gMxT2ioFjtbdv8FlpadsWuaBoHTS+1eWv
         Kakw==
Received: by 10.180.90.207 with SMTP id by15mr51310868wib.22.1343068243942;
        Mon, 23 Jul 2012 11:30:43 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB0653.dip0.t-ipconnect.de. [93.219.6.83])
        by mx.google.com with ESMTPS id de10sm18147325wib.7.2012.07.23.11.30.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 11:30:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vvchemnmn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201951>

On 23.07.2012 18:46, Junio C Hamano wrote:

>> +# Tools that support both merging and diffing.
>>   __git_mergetools_common="araxis bc3 diffuse ecmerge emerge gvimdiff
>>   			kdiff3 meld opendiff p4merge tkdiff vimdiff xxdiff
>>   "
> 
> As the set of merge capable tools is not a superset of diff capable
> tools (tortoise can only merge but not diff), perhaps rename this to
> __git_diffmerge_tools or something?

Makes perfect sense.

> This patch makes sense to me, but at the same time makes [PATCH 1/5]
> a "Meh", methinks.

Yeah, I can see why. So I've renamed __git_mergetools_common to __git_diffmerge_tools and squashed with [PATCH 1/5] to make it less "Meh" as it does not stand on its own.

-- 
Sebastian
