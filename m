From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 03/12] for-each-ref: change comment in ref_sort
Date: Fri, 12 Jun 2015 23:59:42 +0530
Message-ID: <557B2516.7020609@gmail.com>
References: <5579B253.4020804@gmail.com>
 <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
 <1434039003-10928-3-git-send-email-karthik.188@gmail.com>
 <xmqqy4joddul.fsf@gitster.dls.corp.google.com> <557B1B60.9020002@gmail.com>
 <xmqqpp50dcqy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 20:30:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3Tic-0002AU-P7
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 20:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbbFLS3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 14:29:47 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35518 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbbFLS3q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 14:29:46 -0400
Received: by pabli10 with SMTP id li10so7980635pab.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=KXEV+SwZsZ2G2K/DxSqgeJ3PTQPtY4TrCDcEx1H71Fc=;
        b=w0RikqnJG2/QhIqr94mgfPSBAC86tjC3NwkHTgEBIcCW0KTNSJbGtoG9smykGnnSHU
         3wMIh6qA3gKwynkNU7Wfe3MNuC9OIJqSLrHHno/xRC2L2gDQ9czlAJ8KG9pDRM3eCkO/
         8Ofe7/It1D/vwGoryCCtm6/5zSCH+AeSv0kwcdWf1mLAXrfwwnYSYEXLGY3yKUSJpz3X
         BXRgqpZiKmdZWN2aoCi8s9f647BMSHINffFUqi1wJ7g4na7QKYLDOOdGph4y/VJ4TrpJ
         cNWbCcQJYu3WkWHIJiPybqqxiTuSG0YU5ruucv4oETvmm5ONLqLr8IOGxkdNcctzqxg3
         cg4A==
X-Received: by 10.70.92.4 with SMTP id ci4mr25404721pdb.33.1434133786363;
        Fri, 12 Jun 2015 11:29:46 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ot3sm4355570pbb.4.2015.06.12.11.29.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2015 11:29:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <xmqqpp50dcqy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271511>

On 06/12/2015 11:34 PM, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> What change since 9f613dd do you have in mind, exactly, though?
>>
>> Well initially the atoms were indexed into used_atom array, which
>> later was removed. Hence the comment becomes obsolete.
>
> Later in which commit?  In builtin/for-each-ref.c in the version
> after applying patches 1-3 of this series on top of master, I still
> see used_atom[] array there, so...?
>

Uh! My bad.
Ignore this! I think I got confused, On having a look now that patch is
not needed. Sorry.

-- 
Regards,
Karthik
