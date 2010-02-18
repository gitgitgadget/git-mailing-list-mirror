From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: 'git status' on NFS performance regression in 1.7.0
Date: Thu, 18 Feb 2010 09:46:31 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1002180943240.11095@ds9.cixit.se>
References: <885649361002171208j41405b9exdfc34034c905e96c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 09:46:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni21w-0008TV-V6
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 09:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab0BRIqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 03:46:36 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:43781 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751955Ab0BRIqf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 03:46:35 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o1I8kWHJ016179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Feb 2010 09:46:32 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o1I8kVQI016175;
	Thu, 18 Feb 2010 09:46:31 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <885649361002171208j41405b9exdfc34034c905e96c@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 18 Feb 2010 09:46:32 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140304>

James Pickens:

> I noticed that 'git status' in version 1.7.0 is much slower than in 
> 1.6.2.5 on large work trees on NFS - averaging ~13 seconds runtime vs. ~2 
> seconds.

This applies to local disk as well. Where it used to be almost 
instantaneous, I now see a wait of about three seconds on a checkout of 
about 8,000 files.

-- 
\\// Peter - http://www.softwolves.pp.se/
