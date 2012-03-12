From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Mon, 12 Mar 2012 16:16:10 -0400
Message-ID: <4F5E598A.5020407@xiplink.com>
References: <vpqobs65gfc.fsf@bauges.imag.fr> <1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr> <1331288715.21444.38.camel@beez.lab.cmartin.tk> <4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu> <4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr> <20120312183725.GA2187@sigill.intra.peff.net> <7vfwddskon.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?ISO-8859-1?Q?Carlos_Mart=ED?= =?ISO-8859-1?Q?n_Nieto?= 
	<cmn@elego.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:16:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7BfE-0002FC-Ox
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 21:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757074Ab2CLUQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 16:16:12 -0400
Received: from smtp182.dfw.emailsrvr.com ([67.192.241.182]:55876 "EHLO
	smtp182.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947Ab2CLUQL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 16:16:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp8.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id D29DE81B1;
	Mon, 12 Mar 2012 16:16:10 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp8.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1B4A481A1;
	Mon, 12 Mar 2012 16:16:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vfwddskon.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192938>

On 12-03-12 03:06 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>> 
>> So far a lot of the discussion has focused on "what is the most sensible
>> default for the most number of people". But I wonder if a better
>> question is "what is the default that is the least likely to do
>> something dangerous and embarrassing". People who use git enough to say
>> "wow, I don't like this default for my workflow" are probably at the
>> point that they can configure push.default themselves.
> 
> I do not think "the most number of people" is a high-priority issue,
> but "least damage" default may not be necessarily the best.

I agree, but I don't think we even have a good idea of what "least damage"
even means.  It seems to be vaguely related to how much of a hassle it would
be to recover from a plain "git push" doing the wrong thing.

There's one thing I'd like to ask all the folks who are pointing out how well
the candidate defaults match various workflows:  How much training do you
give (or are assuming for) your workflow's new users?

Or, more broadly, what is a "new" git user?  Are we talking about someone
using git for the first time on a brand-new project that they're setting up
themselves?  (Has that person even used any other VCS's?)

Or is it someone who's joining an already-established team?  Even a "new"
user hacking the Linux kernel or forking some github project is tying into an
established process.  And most every established process has either
documentation (or a person) to explain how things are set up, and how to best
configure git to work in that environment.

IMHO git need not worry about "new" users joining an established process, if
for no other reason that it seems impossible to make git new-user-friendly in
all (or even most) of those environments.

Instead the focus should be on new users who are wrestling with git by
themselves (well, hopefully with the help whatever online documentation
they've found).  They're making up their workflows as they go, refining them
as they learn more about git.  These are the users that git's defaults should
cater to.

And for those users, I still think "upstream" is the best of the current
default candidates.

> Obviously, "nothing" is the least-damage option, and looking at how
> even people on this list cannot decide between current and upstream,
> I actually am very tempted to suggest it as the new default.

There's a lot of merit to that.  If nothing else, it'd get new users to learn
at least a little bit about git.  I wouldn't be opposed to pushing nothing by
default.

		M.
