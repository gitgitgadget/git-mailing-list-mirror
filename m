From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Mon, 30 Jun 2008 08:27:42 +0200
Message-ID: <48687CDE.5010502@s5r6.in-berlin.de>
References: <200612241807.kBOI746w008739@laptop13.inf.utfsm.cl> <476E42BF.1010300@garzik.org> <Pine.LNX.4.64.0712310349260.2093@fbirervta.pbzchgretzou.qr> <4778D1CD.4020001@s5r6.in-berlin.de> <48684A46.7040802@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jan Engelhardt <jengelh@computergmbh.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 08:29:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDCsl-0000tk-U1
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 08:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbYF3G2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 02:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753036AbYF3G2A
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 02:28:00 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:54028 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbYF3G17 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 02:27:59 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.42] ([83.221.231.7])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m5U6RmGs021730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jun 2008 08:27:48 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080614 SeaMonkey/1.1.9
In-Reply-To: <48684A46.7040802@garzik.org>
X-Enigmail-Version: 0.95.6
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86882>

Jeff Garzik wrote:
> Stefan Richter wrote:
>> A while ago the default behavior of git pull was changed to fetch all
>> tags which point to objects that can be reached from any of the tracked
>> heads.
> 
> 
> This does not work in all cases.  When I retrieve the latest kernel, it 
> downloads the tags:
> 
>     cd /spare/repo/linux-2.6
>     git pull
> 
> but when I pull those changes into another local repo, the tags do -not- 
> follow the objects:
> 
>     cd /spare/repo/misc-2.6
>     git checkout master
>     git pull ../linux-2.6
>     git fetch --tags ../linux-2.6    # still required to this day

I guess this is because /spare/repo/misc-2.6 does not have branches of 
/spare/repo/linux-2.6 configured as remote (tracking) branches.
-- 
Stefan Richter
-=====-==--- -==- ====-
http://arcgraph.de/sr/
