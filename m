From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: hosting git on a nfs
Date: Wed, 12 Nov 2008 14:31:16 -0600
Message-ID: <9ww97aHlVPEurT6kkb9TAxOaH5OSLhFQTgI4LcQRGzCQgkut0VsbwQ@cipher.nrlssc.navy.mil>
References: <200811121029.34841.thomas@koch.ro> <alpine.LNX.2.00.0811121006400.23345@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Koch <thomas@koch.ro>, git@vger.kernel.org, dabe@ymc.ch
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Nov 12 21:33:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0MOg-0006en-6D
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 21:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbYKLUbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 15:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752955AbYKLUbr
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 15:31:47 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50223 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbYKLUbq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 15:31:46 -0500
Received: by mail.nrlssc.navy.mil id mACKVHpd030704; Wed, 12 Nov 2008 14:31:17 -0600
In-Reply-To: <alpine.LNX.2.00.0811121006400.23345@reaper.quantumfyre.co.uk>
X-OriginalArrivalTime: 12 Nov 2008 20:31:17.0315 (UTC) FILETIME=[9D4F6930:01C94505]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100813>

Julian Phillips wrote:
> On Wed, 12 Nov 2008, Thomas Koch wrote:
> 
>> Hi,
>>
>> finally I managed to convince a critical mass of developers (our chief
>> dev :-) in our company so that we are starting to migrate to GIT.
>>
>> The final question is, whether GIT will life peacefully on our cluster
>> fileservers. The GIT repository dir (/var/cache/git) should be mounted
>> via NFS via PAN on top of DRBD (so I was told).
>>
>> Are there any known problems with this setup? We're asking, because
>> there are problems with SVN on such a setup[1].
>>
>> [1] http://subversion.tigris.org/faq.html#nfs
> 
> I've been running git on NFS for years (though it's only NFS exported
> software RAID), and the only issue I've encountered is that it's not
> quite as blisteringly fast as running git on a local disk.

ditto. (except for the years part)

-brandon
