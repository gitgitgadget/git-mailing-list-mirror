From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH v2 RFC] rebase-i-p: test to exclude commits from todo
 based on its parents
Date: Wed, 8 Oct 2008 20:58:43 -0500
Organization: Exigence
Message-ID: <20081008205843.bd6c297b.stephen@exigencecorp.com>
References: <cover.1223445353.git.stephen@exigencecorp.com>
	<e5ababa1de420b6460fd856679990c9dd2caf1d1.1223445353.git.stephen@exigencecorp.com>
	<7vmyhfr1lb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 03:59:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knkom-0006hd-Qf
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 03:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbYJIB6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 21:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbYJIB6p
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 21:58:45 -0400
Received: from smtp142.sat.emailsrvr.com ([66.216.121.142]:53697 "EHLO
	smtp142.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbYJIB6p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 21:58:45 -0400
Received: from relay4.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay4.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id B65A427B2AE;
	Wed,  8 Oct 2008 21:58:44 -0400 (EDT)
Received: by relay4.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 389BE27B07E;
	Wed,  8 Oct 2008 21:58:44 -0400 (EDT)
In-Reply-To: <7vmyhfr1lb.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97819>


> > +# And rebase G1..M1 onto E3
> 
> I think s/E3/E2/ is what you meant.

Ah, yes.

> If this is the first one in the series, you may want to mark these tests
> with test_expect_failure and make a later patch that changes the behaviour
> of rebase-i-p include updates to the test script to turn expect-failure
> into expect-success.

Sounds good, I will do that.

I haven't seen any other feedback yet--should I repost the series with
these two minor changes right now or wait and see if other feedback
comes up?

Thanks,
Stephen
