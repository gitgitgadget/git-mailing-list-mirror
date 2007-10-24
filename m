From: Scott Parish <sRp@srparish.net>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 24 Oct 2007 09:08:52 -0700
Message-ID: <20071024160852.GA759@srparish.net>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 18:09:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkinB-0005ed-R5
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 18:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435AbXJXQI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 12:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756039AbXJXQI4
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 12:08:56 -0400
Received: from smtp-gw8.mailanyone.net ([208.70.128.73]:53045 "EHLO
	smtp-gw8.mailanyone.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908AbXJXQIz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 12:08:55 -0400
Received: from mailanyone.net
	by smtp-gw8.mailanyone.net with esmtps (TLSv1:AES256-SHA:256)
	(MailAnyone extSMTP srp)
	id 1Ikimr-0004Cw-5e; Wed, 24 Oct 2007 11:08:53 -0500
Received: by srparish.net (nbSMTP-1.00) for uid 502
	(using TLSv1/SSLv3 with cipher AES256-SHA (256/256 bits))
	srp@srparish.net; Wed, 24 Oct 2007 09:08:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzly84qwf.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62220>

On Wed, Oct 24, 2007 at 05:51:28AM -0700, Junio C Hamano wrote:

> * js/PATH (Sun Oct 21 22:59:01 2007 +0100) 1 commit
>  - execv_git_cmd(): also try PATH if everything else fails.
> 
> I do not quite get why this is needed; need to go back to the
> discussion myself.  On the other hand, I found the alternative
> approach suggested on the list very interesting (i.e. instead of
> "also try", just letting exec*p use PATH, relying on the fact
> that we do prepend-to-path anyway).  What happened to it?  Was
> there a downside?

The main downside that was raised was MingW compatibility, but
Schindelin and Sixt both said that it could wait until further
work is done porting to MingW.

Should i resend my string of patches? I've seen people numbering
their patches, should i do that as well?

Thanks
sRp

-- 
Scott Parish
http://srparish.net/
