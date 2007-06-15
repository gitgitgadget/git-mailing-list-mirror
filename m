From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: [PATCH guilt] make guilt use standard POSIX shell
Date: Fri, 15 Jun 2007 09:01:04 +0100
Message-ID: <20070615090104.B20266@mrwint.cisco.com>
References: <11818254621527-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Jeff Sipek <jsipek@cs.sunysb.edu>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 10:11:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz6tf-0002il-AX
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 10:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbXFOILG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 04:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbXFOILF
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 04:11:05 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:47288 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbXFOILE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 04:11:04 -0400
X-Greylist: delayed 585 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jun 2007 04:11:03 EDT
Received: from ams-dkim-2.cisco.com ([144.254.224.139])
  by ams-iport-1.cisco.com with ESMTP; 15 Jun 2007 10:01:17 +0200
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id l5F81GaP021233;
	Fri, 15 Jun 2007 10:01:16 +0200
Received: from cisco.com (mrwint.cisco.com [64.103.71.48])
	by ams-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id l5F819DR028052;
	Fri, 15 Jun 2007 08:01:14 GMT
Received: (from dfawcus@localhost)
	by cisco.com (8.8.8-Cisco List Logging/8.8.8) id JAA00886;
	Fri, 15 Jun 2007 09:01:04 +0100 (BST)
X-Mailer: Mutt 1.0.1i
In-Reply-To: <11818254621527-git-send-email-madcoder@debian.org>; from madcoder@debian.org on Thu, Jun 14, 2007 at 02:50:55PM +0200
DKIM-Signature: v=0.5; a=rsa-sha256; q=dns/txt; l=474; t=1181894476; x=1182758476;
	c=relaxed/simple; s=amsdkim2001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dfawcus@cisco.com;
	z=From:=20Derek=20Fawcus=20<dfawcus@cisco.com>
	|Subject:=20Re=3A=20[PATCH=20guilt]=20make=20guilt=20use=20standard=20POS
	IX=20shell
	|Sender:=20;
	bh=tLQCL9Ge3WbFIvuIdR2H15cyOwKA2Oub5YyClrIWVpw=;
	b=Q3/AJ1qxMdpEnPH/j7o2S/0RX3BwviFBHKY2ou2vdY0jBLTJG4e9DZYb7iXaSITSk3gJRPSI
	B33ex/CDlhcS4rVwLRpGvu+byPlAinb29k3cfLIyuSGGpbpO4B4ex3sQ;
Authentication-Results: ams-dkim-2; header.From=dfawcus@cisco.com; dkim=pass (
	sig from cisco.com/amsdkim2001 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50253>

On Thu, Jun 14, 2007 at 02:50:55PM +0200, Pierre Habouzit wrote:
> This patch series makes guilt be able to work with a standard posix shell.
> 
> This has been tested with bash, zsh, dash and posh acting as /bin/sh.

Well if you want to try with a 'real' bourne shell,  there is always the
heirloom sh or the v7 shell...

http://heirloom.sourceforge.net/sh.html
http://www.collyer.net/who/geoff/v7sh.tar 
http://minnie.tuhs.org/UnixTree/V7/usr/src/cmd/sh/

DF
