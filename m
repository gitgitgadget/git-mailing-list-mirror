From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Fix ptrdiff_t vs. int
Date: Fri, 27 May 2005 09:25:10 -0700
Message-ID: <429749E6.2050806@zytor.com>
References: <42971EB4.2050403@oberhumer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 18:25:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbhcP-0001Kk-Ir
	for gcvg-git@gmane.org; Fri, 27 May 2005 18:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVE0QZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 12:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVE0QZ2
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 12:25:28 -0400
Received: from terminus.zytor.com ([209.128.68.124]:27110 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262482AbVE0QZZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 12:25:25 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4RGPAkJ031170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 May 2005 09:25:12 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
In-Reply-To: <42971EB4.2050403@oberhumer.com>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=0.2 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Markus F.X.J. Oberhumer wrote:
> This trivial patch fixes an obvious ptrdiff_t vs. int mismatch. Which
> makes we wonder why Linus isn't hitting this on his ppc64 - maybe it's
> time to start using -Werror...

This doesn't affect CPUs with a register-based calling convention.

	-hpa
