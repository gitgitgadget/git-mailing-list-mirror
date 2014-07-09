From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v6 2/2] test-config: Add tests for the config_set API
Date: Wed, 09 Jul 2014 16:45:08 +0530
Message-ID: <53BD243C.6010907@gmail.com>
References: <1404719566-3368-1-git-send-email-tanayabh@gmail.com>	<1404719566-3368-3-git-send-email-tanayabh@gmail.com> <vpqvbr9w154.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 09 13:15:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4pqR-00008n-1b
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 13:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197AbaGILPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 07:15:20 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:41005 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbaGILPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 07:15:15 -0400
Received: by mail-pd0-f171.google.com with SMTP id fp1so8871247pdb.16
        for <git@vger.kernel.org>; Wed, 09 Jul 2014 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tFfK3UeFmgQ25P1C9vA3CJi/yZ2SW+wx0X5EP5Mp9j8=;
        b=NrM3V9GpQLuxxWlwiCnxwqVkykzZm1MOahoKxJUROqxQpG87RTmUPMAn6FoajC2kcw
         qatwmXEAUa7aQAY3bORm6B2RnBTviqu/z3++J3p+GJYtzv45g2hGTqAfT5Va2g2wU5Gr
         XvDqAhduekyxdBH30l4/yzDRQiDj5yv0SOOqmomsIKi3N3By6HMxrR3zrGtBNekVSVkL
         NZ43z1ZAYAUltdDW/oN+PF+8KZLU0xatSp+Shu/LtLf863fga7bBsO8k8zkYeeK7i8UF
         JpgzMJkPvoB+OMbIryBlsNxExgYewBYl/7rdMqRGJeKhCCgsEyP/Pk+7lMT0v3/Irh+Y
         u1Fw==
X-Received: by 10.66.253.101 with SMTP id zz5mr3348195pac.103.1404904515125;
        Wed, 09 Jul 2014 04:15:15 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.223.59])
        by mx.google.com with ESMTPSA id i10sm214588986pat.36.2014.07.09.04.15.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Jul 2014 04:15:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqvbr9w154.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253116>



On 7/7/2014 10:34 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> diff --git a/t/t1308-config-hash.sh b/t/t1308-config-hash.sh
>> new file mode 100755
>> index 0000000..ad99f8b
>> --- /dev/null
>> +++ b/t/t1308-config-hash.sh
>> +test_expect_success 'setup default config' '
>> +	cat >.git/config << EOF
> 
> Missing && here (sorry, I should have noticed the first time).
> 

Does a single cat command warrant a `&&`? It errors out when I try
to add it there.
