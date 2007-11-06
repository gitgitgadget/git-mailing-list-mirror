From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Tue, 6 Nov 2007 21:06:56 +0100
Message-ID: <200711062106.57083.robin.rosenberg.lists@dewire.com>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <7vode8j7o5.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711061230540.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 21:06:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUgD-00060h-MR
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 21:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbXKFUF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 15:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754031AbXKFUF0
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 15:05:26 -0500
Received: from [83.140.172.130] ([83.140.172.130]:28430 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbXKFUFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 15:05:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DEF0414706CD;
	Tue,  6 Nov 2007 20:56:25 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02533-07; Tue,  6 Nov 2007 20:56:25 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 7F90A14706CC;
	Tue,  6 Nov 2007 20:56:25 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0711061230540.4362@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63710>

tisdag 06 november 2007 skrev Johannes Schindelin:
> Hi,
> 
> On Mon, 5 Nov 2007, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Mon, 5 Nov 2007, Junio C Hamano wrote:
> > >
> > >> Allowing people to revert or cherry pick partially by using paths 
> > >> limiter is a very good idea; the whole "it comes from a commit so we 
> > >> also commit" feels an utter nonsense, though.
> > >
> > > No.
> > >
> > > When "git revert <commit>" commits the result, "git revert <commit> -- 
> > > <file>" should, too.
> > 
> > I was not questioning about that part.  "If 'git revert <some
> > other form> foo' does not talk about commit, it should not
> > commit" was what I was referring to.
> 
> Well, I think that _if_ we allow "git revert <path>" to mean "revert the 
> changes to <path>, relative to the index" (which would be the same as "git 
> checkout <path>"), then committing that change just does not make sense.
> 
> And it is this behaviour that people are seeking, not "git revert <commit> 
> <path>".

I'm not convince making every command perform enitrely all kinds of actions 
just because other SCMs interpret a name differently. git revert today 
creates a *new* commit. Keep it simple. I think its ok that it mentions 
another comnand when it detects arguments that does not make sense. There is 
no right or wrong with interepreting reset either way, but not both ways 
please. The confusion with checkout and reset is enough.

-- robin
