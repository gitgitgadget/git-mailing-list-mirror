From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Thu, 30 Jul 2009 00:44:28 -0700
Message-ID: <4A714F5C.70000@eaglescrag.net>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Jul 30 10:42:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWRDV-0004MD-Bc
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 10:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbZG3ImR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 04:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbZG3ImR
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 04:42:17 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:50199 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbZG3ImR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 04:42:17 -0400
X-Greylist: delayed 3463 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jul 2009 04:42:16 EDT
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id n6U7iSNe009380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Jul 2009 00:44:28 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/9634/Wed Jul 29 20:03:31 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Thu, 30 Jul 2009 00:44:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124455>

Mark A Rada wrote:
> Hi,
> 
> I thought I would submit this little patch I made to my gitweb. I am on 
> a relatively slow
> connection, and so LZMA compression time is less of a  concern than 
> bandwidth---I'm
> guessing that I am not the only person who suffers from slow internet 
> connection
> syndrome.
> 
> 
> -- 
> Mark A Rada (ferrous26)
> marada@uwaterloo.ca

Don't use 'lzma' the command, use 'xz' ( http://tukaani.org/xz/ ) as it 
uses the lzma2 format which is, by far, preferable to what 'lzma' 
outputs.  Same compression (lzma) just different file format.

- John 'Warthog9' Hawley
