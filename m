From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Thu, 21 May 2015 23:29:03 +0530
Message-ID: <555E1CE7.8090507@gmail.com>
References: <555C88C2.8060902@gmail.com>	<1432127904-21070-2-git-send-email-karthik.188@gmail.com> <vpqr3qagvv6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 21 19:59:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUkT-0003xP-Sb
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829AbbEUR7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 13:59:09 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36042 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbEUR7H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:59:07 -0400
Received: by pdfh10 with SMTP id h10so115783324pdf.3
        for <git@vger.kernel.org>; Thu, 21 May 2015 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Xbv2JrovuYkLh1cLeoHXrADLfSnzwW9OWKJ5nilirwM=;
        b=q/kmZGbShHh5Dy5J4mSfJzKg96UDgjBNSNl3wHeEFDNB9yVGd/QaoLjaRmbqtiN014
         74PXYZGvlvl3GvOr4OiwJyXV7hxGrOWkgtre2mkChOcU3t4KZ22cGDKS/bAKo6JCDYTZ
         lUTJ7vkN160Ft5uVvZemUkPibbf5JdjiMudZODwLFWr8QXZhqQ4r8xLlzpqAxmXbqvYA
         vsD4sRX9lZ6blQkfS2dVi2R02PkK4UMsdyvRIbNJ3/2JsOo650VbbOT9HxlHsRMmHD5Z
         QpFLpmhJGDhpUkm4mG16+87mpG74zg930nd8v6dYqW5YR+YHRYapajqwq7bHMyWmEtiR
         /BLw==
X-Received: by 10.66.66.173 with SMTP id g13mr7901729pat.155.1432231147072;
        Thu, 21 May 2015 10:59:07 -0700 (PDT)
Received: from [192.168.0.104] ([103.227.98.178])
        by mx.google.com with ESMTPSA id wa4sm19954829pab.17.2015.05.21.10.59.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2015 10:59:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqr3qagvv6.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269629>


> I miss a high-level description of what the code is doing. Essentially,
> there's the complete repository list of refs, and you want to filter
> only some of them, right?
>
>  From the name, I would guess that ref_filter is the structure describing
> how you are filtering, but from the code it seems to be the list you're
> filtering, not the filter.

Reading this again, A bit confused by what you're trying to imply. Could 
you rephrase please?
