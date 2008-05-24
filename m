From: Adam Simpkins <adam@adamsimpkins.net>
Subject: [PATCH 0/1] graph API: always print 'M' for merge commits
Date: Sat, 24 May 2008 13:52:00 -0700
Message-ID: <1211662321-28846-1-git-send-email-adam@adamsimpkins.net>
References: <20080524182530.GB2997@mithlond.arda.local>
Cc: Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Adam Simpkins <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 22:53:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K00jj-0003Ei-PP
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 22:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760619AbYEXUwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 16:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760995AbYEXUwI
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 16:52:08 -0400
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:41866 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760468AbYEXUwG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 16:52:06 -0400
Received: from relay8.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay8.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id D51411B537F;
	Sat, 24 May 2008 16:52:03 -0400 (EDT)
Received: by relay8.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id AFBD71B58BA;
	Sat, 24 May 2008 16:52:03 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 12CAD14100C9; Sat, 24 May 2008 13:52:01 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.385.ge74ed
In-Reply-To: <20080524182530.GB2997@mithlond.arda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82831>

On Sat, May 24, 2008 at 09:25:30PM +0300, Teemu Likonen wrote:
> 
> I'd rather show merge commits always with M. They are still conceptually
> merges even if the current log view shows only one parent. This patch
> changes symbols * and M to be visual symbols, not logical symbols which
> I'd prefer.
> 
> For example user may be interested in finding certain merge but chooses
> to limit the output with a commit range. It helps if user can always
> trust the symbols * and M to have this conceptual difference.

Okay.  Here's a simple patch to restore the behavior of always printing
'M' for merge commits, even if less than 2 parents are shown in the
graph.


Adam Simpkins (1):
  graph API: always print 'M' for merge commits

 graph.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)
