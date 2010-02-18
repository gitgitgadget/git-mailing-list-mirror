From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn checksum mismatch
Date: Thu, 18 Feb 2010 15:08:12 -0800
Message-ID: <20100218230812.GA20034@dcvr.yhbt.net>
References: <fa34f1941002170821p66cf0ac7i9385b341c94993c3@mail.gmail.com> <20100218005347.GA8528@dcvr.yhbt.net> <fa34f1941002180652wb91c36bt8feba5c7f653701d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jason Baker <jbaker@zeomega.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 00:08:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiFTm-0007Ky-5V
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 00:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab0BRXIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 18:08:13 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:49441 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab0BRXIN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 18:08:13 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 847871F4FA;
	Thu, 18 Feb 2010 23:08:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fa34f1941002180652wb91c36bt8feba5c7f653701d@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140392>

Jason Baker <jbaker@zeomega.com> wrote:
> This works:
> 
> $ svn co $URL/branches/jiva_model_0.6-Jiva-4.5.0/src/jiva_model/schema/ -r
> 57269
> Checked out revision 57269.
> 
> $ cd schema
> 
> $ svn up -r 57270
> At revision 57270.
> 
> So does this mean there's a problem on my side somewhere?

Did r57270 change anything at all in the directories you're tracking?
You might need to step the revision up to the next one you're
tracking...

Not sure what else could be the cause...  Did you run out of disk space
or encounter any hardware failures at any time during the fetches?

-- 
Eric Wong
