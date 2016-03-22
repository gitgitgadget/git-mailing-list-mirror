From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] (exit 1) is silly
Date: Tue, 22 Mar 2016 18:08:13 +0100
Message-ID: <56F17BFD.80606@gmail.com>
References: <1458661671-3793-1-git-send-email-izaberina@gmail.com>
 <xmqq8u1ajxnk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, izabera <izaberina@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:08:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiPn2-00034b-JU
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbcCVRIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:08:18 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36196 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbcCVRIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:08:16 -0400
Received: by mail-wm0-f46.google.com with SMTP id r129so102982316wmr.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=YxSQSQapmdVaM0Brdw8UA1goWuf40Q1xpscZNFS4aPw=;
        b=vluoFlznEO0Mr9vdUJaVeSo8b6Knkg40epUWkkFc7rcBMJHS2ecYQO/PGNEWM53+x1
         sjJmWYr0Nv48ZuP4SSPpSgGmbSWdiOZMwCV/G/AsQ2PVwCs1XcKNoKkPNCMDUcc4uKiq
         j/hBURG+qzGKZR1PQ7mGjmYasfAjDsb0L57LSWUZvO1vuTgIBtRQThMqU1FRJy0zsc0o
         xeJbrq61z+HGCPVMfm0Z2/tKY5urcS6buQMp9/vLEIwo2EU9fbwnJuZNCaccVwvc6alX
         eA65VxrLM8cVaJU7yzdXQj4jjsEfsLHtDG8RgUcpQRhhkH3xJBOP24VdIb4znCTi2vp+
         X2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=YxSQSQapmdVaM0Brdw8UA1goWuf40Q1xpscZNFS4aPw=;
        b=bADgjRIGUjlDy9PzRm9TVEWkDafb5QaZnqK+rEVbGe5+iwuvzrDy/N8w2QhiQ4Ytqv
         ZkJNbZ/bFGE8DFJ0FRyQLhtFf4f1reTgDBIrTMsXN2ZdtpIvDoA46QmCd6xMtgAeUHab
         hBuauWM73+3bHKm7QXIj7UhhBxpWCjKy4G/9i1fiJSUs/zLgeVC4KClHvA07EzzaZfZH
         xgCngbx1RFmx1eCZSGUgkOuB8054av7okzAzDo+7+jKpiCypoP2YylRmP79fdfvFp6ww
         Esq2mYnvPHiOQVkLpH/SjAVq8m0hfudy+NPIBirp6049nOXIa3JMGUJDx0AAmbwG1w6y
         366Q==
X-Gm-Message-State: AD7BkJLgetoYOWJCYnhLM1g0RORfj+Eg92FOfEPRNATxh2HFejeivJNyEUUFnhbB0LQwmw==
X-Received: by 10.28.210.73 with SMTP id j70mr20500072wmg.8.1458666495235;
        Tue, 22 Mar 2016 10:08:15 -0700 (PDT)
Received: from [10.223.62.205] ([131.228.216.133])
        by smtp.googlemail.com with ESMTPSA id up6sm31191458wjc.6.2016.03.22.10.08.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2016 10:08:14 -0700 (PDT)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqq8u1ajxnk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289518>

On 3/22/2016 17:16, Junio C Hamano wrote:

> IMO, this is such a minor thing that once it _is_ in the tree, it's
> not really worth the patch noise to go and fix it up.

IMO, instead of writing this you could have just accepted the patch, 
reducing the patch noise ;-)

Regards,
Sebastian
