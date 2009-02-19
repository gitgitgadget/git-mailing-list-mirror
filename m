From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 2/4] format-patch: track several references
Date: Thu, 19 Feb 2009 17:41:42 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0902191734110.19665@iabervon.org>
References: <200902170027.09406.trast@student.ethz.ch> <cover.1235078708.git.trast@student.ethz.ch> <5a41305e9103c870e8cae95dcf58655c275aba9b.1235078708.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 19 23:43:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaHbs-0005ay-Mc
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 23:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbZBSWlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 17:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753742AbZBSWlo
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 17:41:44 -0500
Received: from iabervon.org ([66.92.72.58]:32778 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020AbZBSWln (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 17:41:43 -0500
Received: (qmail 28719 invoked by uid 1000); 19 Feb 2009 22:41:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2009 22:41:42 -0000
In-Reply-To: <5a41305e9103c870e8cae95dcf58655c275aba9b.1235078708.git.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110762>

On Thu, 19 Feb 2009, Thomas Rast wrote:

> Currently, format-patch can only track a single reference (the
> In-Reply-To:) for each mail.  To ensure proper threading, we should
> list all known references for every mail.
> 
> Change the rev_info.ref_message_id field to a string_list

It would be nice to change the field name to "ref_message_ids", which is 
more likely to suggest that it's a list of ids, rather than a single id 
stored strangely.

Aside from that, parts 2-4 look good to me (I'm not up on reviewing shell 
code).

	-Daniel
*This .sig left intentionally blank*
