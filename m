From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: warning: no common commits - slow pull
Date: Sun, 10 Feb 2008 22:55:01 -0500
Message-ID: <20080211035501.GB26205@mit.edu>
References: <200802102007.38838.lenb@kernel.org> <20080211015342.GA26205@mit.edu> <7v4pcgcimw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Len Brown <lenb@kernel.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 05:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOPrt-0001uP-07
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 05:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbYBKEBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 23:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbYBKEBU
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 23:01:20 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:56315 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752645AbYBKEBT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 23:01:19 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m1B3wRt5019552;
	Sun, 10 Feb 2008 22:59:01 -0500 (EST)
Received: from closure.thunk.org (c-66-30-1-139.hsd1.ma.comcast.net [66.30.1.139])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m1B3t1nX016547
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 10 Feb 2008 22:55:02 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JOPkz-0004Bq-Eu; Sun, 10 Feb 2008 22:55:01 -0500
Content-Disposition: inline
In-Reply-To: <7v4pcgcimw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73464>

On Sun, Feb 10, 2008 at 06:49:11PM -0800, Junio C Hamano wrote:
> I am aware of that "push" side thing (basically it does not do
> the negotiation and unless you are always doing fast-forward
> pushes it tends to send needless stuff), but I had an impression
> that the issue Len is raising is different.  Namely if you pull
> from Linus twice into the same tree you should never see that
> "No common commits".

Yeah, when I saw your response to him I realized that.  I didn't
notice the "No common commits" message in his transcript, and assumed
he was referring to the problem I was describing.

I wouldn't mind waiting myself, but it does result in uneeded objects
in the destination repository, which I gather results in slightly more
disk load on the kernel.org servers since there's slightly less object
sharing, and sometimes I'm pushing from behind a slow link (such as an
EVDO wireless modem), and pushing the few megabytes worth of shared
objects can take a while.  So I've just always gotten in the habit of
shelling into master.kernel.org and manually doing the git-update-ref;
one of these days I'll get around to scripting it.

						- Ted
