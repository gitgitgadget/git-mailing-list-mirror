From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/3] implement pattern matching in ce_path_match
Date: Wed, 14 Jan 2009 16:25:15 +0100
Message-ID: <20090114152515.GA19305@localhost>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at> <1231944876-29930-2-git-send-email-drizzd@aon.at> <1231944876-29930-3-git-send-email-drizzd@aon.at> <1231944876-29930-4-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, johannes@familieschneider.info
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 16:26:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN7do-00019A-4Z
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 16:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019AbZANPZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 10:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbZANPZV
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 10:25:21 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:48430 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905AbZANPZU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 10:25:20 -0500
Received: from darc.dyndns.org ([84.154.84.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 16:25:16 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LN7cJ-000537-Eu; Wed, 14 Jan 2009 16:25:15 +0100
Content-Disposition: inline
In-Reply-To: <1231944876-29930-4-git-send-email-drizzd@aon.at>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 14 Jan 2009 15:25:17.0627 (UTC) FILETIME=[4E1B98B0:01C9765C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105639>

On Wed, Jan 14, 2009 at 03:54:36PM +0100, Clemens Buchacher wrote:
> This also implies pattern matching for many other git commands, such
> as add -u, blame, log, etc.

Oops, I thought I had removed that. AFAICT blame is not affected by this.
