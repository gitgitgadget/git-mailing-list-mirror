From: Sebastian Bober <seb@tix64.net>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 2 Jun 2008 13:56:22 +0200
Message-ID: <20080602115622.GC32553@post.servercare.de>
References: <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 14:46:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K39R5-0001iJ-MI
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 14:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757877AbYFBMps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 08:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758119AbYFBMps
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 08:45:48 -0400
Received: from tix64.net ([81.169.172.224]:57287 "EHLO tix64.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747AbYFBMpr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 08:45:47 -0400
X-Greylist: delayed 2962 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jun 2008 08:45:47 EDT
Received: from bob by tix64.net with local (Exim 4.69)
	(envelope-from <bob@tix64.net>)
	id 1K38eE-0005eU-7M; Mon, 02 Jun 2008 13:56:22 +0200
Mail-Followup-To: Sebastian Bober <seb@tix64.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-bounce-key: tix64.net-1;bob@tix64.net;1212410747;7fd8ecd7;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83517>

On Mon, Jun 02, 2008 at 12:58:03AM -0700, Junio C Hamano wrote:
> 
> I've looked at the Git.pm testsuite that uses Test::More briefly but
> hadn't really reviewed it.  Is Test::More commonly used, considered solid
> and widely available?

yes it is on all three points. It is the most commonly used test module
for Perl, used by thousands of CPAN distributions. Test::More is
delivered as core module since 5.8.0 or 5.6.2, so is widely deployed. It
is actively maintained and is integrated in a test framework that allows
the use and development of further "plug-in" test modules. With that
it's conceivable to write a test module specifically for git and its
usage scenarios.

Regards,
  Sebastian
