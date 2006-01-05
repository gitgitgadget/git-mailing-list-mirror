From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: use GIT_DIR instead of /var/tmp
Date: Thu, 05 Jan 2006 08:38:11 -0800
Message-ID: <43BD4B73.7010000@zytor.com>
References: <81b0412b0601050352n386505bfjd40e515809e3c862@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 17:38:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuY8F-0001tM-Ht
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 17:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWAEQi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 11:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751582AbWAEQi2
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 11:38:28 -0500
Received: from terminus.zytor.com ([192.83.249.54]:24202 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751148AbWAEQi2
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 11:38:28 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k05GcBGU009201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 Jan 2006 08:38:12 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0601050352n386505bfjd40e515809e3c862@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.6 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14201>

Alex Riesen wrote:
> Not every system (will not one microsoft windows system) have /var/tmp,
> whereas using GIT_DIR for random temporary files is more or less established.

Depends on what you're doing.  Only if you're writing to the repository.

Windows will usually have $TMP and/or $TEMP, a lot of Unix apps honour 
$TMP_DIR.

	-hpa
