From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: More on git over HTTP POST
Date: Sat, 02 Aug 2008 20:51:10 -0700
Message-ID: <48952B2E.3030209@zytor.com>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <20080803025602.GB27465@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 05:51:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPUdP-0008VK-Iv
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 05:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbYHCDuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 23:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbYHCDuy
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 23:50:54 -0400
Received: from terminus.zytor.com ([198.137.202.10]:54007 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091AbYHCDux (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 23:50:53 -0400
Received: from [10.71.1.72] ([12.197.88.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m733oqRk032062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Aug 2008 20:50:52 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080803025602.GB27465@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/7918/Sat Aug  2 19:45:57 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91201>

Shawn O. Pearce wrote:
> Chunked Transfer Encoding
> -------------------------
> 
> For performance reasons the HTTP/1.1 chunked transfer encoding is
> used frequently to transfer variable length objects.  This avoids
> needing to produce large results in memory to compute the proper
> content-length.

Note: you cannot rely on HTTP/1.1 being supported by an intermediate 
proxy; you might have to handle HTTP/1.0, where the data is terminated 
by connection close.

	-hpa
