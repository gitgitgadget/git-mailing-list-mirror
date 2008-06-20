From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: git svn --use-log-author misbehavior?
Date: Fri, 20 Jun 2008 12:48:02 +0200
Message-ID: <20080620104802.GA9690@cuci.nl>
References: <485AF10B.7060202@mircea.bardac.net> <20080620085618.GA27940@frsk.net> <485B82BD.2000404@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Fredrik Skolmli <fredrik@frsk.net>
To: Mircea Bardac <dev@mircea.bardac.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 12:49:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9eAv-0002dw-Ca
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 12:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbYFTKsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 06:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbYFTKsE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 06:48:04 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:58312 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbYFTKsE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 06:48:04 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id B103B545E; Fri, 20 Jun 2008 12:48:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <485B82BD.2000404@mircea.bardac.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85617>

Mircea Bardac wrote:
>I haven't tested this yet but I have a feeling this is not my case, or I 
>might not be fully understanding the implications of "--add-author-from" 
>on the functionality of "--use-log-author". Technically, they should be 
>independent and the options should not depend on each other:
>* --use-log-author only applies to getting info from the commits
>* --add-author-from only applies to putting info in the commits

They are independent.

>From the documentation, these 2 options can only be used with git svn 
>init/clone so they should somehow be saved for future use. Maybe this 
>doesn't happen.

At least --use-log-author can be used on git svn fetch (and possibly
other subcommands) as well.
And no, it currently is not being saved.
-- 
Sincerely,
           Stephen R. van den Berg.

Confidence is that feeling you have before you understand the situation.
