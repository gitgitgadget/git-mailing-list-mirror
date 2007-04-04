From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 04 Apr 2007 18:26:41 +0200
Message-ID: <4613D1C1.6010002@dawes.za.net>
References: <200704041414.14797.andyparkins@gmail.com> <4613A974.60808@dawes.za.net> <200704041540.59977.andyparkins@gmail.com> <4613C97C.9050600@dawes.za.net> <Pine.LNX.4.63.0704041819340.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 04 18:27:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ8KM-00085b-UE
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 18:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbXDDQ1Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 12:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753600AbXDDQ1Q
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 12:27:16 -0400
Received: from sd-green-bigip-207.dreamhost.com ([208.97.132.207]:38523 "EHLO
	spunkymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753596AbXDDQ1P (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2007 12:27:15 -0400
Received: from [192.168.201.103] (dsl-146-24-118.telkomadsl.co.za [165.146.24.118])
	by spunkymail-a11.g.dreamhost.com (Postfix) with ESMTP id 71830B82D3;
	Wed,  4 Apr 2007 09:27:11 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.63.0704041819340.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43753>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 4 Apr 2007, Rogan Dawes wrote:
> 
>> Andy Parkins wrote:
>>
>>> As an example: compress a file, change a byte, compress it again, 
>>> perform a binary diff; what is that diff telling you about the change?  
>>> (My answer is: not much).
>> Well, at least as much as the resulting sizes tell you, if not more.
> 
> The subtle difference: your approach is _expensive_ in terms of CPU time, 
> while the byte change approach is _dirt cheap_.

I don't dispute that for a second.

> Since it seems that there are gazillions of examples where one or the 
> other (or both) do not make sense, I'd rather have the fast one.

Fair enough.

Rogan
