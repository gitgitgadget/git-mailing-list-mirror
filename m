From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 07/13] Add a config option for remotes to specify a foreign vcs
Date: Wed, 5 Aug 2009 01:09:56 -0400
Message-ID: <825BD79D-F4F0-404F-A320-2D6AE94DE6D7@silverinsanity.com>
References: <alpine.LNX.2.00.0908050055500.2147@iabervon.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYt2-00027G-TX
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 07:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755554AbZHEFR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 01:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755465AbZHEFR2
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 01:17:28 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:46466 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460AbZHEFR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 01:17:27 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2009 01:17:27 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 7C8401FFC03E; Wed,  5 Aug 2009 05:09:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.3] (cpe-67-240-168-84.rochester.res.rr.com [67.240.168.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 48C501FFC001;
	Wed,  5 Aug 2009 05:09:47 +0000 (UTC)
In-Reply-To: <alpine.LNX.2.00.0908050055500.2147@iabervon.org>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124867>


On Aug 5, 2009, at 1:02 AM, Daniel Barkalow wrote:

> If this is set, the url is not required, and the transport always uses
> a helper named "git-remote-<value>".

> +remote.<name>.vcs::
> +	Setting this to a value <vcs> will cause git to interact with
> +	the remote with the git-vcs-<vcs> helper.


I can't tell from the code, but one of these has to be wrong.

~~ Brian
