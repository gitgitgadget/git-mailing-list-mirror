From: Roman Neuhauser <neuhauser@sigpipe.cz>
Subject: Re: git-diff-tree --root
Date: Sat, 13 Sep 2014 10:57:35 +0200
Message-ID: <20140913085735.GA4075@isis.sigpipe.cz>
References: <20140912130607.GX4075@isis.sigpipe.cz>
 <xmqq61gsbv9p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 10:57:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSj9K-0004Cf-VG
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 10:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbaIMI5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 04:57:38 -0400
Received: from fw.sigpipe.cz ([213.192.55.98]:17521 "EHLO isis.sigpipe.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbaIMI5h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 04:57:37 -0400
Received: by isis.sigpipe.cz (Postfix, from userid 1001)
	id 74271435A80; Sat, 13 Sep 2014 10:57:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqq61gsbv9p.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256956>

# gitster@pobox.com / 2014-09-12 10:31:30 -0700:
> Roman Neuhauser <neuhauser@sigpipe.cz> writes:
> > git-diff-tree without --root is absolutely silent for the root commit,
> > and i see no bad effects of --root on non-root commits.  are there any
> > hidden gotchas?  IOW, why is the --root behavior not the default?
> 
> Because tools that was written before you proposed that change
> expect to see nothing for the root commit, and then you are suddenly
> breaking their expectations?

i'm not proposing anything, i'm just curious why it is this way.
my line of thinking: there must be (or have been) a grave reason to
break the simple consistency, or the current behavior must be very
useful for something and i'm just missing what it is.  the reasons
for the behavior may have been invalidated by further developments,
or it may have been a wrong decision we're stuck with for BC; i'm
just curious about history.

motivation for my question is that i'm scripting git-diff-tree
and i need it to produce the diff for root commits as well.  i like
my scripts as simple as possible, so i'd like to use --root *always*.
is it safe?

-- 
roman
