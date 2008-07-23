From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: git-svn - failed to clone repository
Date: Wed, 23 Jul 2008 23:59:44 +0100
Message-ID: <20080723225944.GA9310@cisco.com>
References: <20080723160659.GB6705@cisco.com> <20080723170838.GK22606@neumann> <32541b130807231249l1028a757i2f29e9ca6e38fc5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@fzi.de>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:01:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLnKj-00061n-Cm
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 01:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbYGWXAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 19:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbYGWXAU
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 19:00:20 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:10424 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbYGWXAT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 19:00:19 -0400
X-IronPort-AV: E=Sophos;i="4.31,240,1215388800"; 
   d="scan'208";a="15207553"
Received: from ams-dkim-1.cisco.com ([144.254.224.138])
  by ams-iport-1.cisco.com with ESMTP; 23 Jul 2008 23:00:18 +0000
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m6NN0HVU013953;
	Thu, 24 Jul 2008 01:00:17 +0200
Received: from edi-view2.cisco.com (edi-view2.cisco.com [64.103.71.156])
	by ams-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m6NN0HTs007770;
	Wed, 23 Jul 2008 23:00:17 GMT
Received: from dfawcus-laptop (localhost [127.0.0.1]) by edi-view2.cisco.com (8.11.2/CISCO.WS.1.2) with ESMTP id m6NN0HX21845; Thu, 24 Jul 2008 00:00:17 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <32541b130807231249l1028a757i2f29e9ca6e38fc5a@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; l=261; t=1216854018; x=1217718018;
	c=relaxed/simple; s=amsdkim1002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dfawcus@cisco.com;
	z=From:=20Derek=20Fawcus=20<dfawcus@cisco.com>
	|Subject:=20Re=3A=20git-svn=20-=20failed=20to=20clone=20rep
	ository
	|Sender:=20;
	bh=giLArCyFYIrp5zaSqDTjqzX2LTcDxj18gO8NpMBSKJY=;
	b=WGLOMn7C3OX3ZD6FLq5gyaDi1FlWwhBKymmZ8hvHqxrthst86h1mlGFCHc
	ws9yBAcG8U6lUglTZs3zzLX5jdGH9edv4Oi17NxaTvHZG/Mau0VzLxwjccMN
	BrG+Ge1Gx7;
Authentication-Results: ams-dkim-1; header.From=dfawcus@cisco.com; dkim=pass (
	sig from cisco.com/amsdkim1002 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89798>

On Wed, Jul 23, 2008 at 03:49:00PM -0400, Avery Pennarun wrote:
> I believe this was fixed by my patch
> 29c70e0b3e3183f86f93500882177d0c74069988, which was included in git
> 1.5.6.2.

Thanks folks.  Building my own 1.5.6.4 allowed the clone to complete.
