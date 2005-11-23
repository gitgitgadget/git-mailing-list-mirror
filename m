From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: pack-redundant.c:689: warning: long unsigned int format, size_t
 arg (arg 3)
Date: Tue, 22 Nov 2005 17:46:48 -0800
Message-ID: <4383CA08.4080604@zytor.com>
References: <118833cc0511221734r33b20f6au97fe2e93243f5ccf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 23 02:47:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EejjB-0007wz-K2
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 02:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbVKWBrO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 20:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVKWBrO
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 20:47:14 -0500
Received: from terminus.zytor.com ([192.83.249.54]:16102 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965079AbVKWBrA
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 20:47:00 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAN1krnJ003587
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Nov 2005 17:46:53 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0511221734r33b20f6au97fe2e93243f5ccf@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12595>

Morten Welinder wrote:
> Maybe cast the size to unsigned long to make it match the format.
> 
> M.
> 
> pack-redundant.c: In function `main':
> pack-redundant.c:689: warning: long unsigned int format, size_t arg (arg 3)

Or use %zu for the format.

	-hpa
