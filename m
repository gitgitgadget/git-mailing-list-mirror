From: Heikki Orsila <shd@modeemi.fi>
Subject: Re: Re* [PATCH] Add --filedirstat diff option
Date: Wed, 3 Sep 2008 03:39:17 +0300
Message-ID: <20080903003916.GD1252@jolt.modeemi.cs.tut.fi>
References: <20080901011259.GA31696@zakalwe.fi> <7vd4jnnifp.fsf@gitster.siamese.dyndns.org> <20080902115848.GA1252@jolt.modeemi.cs.tut.fi> <7vwshuglq1.fsf@gitster.siamese.dyndns.org> <7v3akigl1g.fsf@gitster.siamese.dyndns.org> <20080903000827.GB1252@jolt.modeemi.cs.tut.fi> <7vbpz6dqd0.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 02:40:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KagQa-0005Gm-8B
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 02:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172AbYICAju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 20:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbYICAju
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 20:39:50 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:52521 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbYICAjt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 20:39:49 -0400
Received: from amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70])
	by mail.cs.tut.fi (Postfix) with ESMTP id 8CECDD05C;
	Wed,  3 Sep 2008 03:39:48 +0300 (EEST)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis2.cs.tut.fi (amavis2.cs.tut.fi [130.230.4.70]) (amavisd-maia, port 10024)
 with ESMTP id 19903-22; Wed,  3 Sep 2008 03:39:47 +0300 (EEST)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 7251DD05A;
	Wed,  3 Sep 2008 03:39:47 +0300 (EEST)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id 3E02D22201;
	Wed,  3 Sep 2008 03:39:17 +0300 (EEST)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id 1EC1EA317C; Wed,  3 Sep 2008 03:39:17 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <7vbpz6dqd0.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94752>

On Tue, Sep 02, 2008 at 05:28:59PM -0700, Junio C Hamano wrote:
> But you are right to point out that --cumulative is an option that affects
> how --dirstat operates.  And I think the option parsing of that code is
> buggy.  It should imply --dirstat, shouldn't it?

Yes.

> Here is a sample patch to fix --cumulative (but of course it is untested);
> I think your --filemode (or whatever its final name is) should hook into
> the same place as this patch touches, as far as command line parsing is
> concerned.

I'll prepare something later today..

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
