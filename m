From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: [PATCH 0/7] Case-insensitive filesystem support, take 1
Date: Tue, 25 Mar 2008 11:39:56 +0000
Message-ID: <20080325113956.GA7559@cisco.com>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 12:50:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je7fi-0006BU-Nu
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 12:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbYCYLts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 07:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753768AbYCYLts
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 07:49:48 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:24738 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbYCYLtr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 07:49:47 -0400
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Mar 2008 07:49:47 EDT
X-IronPort-AV: E=Sophos;i="4.25,551,1199660400"; 
   d="scan'208";a="4362804"
Received: from ams-dkim-1.cisco.com ([144.254.224.138])
  by ams-iport-1.cisco.com with ESMTP; 25 Mar 2008 12:40:03 +0100
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m2PBe3pD026178
	for <git@vger.kernel.org>; Tue, 25 Mar 2008 12:40:03 +0100
Received: from edi-view2.cisco.com (edi-view2.cisco.com [64.103.71.156])
	by ams-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m2PBe3eh011416
	for <git@vger.kernel.org>; Tue, 25 Mar 2008 11:40:03 GMT
Received: from dfawcus-laptop (localhost [127.0.0.1]) by edi-view2.cisco.com (8.11.2/CISCO.WS.1.2) with ESMTP id m2PBe3X28596 for <git@vger.kernel.org>; Tue, 25 Mar 2008 11:40:03 GMT
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.3i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; l=565; t=1206445203; x=1207309203;
	c=relaxed/simple; s=amsdkim1002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dfawcus@cisco.com;
	z=From:=20Derek=20Fawcus=20<dfawcus@cisco.com>
	|Subject:=20Re=3A=20[PATCH=200/7]=20Case-insensitive=20file
	system=20support,=20take=201
	|Sender:=20;
	bh=0HlILdxWLjHfRtktH6q5kuJndihVcDOGrvF9hVX0ojs=;
	b=e3gXDJehLW/MA4v3Fm/hmnPX4KWDsm0MkMmkSr/phetdNYgTa+89Rnr4er
	s0Wcl8Fe2TpIlVSwuPmIykMzHyLBd5HPy/4qKH2DmR3VL3U4kPP4duLoXqDf
	BspIp5fWs0;
Authentication-Results: ams-dkim-1; header.From=dfawcus@cisco.com; dkim=pass (
	sig from cisco.com/amsdkim1002 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78182>

On Sat, Mar 22, 2008 at 10:21:05AM -0700, Linus Torvalds wrote:
>    ... and on a vfat filesystem under Linux (which is 
>    case-insensitive and *really* odd wrt case preservation - it remembers 
>    the name of removed files, so it preserves case even across removal and 
>    re-creation!)

Interesting.
That sounds a bit like the claimed windows 95 properly of 'tunneling' renames.
ISTR that it was to catch a move via 'shortname' which then preserved the longname.

However I'd have expected the Linux version to always use the long name...

DF
