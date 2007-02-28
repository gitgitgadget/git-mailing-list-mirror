From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 28 Feb 2007 23:27:48 +0200
Message-ID: <45E5F3D4.8000509@dawes.za.net>
References: <200702281303.11951.andyparkins@gmail.com> <45E5D0D7.5070305@dawes.za.net> <Pine.LNX.4.63.0702282042000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 22:28:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMWLB-0000ML-0z
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 22:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbXB1V16 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 16:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbXB1V16
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 16:27:58 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:34017 "EHLO
	spunkymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752041AbXB1V16 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Feb 2007 16:27:58 -0500
X-Greylist: delayed 8952 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Feb 2007 16:27:58 EST
Received: from [192.168.201.100] (dsl-146-24-85.telkomadsl.co.za [165.146.24.85])
	by spunkymail-a12.g.dreamhost.com (Postfix) with ESMTP id 65B4C7FA7;
	Wed, 28 Feb 2007 13:27:54 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
In-Reply-To: <Pine.LNX.4.63.0702282042000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41007>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 28 Feb 2007, Rogan Dawes wrote:
> 
>> How about showing the size of the changes between the 2 files via the 
>> libxdiff binary patch function?
> 
> I briefly considered this, too. But what would it tell you in the case of 
> a jpg? I think it has more disadvantages than advantages...
> 
> Ciao,
> Dscho

It would still tell you the extent of the changes. i.e. Did we change 
only 10 bytes of the file, or is it a dramatic change?

This is exactly what the text statistics show. +(new lines + modified 
lines) -(deleted lines + modified lines)

Instead of having a "line-based" record size, simply use individual 
bytes, since binary files don't have lines (most of them, anyway!).

Rogan
