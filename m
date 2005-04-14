From: Christopher Li <git@chrisli.org>
Subject: Re: Yet another base64 patch
Date: Wed, 13 Apr 2005 22:24:13 -0400
Message-ID: <20050414022413.GB18655@64m.dyndns.org>
References: <425DEF64.60108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 07:31:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLwwP-0000Xw-Oi
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 07:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVDNFeM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 01:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVDNFeM
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 01:34:12 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:22188 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261287AbVDNFeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 01:34:09 -0400
Received: from localhost.localdomain (c-24-6-236-77.hsd1.ca.comcast.net[24.6.236.77])
          by comcast.net (sccrmhc12) with ESMTP
          id <2005041405340901200ki0cfe>; Thu, 14 Apr 2005 05:34:09 +0000
Received: by localhost.localdomain (Postfix, from userid 1027)
	id 7E8493F1EF; Wed, 13 Apr 2005 22:24:13 -0400 (EDT)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <425DEF64.60108@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2005 at 09:19:48PM -0700, H. Peter Anvin wrote:
> Checking out the total kernel tree (time checkout-cache -a into an empty 
> directory):
> 
> 	Cache cold	Cache hot
> stock	3:46.95		19.95
> base64	5:56.20		23.74
> flat	2:44.13		15.68


> It seems that the flat format, at least on ext3 with dircache, is 
> actually a major performance win, and that the second level loses quite 
> a bit.

That is not surprising due to the directory index in ext3. Htree is pretty
good at random access and the hashed file name distribute evenly, that is
the best case for htree. 

Chris

