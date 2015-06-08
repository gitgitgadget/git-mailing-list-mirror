From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 2/9] ref-filter: implement '--points-at' option
Date: Tue, 09 Jun 2015 00:24:45 +0530
Message-ID: <5575E4F5.8050808@gmail.com>
References: <5573520A.90603@gmail.com>	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>	<1433621052-5588-2-git-send-email-karthik.188@gmail.com> <vpqmw0aozbr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:55:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z22CK-0004X8-Cl
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbbFHSyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:54:50 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34102 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbbFHSyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:54:50 -0400
Received: by pdbki1 with SMTP id ki1so110692066pdb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jcuuCG33xslqki/wtt1L7JLX8iLTO8Aj4LRfxy0nyiA=;
        b=Ope8eJIPBQrr2pRw9q5JLvvunJ1wJ061OgNmYA2QqoY/dD4aJF3TTTakUg9rO+ae6l
         hW6fZLeRYFci5ql9/o4QzaANX5tN6te8itxZcs3I4Wnv9wwFt2FYIDFmPvT6O7PRdryv
         duLw8VL3LGkybDB5kYo/TwvoQO1JqGTVScPNvbbjSS57bUB9TMV4FdmUB9ncdN5dotXO
         3/xDvlRt6rLe6xC39uUGVL4ady2hD8YUEs+kFMi9l95dEhSb8JQSLum3+eCuj7DrAOmk
         G7PklNs1/j21L+tR3JJFqnbJzgxoO//TEuuq/FdXrlRPIkBuRPq7SrgFVBf5hKuk34HD
         RYIA==
X-Received: by 10.70.88.17 with SMTP id bc17mr32248843pdb.12.1433789689688;
        Mon, 08 Jun 2015 11:54:49 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id x2sm3301664pda.31.2015.06.08.11.54.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 11:54:49 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqmw0aozbr.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271111>

On 06/08/2015 11:30 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> In 'tag -l' we have '--points-at' option which lets users
>> list only tags which point to a particular commit, Implement
>
> s/,/./ ?
>
>> this option in 'ref-filter.{c,h}' so that the other commands
>
> s/the//
>

Noted! thanks

-- 
Regards,
Karthik
