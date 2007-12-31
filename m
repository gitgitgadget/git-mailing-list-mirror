From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Mon, 31 Dec 2007 12:26:05 +0100
Message-ID: <4778D1CD.4020001@s5r6.in-berlin.de>
References: <200612241807.kBOI746w008739@laptop13.inf.utfsm.cl> <476E42BF.1010300@garzik.org> <Pine.LNX.4.64.0712310349260.2093@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff Garzik <jeff@garzik.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Mon Dec 31 12:27:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9InW-0006Ga-9Z
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 12:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757127AbXLaL03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 06:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756295AbXLaL02
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 06:26:28 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:56843 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbXLaL01 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 06:26:27 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.42] (k5.avc-online.de [83.221.230.29])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id lBVBQ6pN010934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 31 Dec 2007 12:26:09 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.11) Gecko/20071216 SeaMonkey/1.1.7
In-Reply-To: <Pine.LNX.4.64.0712310349260.2093@fbirervta.pbzchgretzou.qr>
X-Enigmail-Version: 0.95.3
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69399>

Jan Engelhardt wrote:
>> 	http://linux.yyz.us/git-howto.html
> 
> It says
> 
> """Don't forget to download tags from time to time.
> 
> git pull only downloads sha1-indexed object data, and the requested
> remote head. This misses updates to the .git/refs/tags/ and
> .git/refs/heads/ directories. For tags, run git fetch --tags $URL."""
> 
> But when I do git pull on a simple tracking tree (e.g. git-clone
> torvalds/linux-2.6.git; git pull;) it automatically grabs new tags.

A while ago the default behavior of git pull was changed to fetch all
tags which point to objects that can be reached from any of the tracked
heads.

Old behaviour:  Option --tags was needed to fetch tags at all.  Current
behavior:  Option --tags forces to download all tags and the objects
they point to.  Option --no-tags works like the old default behavior.

Readers of Kernel Hackers' Guide to git will most certainly have a
recent enough version of git so that the "download_tags" subsection can
be removed without replacement.
-- 
Stefan Richter
-=====-=-=== ==-- =====
http://arcgraph.de/sr/
