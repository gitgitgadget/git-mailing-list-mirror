From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: git via rsync
Date: Sat, 21 Apr 2007 09:24:51 +0200
Message-ID: <4629BC43.1060603@dawes.za.net>
References: <Pine.LNX.4.64.0704202218480.7764@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sat Apr 21 09:25:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf9yD-0004y2-6y
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 09:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbXDUHZN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 03:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbXDUHZN
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 03:25:13 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:52962 "EHLO
	spunkymail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964989AbXDUHZL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2007 03:25:11 -0400
Received: from [192.168.201.100] (dsl-146-24-08.telkomadsl.co.za [165.146.24.8])
	by spunkymail-a7.g.dreamhost.com (Postfix) with ESMTP id E0C845C1CD;
	Sat, 21 Apr 2007 00:25:07 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.64.0704202218480.7764@beast.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45152>

Julian Phillips wrote:
> Is rsync still a supported git transport (I know that there is still 
> code for it, but does anyone care for it)?  Does anyone use it?
> 
> http has caused a couple of queries recently, but I haven't noticed 
> anything about rsync.  Does that mean that it "just works", or is it 
> simply that no one uses it?
> 
> Just curious ...
> 

Rsync has significant problems that prevent it being used in serious 
situations.

Primarily, it is not atomic. So, if the other end is busy with an 
operation while you are rsyncing, you are likely to get a corrupted fetch.

I'm sure that there are others, but I don't remember them offhand.

Rogan
