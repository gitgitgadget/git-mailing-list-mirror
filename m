From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git subtree: an alternative to git submodule
Date: Fri, 15 May 2009 11:11:13 -0700
Message-ID: <7vzldes0ce.fsf@alter.siamese.dyndns.org>
References: <1241822349-27470-1-git-send-email-apenwarr@gmail.com>
	<32541b130905150909h7e596f26w7db6887e7f4267ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 20:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M51sT-0004L7-Pt
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 20:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436AbZEOSLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 14:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756734AbZEOSLR
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 14:11:17 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:52230 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309AbZEOSLN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 14:11:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090515181113.UXUH20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 May 2009 14:11:13 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id ruBD1b0074aMwMQ04uBDvu; Fri, 15 May 2009 14:11:13 -0400
X-Authority-Analysis: v=1.0 c=1 a=-9vSImwV5GIA:10 a=wE1OD5dYPo8A:10
 a=pGLkceISAAAA:8 a=gA0AsRUp7QrWbpFx_0YA:9 a=MchH2Y1InyoGUrY58tsA:7
 a=kW_EZnqCVoIdA2UFXqPk9zk-8t0A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119272>

Avery Pennarun <apenwarr@gmail.com> writes:

> ...  Obviously I would need to write a man page, but I've been
> hesitant to do that in case people have suggestions that need the
> whole UI to change.  Perhaps that's a chicken-and-egg problem, though,...

If you fear that you might get into a situation that the UI _must_ change
because it does not fit people's needs or workflows, that is a sign that
the UI and the workflow it was designed to support may not have been well
thought out yet.  At least, you do not even _know_ if it is well thought
out or not.  It is understandable that people would say "sounds cool,
could potentially be good, but I'll wait and see if it is real" and leave.

With a clear description of "Here is the workflow _I_ assume you use.  If
your usage fits this pattern, this tool may be for you, and here is how it
works and how to use it," it becomes easier for people to say "My usage is
similar but slightly different in this way.  How (perhaps slightly
differently from your description) would I use it?" to help improve the
tool.

Investing the time and effort to get the ball rolling, whether it gets
included in an official tree or not in the immediate future, is a way to
show that the original author _cares_ about the feature.  That would
further help pursuade potential users to look at it.

It is an easy mistake to make to consider inclusion to my tree your goal.
It can be one of the means to give exposure to wider audience, but it does
not have to be your only avenue to do so.

I could throw it in contrib/ but that would help merely by giving easier
access to people who decide that they want to invest their own time to see
if it fits their needs and if they can improve it to match their needs.
You need to do your part of convincing them that it is worth looking at it
first; that is not something "throwing it in contrib/" would help at all.

With proliferation of free hosting services, however, I think contrib/
area for such purposes outlived its usefulness.  People can now fork and
gather interested and enthused users very easily and can make *me* beg to
merge from them to include their new, popular, and already polished
features.
