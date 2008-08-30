From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git gui: use apply --unidiff-zero when staging hunks
	without context
Date: Sat, 30 Aug 2008 22:27:06 +0200
Message-ID: <20080830202706.GA13573@localhost>
References: <20080830164527.GA25370@localhost> <20080830165600.GB25370@localhost> <48B9A2D7.8090801@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Aug 30 22:28:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZX39-0006CE-5j
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 22:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbYH3U0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 16:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754003AbYH3U0y
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 16:26:54 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:34491 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbYH3U0x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 16:26:53 -0400
Received: from darc.dyndns.org ([84.154.72.105]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 30 Aug 2008 22:26:51 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KZX2I-0003av-Uy; Sat, 30 Aug 2008 22:27:06 +0200
Content-Disposition: inline
In-Reply-To: <48B9A2D7.8090801@telecom.at>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 30 Aug 2008 20:26:51.0902 (UTC) FILETIME=[BC8B19E0:01C90ADE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94417>

On Sat, Aug 30, 2008 at 09:43:19PM +0200, Johannes Sixt wrote:
> Clemens Buchacher schrieb:
>> git apply does not work correctly with zero-context patches. It does a
>> little better with --unidiff-zero.
>
> No, NO, NOOOOO! This kills your data!

Okay. Since we have 'Stage Line for Commit', supporting this would be almost
pointless anyways. So let's forget about trying to fix this and simply
disable zero-context diff in git-gui, as per my original patch

[PATCH] git gui: show diffs with a minimum of 1 context line

Clemens
