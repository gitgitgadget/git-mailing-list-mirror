From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: git-svn bug report: %20 in http:// should translate to a space
 ' ' automatically
Date: Sun, 16 Aug 2009 20:13:31 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.0908162012190.13789@yvahk2.pbagnpgbe.fr>
References: <4A86F4DA.5090605@smullindesign.com> <20090815181637.GC19833@atjola.homenet> <alpine.LSU.2.00.0908152336240.449@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1084551540-439575890-1250446411=:13789"
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Mike Smullin <mike@smullindesign.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Sun Aug 16 20:30:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MckV5-0005JX-7W
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 20:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbZHPSaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 14:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbZHPSa3
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 14:30:29 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:43794 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbZHPSa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 14:30:29 -0400
X-Greylist: delayed 1011 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Aug 2009 14:30:28 EDT
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n7GIDV94012369;
	Sun, 16 Aug 2009 20:13:31 +0200
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <alpine.LSU.2.00.0908152336240.449@hermes-2.csi.cam.ac.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126066>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1084551540-439575890-1250446411=:13789
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 15 Aug 2009, Tony Finch wrote:

> On Sat, 15 Aug 2009, Björn Steinbrink wrote:
>>
>> 3) git svn clone -Tgoo "http://host/repo/path with spaces/foo/bar"
>>
>> Works.
>
> Spaces are not permitted in URLs so this should be treated as a syntax 
> error.

libcurl OTOH doesn't verify the passed in data to be strict URLs but will 
instead do its best to work with whatever is passed to it...

-- 

  / daniel.haxx.se
---1084551540-439575890-1250446411=:13789--
