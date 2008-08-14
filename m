From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: [PATCH 00/12] Allow users to access Perforce repositories
 requiring authentication
Date: Thu, 14 Aug 2008 22:01:29 +0000 (UTC)
Message-ID: <g829vo$q9j$2@ger.gmane.org>
References: <1218392795-4084-1-git-send-email-wildfire@progsoc.org>
	<1a6be5fa0808141000w78b54bc2x1262b814f36ecdd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 00:03:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTkuE-0004Bh-H0
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbYHNWBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbYHNWBk
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:01:40 -0400
Received: from main.gmane.org ([80.91.229.2]:51661 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbYHNWBj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:01:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KTksz-0000aD-Qp
	for git@vger.kernel.org; Thu, 14 Aug 2008 22:01:38 +0000
Received: from 62-31-42-82.cable.ubr03.dals.blueyonder.co.uk ([62.31.42.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 22:01:37 +0000
Received: from wildfire by 62-31-42-82.cable.ubr03.dals.blueyonder.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 22:01:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 62-31-42-82.cable.ubr03.dals.blueyonder.co.uk
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92410>


Hi Tor,

On Thu, 14 Aug 2008 19:00:12 +0200, Tor Arvid Lund wrote:

> I had an issue when using git p4 submit, and I had newly added files in
> the changelist. This, I think, is caused by a call to "p4 opened" that
> was not converted to use your new p4_build_cmd function. So I don't
> think your patches should be merged to master before this is fixed.
> However, when applying the simple diff below, this works for me.

Thanks for catching this. I found a few other occurances similar to the 
one you mentioned. I will send out an updated patch momentarily.

Thanks,
Anand
