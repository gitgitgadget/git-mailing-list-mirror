From: bdowning@lavos.net (Brian Downing)
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 09:02:09 -0600
Message-ID: <20071119150209.GF6212@lavos.net>
References: <1195477504.8093.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Juselius <jonas.juselius@chem.uit.no>
X-From: git-owner@vger.kernel.org Mon Nov 19 16:02:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu88s-0003Iv-Em
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 16:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbXKSPCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 10:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754237AbXKSPCN
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 10:02:13 -0500
Received: from mxsf02.insightbb.com ([74.128.0.63]:7694 "EHLO
	mxsf02.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbXKSPCM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 10:02:12 -0500
X-IronPort-AV: E=Sophos;i="4.21,437,1188792000"; 
   d="scan'208";a="109054391"
Received: from unknown (HELO asav02.insightbb.com) ([172.31.249.124])
  by mxsf02.insightbb.com with ESMTP; 19 Nov 2007 10:02:10 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAHM0QUdKhvkY/2dsb2JhbACBWA
X-IronPort-AV: E=Sophos;i="4.21,437,1188792000"; 
   d="scan'208";a="162238261"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav02.insightbb.com with ESMTP; 19 Nov 2007 10:02:10 -0500
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 17D94309F21; Mon, 19 Nov 2007 09:02:10 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <1195477504.8093.15.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65451>

On Mon, Nov 19, 2007 at 02:05:04PM +0100, Jonas Juselius wrote:
> I have also written a CVS2git transition guide, which outlines one
> possible way of converting from CVS to git.

You write:

> In order to save space you can also enable compression
> $ git config --global core.compression 1
> $ git config --global core.loosecompression 1

I think this contradicts the git-config manpage:

>  core.compression
>      An integer -1..9, indicating a default compression level. -1 is the
>      zlib default. 0 means no compression, and 1..9 are various
>      speed/size tradeoffs, 9 being slowest.

>  core.loosecompression
>      An integer -1..9, indicating the compression level for objects that
>      are not in a pack file. -1 is the zlib default. 0 means no
>      compression, and 1..9 are various speed/size tradeoffs, 9 being
>      slowest. If not set, defaults to core.compression. If that is not
>      set, defaults to 0 (best speed).

The default, -1, is the zlib default, which is probably something like 3-6.
Setting these to 1 will probably result in less compression, not more.

-bcd
