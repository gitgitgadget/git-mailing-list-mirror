From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: merging question
Date: Mon, 30 Jan 2006 20:14:24 +0100
Message-ID: <20060130191424.GA15953@ebar091.ebar.dtu.dk>
References: <43DE3D73.60904@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 30 20:15:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3eUY-0005h8-CJ
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 20:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWA3TPE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 14:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWA3TPE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 14:15:04 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:19349 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S964893AbWA3TPC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 14:15:02 -0500
Received: (qmail 16310 invoked by uid 5842); 30 Jan 2006 19:14:24 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <43DE3D73.60904@f2s.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15289>

On Mon, Jan 30, 2006 at 04:23:15PM +0000, Ian Molton wrote:
> Is it possible to merge all the changes up to a specific tagged version 
> of another branch ?
> 
> I'd like to pull all the changes up to 2.6.15 into a branch created from 
> 2.6.12, which has been subsequently modified. I dont yet want to pull 
> later changes in.

This is what I tried to do, and it seems to work:

git checkout -b mywork v2.6.12
# work, work, work
git commit -a
git merge "Merging happily." mywork v2.6.15

The man pages can explain it better than I can.

> on a side note, how does one pull in an individual changeset, rather 
> than the head of an entire branch ?

Look into git-cherry and git-cherry-pick.

Regards,

Peter
