From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFCv3 1/2] gitweb: add patch view
Date: Sat, 6 Dec 2008 14:10:58 +0100
Message-ID: <20081206131058.GB10491@machine.or.cz>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com> <1228345188-15125-2-git-send-email-giuseppe.bilotta@gmail.com> <200812060134.22959.jnareb@gmail.com> <7vabbaxh8y.fsf@gitster.siamese.dyndns.org> <cb7bb73a0812060501s6a3faea7l74e81c2a591ba2a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 14:12:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8wxI-0000Ui-OT
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 14:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755669AbYLFNLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 08:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755659AbYLFNLA
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 08:11:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:33315 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754853AbYLFNLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 08:11:00 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 54456393984E; Sat,  6 Dec 2008 14:10:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cb7bb73a0812060501s6a3faea7l74e81c2a591ba2a7@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102454>

On Sat, Dec 06, 2008 at 02:01:09PM +0100, Giuseppe Bilotta wrote:
> On Sat, Dec 6, 2008 at 1:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Some things, like sitewide default css changes, cannot be made disabled
> > by default.  But a new feature can easily be kept disabled by default not
> > to cause needless surprises.
> 
> In the eternal war between making feature easily available and not
> disturbing the user too much between upgrades, I'm more on the 'making
> available' field, especially when the features are not particularly
> invasive (e.g., the patch view only adds one single link, on the
> navigation bar, and only in some views).
> 
> It should also be noted that if the sysadmin deploys a new software
> version without telling its users, there's an obvious communication
> problem between the sysadmin and its users, but that's not something
> the tool developers should try to work around. Otherwise we'd still be
> offering the dash version of the commands by default.

I feel exactly the same.

Acked-by: Petr Baudis <pasky@suse.cz>

Same goes for the patches, I haven't had time to examine them in detail
but the general shape looks fine.
