From: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
Subject: Re: git clone NonExistentLocation
Date: Thu, 17 Feb 2011 13:52:20 +0100
Organization: ATLAS Elektronik GmbH
Message-ID: <4D5D1A04.4090107@atlas-elektronik.com>
References: <4D5CE3E7.5030101@atlas-elektronik.com> <4D5D1715.5020707@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 17 13:52:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq3LI-0001EB-Ab
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 13:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab1BQMwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 07:52:16 -0500
Received: from mail96.atlas.de ([194.156.172.86]:14707 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753448Ab1BQMwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 07:52:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id E814510072;
	Thu, 17 Feb 2011 13:52:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at lxsrv96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (lxsrv96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id hpl9k-2WvFIL; Thu, 17 Feb 2011 13:52:13 +0100 (CET)
Received: from mgsrv01.atlas.de (mailrelay-atlas.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 17 Feb 2011 13:52:13 +0100 (CET)
Received: from [141.200.42.243] (as106913.atlas.de [141.200.42.243])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 698062716A;
	Thu, 17 Feb 2011 13:52:13 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.14) Gecko/20080421 Lightning/0.8 Thunderbird/2.0.0.14 Mnenhy/0.7.5.0
In-Reply-To: <4D5D1715.5020707@drmicha.warpmail.net>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167081>

On 2/17/2011 1:39 PM, Michael J Gruber wrote:
> 
> It is useful, and it even gives you a warning that it still might not be
> what you intended. Would be funny if it were accidental. Indeed, a git
> "log -S" on that warning reveals that it was introduced intentionally in
> 
> 86ac751 (Allow cloning an empty repository, 2009-01-23)

OK. But that's about 'cloning an empty repository'.
'NonExistentLocation' is not empty initially - it simply does
not exist.

Contrast that to 'git clone http://url.does.not.exist'. You don't
get an empty repository in 'url.does.not.exist' after running that.

Regards,
  Stefan
-- 
----------------------------------------------------------------
/dev/random says: ==/==/==/==Police tagline==/==/==Do not cross ==/==/==/==
