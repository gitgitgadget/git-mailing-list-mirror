From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Mon, 25 Jun 2007 10:03:02 +0200
Organization: eudaptics software gmbh
Message-ID: <467F76B6.2D814459@eudaptics.com>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <81b0412b0706231404hc8b4bc4xd5bc51c733d8ea69@mail.gmail.com> <9C4338DC-0C4A-4981-9EC9-2417513F629D@zib.de> <467F6BB0.4C7F041E@eudaptics.com> <21FC6948-6969-47A4-9D6E-EFD9D98FC361@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jun 25 10:03:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2jXG-0006rC-Gt
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 10:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbXFYICz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 04:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbXFYICy
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 04:02:54 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9158 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbXFYICx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 04:02:53 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1I2jX6-0002ji-UX; Mon, 25 Jun 2007 10:02:49 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AC97D29AB; Mon, 25 Jun 2007 10:02:48 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.028
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50881>

Steffen Prohaska wrote:
> 
> On Jun 25, 2007, at 9:16 AM, Johannes Sixt wrote:
> >  $ echo "$(git-rev-parse from^0) $(git-rev-parse onto^0)" \
> >     > .git/info/grafts
> >  $ git-filter-branch new-to onto..to
> 
> ... ok this is interesting: git-filter-branch will take the info from
> grafts to create its new commits. The new commits will contain all
> information independent of the grafts file, right?

Yes.

> ... but, I'm not convinced that this is what I need. I need to mix the
> tree of onto with the files _modified_ between from..to. Taking _all_
> files from the commits between from..to is _wrong_. And I think that
> is what the command you proposed would do.

My proposed commands won't do what you need. They just change
parenthood, but not the tree snapshots that they represent.

-- Hannes
