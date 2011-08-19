From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v4 2/2] push: Don't push a repository with unpushed
	submodules
Date: Fri, 19 Aug 2011 22:44:33 +0200
Message-ID: <20110819204433.GD27639@book.hvoigt.net>
References: <1313312613-2647-1-git-send-email-iveqy@iveqy.com> <20110818192157.GA10598@book.hvoigt.net> <7v4o1ea2at.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 22:44:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuVvl-0006pz-AB
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 22:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649Ab1HSUog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 16:44:36 -0400
Received: from darksea.de ([83.133.111.250]:39760 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754710Ab1HSUof (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 16:44:35 -0400
Received: (qmail 22853 invoked from network); 19 Aug 2011 22:44:33 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 19 Aug 2011 22:44:33 +0200
Content-Disposition: inline
In-Reply-To: <7v4o1ea2at.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179723>

Hi,

On Thu, Aug 18, 2011 at 01:32:26PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> > Since I do not see thisi in pu maybe you missed this? There was a series
> > containing the same patch send before which Jens asked to ignore but
> > this was the one which was meant to be included.
> 
> Hmm, this is how the messages look like in my threaded MUA:
> 
>   [  34: Fredrik Gustafsson     ] [PATCH v4 0/2] push limitations
>    [ 377: Fredrik Gustafsson     ] [PATCH v4 2/2] push: Don't push a reposi...
>    [  35: Jens Lehmann           ] Re: [PATCH v4 0/2] push limitations
>   [ 377: Fredrik Gustafsson     ] [PATCH v4 2/2] push: Don't push a reposit...
>    [  14: Heiko Voigt            ] 
> 
> where Jens says "Please ignore this series, it slipped by accident" in the
> third one. And the second [PATCH v4 2/2] message that you are reminding me
> of (thanks!) has the identical proposed commit log message and patch text
> as the other [PATCH v4 2/2] message.
> 
> So I am not sure what is going on here.

Sorry for confusing you.

There was a patch series which included a patch which was the same as
the patch I replied to. This was sent by accident since it also included
an old patch which was originally part of the 'fg/submodule-git-file-git-dir'
series.

Afterwards Fredrik also sent the same patch on its own again but forgot
to edit the subject. That was the patch to be included. But we already
discovered a small bug in the option parsing and will probably add
another patch implementing the on-demand option. So its probably simpler
if you just wait for our next iteration.

> Also I vaguely recall that I said something about the command line parser
> for this new option during the review of the previous round. Has that been
> resolved/corrected?

We plan to make the --recurse-submodules option symmetric to the one
already implemented in fetch. AFAIK, having a mixed boolean and other
values option is only possible by using a callback. To make extending it
simpler we decided to put the necessary infrastructure already in place.

Cheers Heiko
