From: Ephrim Khong <dr.khong@gmail.com>
Subject: Re: [Bug] git gc with alternates tries accessing non-existing directory
Date: Wed, 18 Mar 2015 12:55:12 +0100
Message-ID: <550967A0.4000901@gmail.com>
References: <55093344.9030500@gmail.com> <20150318094232.GA26496@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 12:55:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYCZK-00072w-E3
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 12:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbbCRLzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 07:55:16 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:33050 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbbCRLzP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 07:55:15 -0400
Received: by weop45 with SMTP id p45so30304190weo.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 04:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IM0KV7W/8oDW6nohc13Euxb6/b0kPh2Ak2Iy7RTNZdE=;
        b=l+zMrsZ1TmftDhsm9rvLS8jU44P3sItkM6AkTVZIq4U9mey8ekHzfzXnBnftxFeB+n
         +demQBdNvQWTFYxeCUrsIS2ZFIvpz6sV3ls7IQ4XrZEcX0/iI/nwg1cGECTYzXXLdsQn
         1J5he57FmZsKGwbBY1J9Ec7AfX8e8cP/ByLu+1/WXl02Xg0G6g23BLf0YG+nZ8BO3qbT
         gx+56eB1xdElkkZS7ohNsBJ6w6X7hgTixPchFcrZLorhvIX3j2tFOwxWHGGu5JHiuwNI
         xn3lcIoU6dz/CogsZP7l/3Od87wELlU0H7AOjwm7gg/izI9uKEoqu1CBVm830SkZFjrK
         AxGQ==
X-Received: by 10.180.82.135 with SMTP id i7mr1464728wiy.78.1426679714036;
        Wed, 18 Mar 2015 04:55:14 -0700 (PDT)
Received: from [10.0.100.231] (merlin.mvtec.com. [62.96.232.130])
        by mx.google.com with ESMTPSA id dm6sm2848701wib.22.2015.03.18.04.55.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 04:55:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150318094232.GA26496@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265721>

On 18.03.2015 10:42, Jeff King wrote:
> On Wed, Mar 18, 2015 at 09:11:48AM +0100, Ephrim Khong wrote:
>
>> I have a non-bare repository /home/a set up with an alternate to the bare
>> repository /b. Running  git gc  on /home/a produces below's error
>> [...]
>>> git --version
>> git version 2.3.0
>
> Try v2.3.2. It has b0a4264 (sha1_file: fix iterating loose alternate
> objects, 2015-02-08), which is almost certainly the problem.

Indeed, the message is gone in v2.3.3. Thanks!

- Eph
