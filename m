From: David Lang <david.lang@digitalinsight.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file 
 permission bits)
Date: Tue, 9 Jan 2007 17:39:35 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0701091735490.7747@qynat.qvtvafvgr.pbz>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
 <8aa486160612100706y92bc722n93374e394fc58005@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Wed Jan 10 03:01:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Smk-0006Ua-N2
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 03:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbXAJCBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 21:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbXAJCBs
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 21:01:48 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:55346 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932658AbXAJCBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 21:01:47 -0500
X-Greylist: delayed 1001 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 21:01:47 EST
Received: from no.name.available by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Tue, 9 Jan 2007 18:01:47 -0800
Received: from wlvims02.corp.ad.diginsite.com (wlvims02.diginsite.com [10.201.10.79]) by blackbird.diginsite.com (Tablus Interceptor) for <git@vger.kernel.org>; Tue, 9 Jan 2007 17:45:05 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 09 Jan 2007 17:45:04 -0800
X-X-Sender: dlang@dlang.diginsite.com
To: git@vger.kernel.org
In-Reply-To: <8aa486160612100706y92bc722n93374e394fc58005@mail.gmail.com>
X-Tablus-Inspected: yes
X-Tablus-Classifications: public
X-Tablus-Action: allow
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36471>

I want to have a tripwire-like system checking the files to make sure that they 
haven't changed unexpectedly. the program I'm looking at notices inode as well 
as timestamp and content changed.

when you checkout a file from git will it re-write/overwrite a file that hasn't 
changed or will it realize there is no change and leave it as-is?

does this answer change if there is a trigger on checkout (to change permissions 
or otherwise manipulate the file)?

David Lang
