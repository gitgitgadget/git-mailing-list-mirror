From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Merging repositories and their histories
Date: Mon, 18 Aug 2008 19:35:11 +0200
Message-ID: <20080818173511.GC6014@blimp.local>
References: <19035412.post@talk.nabble.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Waller <peter.waller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 19:36:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV8eV-0006EQ-06
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 19:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbYHRRfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 13:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbYHRRfP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 13:35:15 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:45141 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbYHRRfO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 13:35:14 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44getV
Received: from tigra.home (Fa92c.f.strato-dslnet.de [195.4.169.44])
	by post.webmailer.de (fruni mo2) (RZmta 16.47)
	with ESMTP id Z06d81k7IEWgyq ; Mon, 18 Aug 2008 19:35:11 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id C4DF3277AE;
	Mon, 18 Aug 2008 19:35:11 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id B2B8D36D1A; Mon, 18 Aug 2008 19:35:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <19035412.post@talk.nabble.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92721>

Peter Waller, Mon, Aug 18, 2008 18:46:14 +0200:
> 
> I have three repositories, A, B and C. I wish to bring them together to only
> one repository (.), where they are in a directory called ./Archive, so..
> ./Archive/{A,B,C}. Then I plan at a later date to move files arbitrarily
> from ./Archive/{A/B/C}/Something and into ./Something{A/B/C}. (A lame
> example, but illustrates what I want to do).

If this transition is meant to be persistent (IOW, the A, B and C stop
existing as repos on their own) you can rewrite their histories to be
in the directories (with git filter-branch) and just merge them in
one. Then the histories will look like as if they have never grown
separately.
