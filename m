From: Ben Greear <greearb@candelatech.com>
Subject: Question on GIT usage.
Date: Fri, 28 Oct 2005 17:49:04 -0700
Organization: Candela Technologies
Message-ID: <4362C700.6020901@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 29 02:49:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVeuE-00060v-Gh
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 02:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbVJ2AtH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 20:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVJ2AtH
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 20:49:07 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:982 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1750959AbVJ2AtG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2005 20:49:06 -0400
Received: from [71.113.100.100] (pool-71-113-100-100.sttlwa.dsl-w.verizon.net [71.113.100.100])
	(authenticated bits=0)
	by ns2.lanforge.com (8.13.4/8.13.4) with ESMTP id j9T0n47S015847
	for <git@vger.kernel.org>; Fri, 28 Oct 2005 17:49:05 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10778>


I have a kernel GIT tree to hold my developing patches...

I need to build this kernel for 4-5 different processors (c3, p2, p4, p4-smp, etc).

Is there any clever way to have this one git repository keep these
other source trees in sync so that I can do incremental builds?

Should I perhaps have a unique git repo for each different build and
just pull changes in from my master repo before building?

If there's a simple command to set up slave repositories like this,
please point me to it.

Thanks!
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
