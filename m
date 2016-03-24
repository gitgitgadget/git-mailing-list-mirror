From: Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v2 09/17] Add watchman support to reduce index refresh
 cost
Date: Thu, 24 Mar 2016 09:47:32 -0400
Message-ID: <56F3EFF4.30500@jeffhostetler.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
 <1458349490-1704-10-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	pclouds@gmail.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 24 16:36:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj7J2-0001MR-36
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 16:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbcCXPgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 11:36:13 -0400
Received: from siwi.pair.com ([209.68.5.199]:51679 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbcCXPgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 11:36:11 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Mar 2016 11:36:11 EDT
Received: from [10.160.15.137] (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id E4A0284632;
	Thu, 24 Mar 2016 11:29:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1458349490-1704-10-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289750>


I'm seeing wm->name have value ".git" rather than ".git/" on Linux.


On 03/18/2016 09:04 PM, David Turner wrote:
> +		if (!strncmp(wm->name, ".git/", 5) ||
> +		    strstr(wm->name, "/.git/"))
> +			continue;


thanks,
Jeff
