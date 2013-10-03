From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCH] git svn: Set default --prefix='origin/' if --prefix
 is not given
Date: Thu, 3 Oct 2013 19:01:39 +0000
Message-ID: <20131003190139.GA8710@dcvr.yhbt.net>
References: <CALKQrgeXAtWeTedqkVtcTAUgbsBA9U6rbqUntu_ArmPgL9R3pg@mail.gmail.com>
 <1380581194-5269-1-git-send-email-johan@herland.net>
 <20131001040752.GA882@dcvr.yhbt.net>
 <CALKQrgf0tBN9ymZ0Yq6iW95dwayhJC1a_9LZBagW6B_hBo5owA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 03 21:01:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRo9g-0000nL-Id
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 21:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806Ab3JCTBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Oct 2013 15:01:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51838 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754397Ab3JCTBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Oct 2013 15:01:40 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923051F523;
	Thu,  3 Oct 2013 19:01:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CALKQrgf0tBN9ymZ0Yq6iW95dwayhJC1a_9LZBagW6B_hBo5owA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235689>

Johan Herland <johan@herland.net> wrote:
> On Tue, Oct 1, 2013 at 6:07 AM, Eric Wong <normalperson@yhbt.net> wrote:
> > How about we put a big warning of impending change in there for now and
> > wait until git 1.9/2.0 to make the actual change?
> 
> Sounds sensible. What should the warning look like, and where should
> it be placed? I'm thinking that if you run git svn init/clone without
> --prefix, there should be a verbose warning explaining (a) the trouble
> you're likely to encounter when using no prefix, and (b) the upcoming
> change in default prefix. Obviuosly, there should be a corresponding
> note in the git-svn manual page. Any other places in git.git that
> warrants changing? Hopefully this should be sufficient to trigger
> corresponding adjustments in third-party tools + docs ahead of the
> actual change in 1.9/2.0.

Probably, yes.  I don't remember off the top of my head if there's
other places, but init/clone should be a good enough start.
