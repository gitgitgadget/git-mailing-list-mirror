From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 3/9] for-each-ref: add '--points-at' option
Date: Tue, 09 Jun 2015 00:21:42 +0530
Message-ID: <5575E43E.4030708@gmail.com>
References: <5573520A.90603@gmail.com>	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>	<1433621052-5588-3-git-send-email-karthik.188@gmail.com> <vpqlhfurtlb.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:52:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z229R-0001xk-94
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbbFHSvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:51:54 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33663 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbbFHSvq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:51:46 -0400
Received: by pdjn11 with SMTP id n11so72838640pdj.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=R5MPJMEF4J6ucTnH7I0WxlxAeml33VuALy1SaW9NnBw=;
        b=b26QGwZG1YZTCY5fZxZiiT6OtljuBwZE+X5SPGtJfK+aZpeDrtnUF/NXaA8lBw5wAE
         x3PoiGtu8a30BefO1AHlTpvp7J/SW/P9UaTGRomrdkkRABw06vFw886VUsXjZjCAiyDx
         HRhuDH3Bjt2+x9r7yQXEMGcrPUzzI0vVVZdYEkwMqhj17+SvNvNK2nz6XJPt6eLD+n6E
         RFx/zfJVXFVmWgnY0Ib/xRnMoG3vPPUU6lVwLa3CQ4BECliLMpYxa447LIoFZu/vk0Va
         iiU9IdAVaymJtm4BHzJ+rz/j4z/Z3R0gPtuVUsupvlvKgAkpDy9wnCx3M7B7rjjO69yu
         Q7Sw==
X-Received: by 10.70.135.106 with SMTP id pr10mr31501988pdb.156.1433789506366;
        Mon, 08 Jun 2015 11:51:46 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ap9sm3303258pad.42.2015.06.08.11.51.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 11:51:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqlhfurtlb.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271107>

On 06/08/2015 11:05 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Add the '--points-at' option provided by 'ref-filter'. The
>> option lets the user to pick only refs which point to a particular
>> commit.
>>
>> Add Documentation for the same.
>
> ... but no test?
>

No haven't written tests, this was just to ensure if the way this is 
moving forth is correct.

-- 
Regards,
Karthik
