From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/4] for-each-ref: rename refinfo members to match similar
 structures
Date: Thu, 21 May 2015 11:57:58 +0530
Message-ID: <555D7AEE.7080201@gmail.com>
References: <555C88C2.8060902@gmail.com>	<1432127904-21070-1-git-send-email-karthik.188@gmail.com> <vpqtwv7qj92.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 21 08:28:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvJxh-00080Q-ES
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 08:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbbEUG2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 02:28:05 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36551 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbEUG2D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 02:28:03 -0400
Received: by pabts4 with SMTP id ts4so94432117pab.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 23:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NJhx3sCMSFpY6lUJoa7wAPiWgK/BqDTtjlPNW/SpCWc=;
        b=vFR8iFX5oK+rslIYrB1MOUv/+IgOjXWo18Ppw6Q+o8e9FiaJOhCFTQAgb88JvgheU7
         z1Pn8iOowBqS/lzXbPSUPbgB47KKQBIgop7uCfy8b1eOCH8przF7/o18xpAiGYeCeVyi
         lkM3CQPX+peFgYNaW5y6VdLrvV+kiWRNilYnuEzBYhymp73cNkJVEd4xLEI3LzQfsfZl
         oUK0YgTObDm1PkLh7PPzjYesgp8rIIzzWOvfofBHuLYQnYVVdLegwKYGF9JBQW6mJp8j
         sC+VmXY/+qNVs966BLzQPJXUlv877WOhINSXzEalcu7GxmBjjkGm100OZk6FAi0dohxk
         hxXQ==
X-Received: by 10.70.130.198 with SMTP id og6mr2407279pdb.153.1432189682780;
        Wed, 20 May 2015 23:28:02 -0700 (PDT)
Received: from [192.168.0.104] ([103.227.98.178])
        by mx.google.com with ESMTPSA id l14sm18034004pdn.96.2015.05.20.23.28.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 23:28:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqtwv7qj92.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269561>



On 05/20/2015 10:27 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> From: Jeff King <peff@peff.net>
>
> This means that "git am" will consider Peff as the author ...
>
>> Written-by: Jeff King <peff@peff.net>
>
> ... hence this is not needed: in the final history, it will appear as if
> Peff wrote this Written-by: himself, which would be weird.
>
> If it is the case, you should add in the commit message that there's no
> actual changs, and perhaps which renames were done. This makes the
> review straightforward.
>

Noted, will change it.
