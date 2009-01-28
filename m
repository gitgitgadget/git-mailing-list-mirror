From: Alec Clews <alecclews@gmail.com>
Subject: Re: How to install and use a custom merge driver
Date: Wed, 28 Jan 2009 23:04:02 +0000 (UTC)
Message-ID: <loom.20090128T230123-889@post.gmane.org>
References: <497FCC9A.9080008@gmail.com> <20090128061848.GA19165@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 00:26:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSJnl-00039j-BY
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 00:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbZA1XZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 18:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbZA1XZH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 18:25:07 -0500
Received: from main.gmane.org ([80.91.229.2]:50409 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbZA1XZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 18:25:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LSJmI-0003oO-DL
	for git@vger.kernel.org; Wed, 28 Jan 2009 23:25:03 +0000
Received: from 203.110.235.129 ([203.110.235.129])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 23:25:02 +0000
Received: from alecclews by 203.110.235.129 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 23:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.110.235.129 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107595>

Jeff King <peff <at> peff.net> writes:
> On Wed, Jan 28, 2009 at 02:10:18PM +1100, Alec Clews wrote:
> 
> > Setup:
> >
> > I have set up my ..git/info/gitattributes as follows
> >
> > *      merge=overwrite
> 
> Your setup looks right, except that the correct file is
> ".git/info/attributes".

Thanks Jeff

I fixed that problem -- however it did not make any difference.

Is there someway to enable logging to see how git is making this choice?

- Alec
