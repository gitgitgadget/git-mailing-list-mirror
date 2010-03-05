From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/3] hash-object: support --stdin-paths with
	--no-filters
Date: Fri, 5 Mar 2010 03:05:39 -0800
Message-ID: <20100305110539.GA14650@dcvr.yhbt.net>
References: <1267647023-2604-1-git-send-email-kusmabite@gmail.com> <7vmxyo6jpd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org,
	dpotapov@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 05 12:05:47 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnVLm-0000Ug-AB
	for gcvg-git-2@lo.gmane.org; Fri, 05 Mar 2010 12:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab0CELFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 06:05:41 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:41064 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126Ab0CELFk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 06:05:40 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07C001F4F1;
	Fri,  5 Mar 2010 11:05:40 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vmxyo6jpd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141575>

Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@googlemail.com> writes:
> 
> > Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> 
> This looks good to me.  I could queue this myself and ask Eric to Ack the
> other two and queue them on top of it, but it probably is easier for Eric
> if I said
> 
>     Acked-by: Junio C Hamano <gitster@pobox.com>
> 
> now, and ask him to queue the three-patch series including this one in his
> tree, and then tell me to pull the finished result from his tree when he
> is satisfied.  That way it would be easier for Eric to test and/or polish
> if needed.
> 
> Eric, are you Ok with that plan?

Yes, thanks Junio. I've acked and pushed out this series
to git://git.bogomips.org/git-svn along with a trivial fix
by Michael.

Thanks all.

Erik Faye-Lund (3):
      hash-object: support --stdin-paths with --no-filters
      git-svn: support fetch with autocrlf on
      Revert "git-svn: always initialize with core.autocrlf=false"

Michael J Gruber (1):
      git-svn: make git svn --version work again

-- 
Eric Wong
