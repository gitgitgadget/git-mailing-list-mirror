From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH 1/1] graph API: always print 'M' for merge commits
Date: Sat, 24 May 2008 15:21:30 -0700
Message-ID: <20080524222129.GB6795@adamsimpkins.net>
References: <20080524182530.GB2997@mithlond.arda.local> <1211662321-28846-1-git-send-email-adam@adamsimpkins.net> <1211662321-28846-2-git-send-email-adam@adamsimpkins.net>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 25 00:23:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K028t-0005uC-CT
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 00:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763031AbYEXWVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 18:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763000AbYEXWVd
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 18:21:33 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:42609 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762931AbYEXWVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 18:21:32 -0400
Received: from relay7.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay7.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 6A31C1B40D4;
	Sat, 24 May 2008 18:21:31 -0400 (EDT)
Received: by relay7.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id 489DE1B400E;
	Sat, 24 May 2008 18:21:31 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 6051414100C8; Sat, 24 May 2008 15:21:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1211662321-28846-2-git-send-email-adam@adamsimpkins.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82835>

On Sat, May 24, 2008 at 01:52:01PM -0700, Adam Simpkins wrote:
> The recent changes for handling uninteresting commits changed the
> behavior so that merge commits were displayed as 'M' only if they had
> multiple interesting parents.
> 
> This change reverts to the old behavior of displaying merges as 'M',
> even if they have less than 2 parents displayed in the graph.

Signed-off-by: Adam Simpkins <adam@adamsimpkins.net>

-- 
Adam Simpkins
adam@adamsimpkins.net
