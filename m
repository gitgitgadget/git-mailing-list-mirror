From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 18 Jul 2008 11:44:04 +0200
Message-ID: <20080718094404.GB32184@machine.or.cz>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org> <7vlk01hqzz.fsf@gitster.siamese.dyndns.org> <20080718175040.6117@nanako3.lavabit.com> <20080718182010.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 11:45:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJmWR-0008NC-80
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 11:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbYGRJoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 05:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753897AbYGRJoH
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 05:44:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53638 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754098AbYGRJoH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 05:44:07 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id C985D2C4C029; Fri, 18 Jul 2008 11:44:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080718182010.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89022>

On Fri, Jul 18, 2008 at 06:20:10PM +0900, Nanako Shiraishi wrote:
> I do not know if "I do not understand what they did well enough" is the only reason people would want to use that feature. Isn't it better to let people decide that for themselves?

It is dangerous to introduce new options just because we think someone,
sometimes might find it useful, especially if they potentially encourage
a bad workflow. Adding options and commands is expensive since it
complicates the UI further, thus we should add further only when we have
good reason for it.

> > That also was the reason I did not add any documentation to it.

I was actually looking for something like this based on some question on
#git (about git pull -s theirs possibility), and did stumble upon these
patches, but quickly gave up on them since it wasn't immediately clear
for me from the patch description exactly how the workflow looks like
(it doesn't really seem to work like the opposite of -s ours nor is it a
separate strategy... huh) and the options were completely undocumented.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
