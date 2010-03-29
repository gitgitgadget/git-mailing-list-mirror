From: Eric Raymond <esr@thyrsus.com>
Subject: Re: CIA hook for contrib/
Date: Mon, 29 Mar 2010 05:04:13 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100329090413.GA10538@thyrsus.com>
References: <20100327102632.GA5043@thyrsus.com>
 <7veij3bqnq.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 29 11:04:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwAtP-0001Jd-JX
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 11:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab0C2JEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 05:04:15 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:48832
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab0C2JEO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 05:04:14 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id C1A99475FEF; Mon, 29 Mar 2010 05:04:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7veij3bqnq.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143449>

Hm...this showed up about two minutes after I sent you private mail 
wondering why nobody had responded to my post.  Sorry about that.

Junio C Hamano <gitster@pobox.com>:
> Eric Raymond <esr@thyrsus.com> writes:
> 
> > Summary:
> > * The CIA hooks for git are presently dusty and somewhat broken.
> 
> Thanks; but I don't ship any ancient hooks, so this probably wants to be
> sent to whoever still have them displayed on their sites.

The ancient hooks are in scattered locations - one in the Cogito repo, another
on some random project site called alphine, and teo stale copies on CIA.vc.
I'm trying to getthese updated.
 
> One tiny nit is the "git --exec-path" bit, though.  You don't seem to use
> any ancient "git-frotz" form, so it is not just unnecessary but is
> misleading.  I'd recommend to just drop it.

I will test and drop that if possible.
 
> Another tiny nit is that you _might_ want to make it fail loudly if
> somebody copies this out of contrib/ without changing $project properly,
> instead of spamming cia with bogus messages claiming that they pertain to
> the GPSD project.

Good idea.  Will do.

> > I am also enclosing a rewrite in Python. This has a serious functional
> > advantage over either Perl or sh; the batteries-included effect of the
> > Python libraries means it's not dependent on things like the path
> > location of sendmail or whether the hosting site will allow it to
> > run wget.
> > ...
> > Code is enclosed.
> 
> Thanks.  Could you send a signed-off patch that creates contrib/ciabot/
> directory, and places these two files in there, with a README describing
> that you are the maintainer of these tools?

I will do so.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
