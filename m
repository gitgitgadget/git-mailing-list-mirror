From: David Meybohm <dmeybohmlkml@bellsouth.net>
Subject: Re: SHA1 hash safety
Date: Wed, 20 Apr 2005 14:56:53 -0400
Message-ID: <20050420185653.GA3076@localhost>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz> <20050416123155.GA19908@elte.hu> <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz> <4261132A.3090907@khandalf.com> <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu> <4261852B.6090507@khandalf.com> <20050418074323.GA29765@hexapodia.org> <20050419223027.GA26100@localhost> <Pine.LNX.4.61.0504191848300.29929@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Isaacson <adi@hexapodia.org>, omb@bluewin.ch,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 20:53:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOKJc-0001d3-N5
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 20:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVDTS5B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 14:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVDTS5B
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 14:57:01 -0400
Received: from imf17aec.mail.bellsouth.net ([205.152.59.65]:29570 "EHLO
	imf17aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261471AbVDTS44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 14:56:56 -0400
Received: from localhost ([65.10.203.194]) by imf17aec.mail.bellsouth.net
          (InterMail vM.5.01.06.11 201-253-122-130-111-20040605) with ESMTP
          id <20050420185656.LEUH2434.imf17aec.mail.bellsouth.net@localhost>;
          Wed, 20 Apr 2005 14:56:56 -0400
To: "C. Scott Ananian" <cscott@cscott.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504191848300.29929@cag.csail.mit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 06:48:57PM -0400, C. Scott Ananian wrote:
> On Tue, 19 Apr 2005, David Meybohm wrote:
> 
> >But doesn't this require assuming the distribution of MD5 is uniform,
> >and don't the papers finding collisions in less show it's not? So, your
> >birthday-argument for calculating the probability wouldn't apply, because
> >it rests on the assumption MD5 is uniform, and it isn't.
> 
> No, the collision papers don't show this at all.

I didn't mean they showed it directly. I meant by finding collisions in
MD5 quickly, MD5 would have to have some non-uniformity. But that's
nevertheless wrong because uniformness and collision finding ability
aren't related. Sorry to have wasted everyone's time.

Dave
