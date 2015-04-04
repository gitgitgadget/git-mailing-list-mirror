From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 0/4] cat-file: add a '--literally' option
Date: Sat, 04 Apr 2015 09:43:00 +0530
Message-ID: <551F64CC.2030208@gmail.com>
References: <551D1F99.5040306@gmail.com> <xmqq384ijmj7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 06:13:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeFSV-0007qa-UM
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 06:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbbDDENG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 00:13:06 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34037 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbDDENG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 00:13:06 -0400
Received: by pdbni2 with SMTP id ni2so141272630pdb.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 21:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=02yVv1W2wjfB5LQWAQmVknwoEIuCRD4/4fAL5u8ZsWk=;
        b=MJGy9tM8rpIVLMshMWd6HoEuOXAdVMspg6GN3CuKiIxIakP4vD+hh9LjPsUJ0rPh2k
         3uAS1XHNURSBVG/KuSdFd+QZq7ye6HM1ezDb+MeRXk2QlgcBlmyxGxXSBZzGvTWofUvp
         MOa5LVSCKsYTALFe6rtE8HWla1gcEXs+t4GjP5I1ti6iV6j2dZN14Kld7oOFiMMVX2yy
         QbsH2VOdlJyfoamV6BraSXIl2oGz7l9CtrJUo8K4mJUDqRtqAYQn0rojH80oON5Kac+K
         cTfxipDvuBpJElh7xGutwGgs/JN3Di9lR7NLSq1BLknjLDWG7/Uvxoy7NzUKpYJo0OEv
         h+/A==
X-Received: by 10.66.66.166 with SMTP id g6mr1439123pat.88.1428120785480;
        Fri, 03 Apr 2015 21:13:05 -0700 (PDT)
Received: from [192.168.0.103] ([103.227.98.178])
        by mx.google.com with ESMTPSA id qm6sm9569385pac.14.2015.04.03.21.13.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 21:13:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqq384ijmj7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266760>



On 04/03/2015 02:05 AM, Junio C Hamano wrote:
> When merged to 'pu', this seems to break at least 5309 and 5300
> tests (there might be others, but I didn't check).
>

There was a problem with packed object types. I have it fixed, will send 
a re-roll.
