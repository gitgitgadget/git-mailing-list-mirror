From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH] add new options to git format-patch: --cover-subject
 and --cover-blurb
Date: Fri, 5 Feb 2010 17:59:01 -0500
Message-ID: <20100205225901.GA29821@cthulhu>
References: <1265405973-5670-1-git-send-email-larry@elder-gods.org>
 <201002051526.18205.wjl@icecavern.net>
 <7vfx5fwbws.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Wesley J. Landaker" <wjl@icecavern.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:59:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdX8s-0000ci-D9
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 23:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934065Ab0BEW7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 17:59:07 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:36632 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934061Ab0BEW7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 17:59:03 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id A674B82217D; Fri,  5 Feb 2010 17:59:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vfx5fwbws.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139105>

* Junio C Hamano (gitster@pobox.com) [100205 17:33]:

> The placeholder in particular and the cover letter itself in general are
> meant to be edited.  I do not see much point in forcing people to edit yet
> another file and have them specify with an cover-blurb option.
> 
> Not very interested.

Yes, they're meant to be edited, but if you look at the steps required to submit
a series with cover letter, it's clear it could be a bit streamlined:

1) make your branch

2) git format-patch --cover-letter

3) edit the cover letter

3) review the series, and realize you need to fix something, fix it.

4) git format-patch --cover-letter again

5) edit the cover letter, *again*.  hopefully you didn't overwrite the old one.

6) git send-email --to myself

7) one last look over it in my inbox

8) git send-email --to the list

The whole thing is a lot less annoying and error-prone if you can have
git-send-email call git-format-patch.  

Besides, you're not forcing anyone to edit an extra file.  If you leave out
--cover-subject or --cover-blurb it just behaves in exactly the same way it
always did.


        --larry
