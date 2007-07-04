From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] diff: add custom regular expressions for function
 names
Date: Wed, 4 Jul 2007 11:41:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 20:41:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I69nR-00009q-0N
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 20:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195AbXGDSlq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 14:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbXGDSlq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 14:41:46 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53069 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755907AbXGDSlp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2007 14:41:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l64IfdEt015727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 4 Jul 2007 11:41:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l64IfYS9011417;
	Wed, 4 Jul 2007 11:41:34 -0700
In-Reply-To: <Pine.LNX.4.64.0707041905570.4071@racer.site>
X-Spam-Status: No, hits=-3.141 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51632>



On Wed, 4 Jul 2007, Johannes Schindelin wrote:
> 
> This patch introduces a config variable diff.functionNameRegexp
> which replaces the default heuristics.  If the pattern contains
> a group, the match of this group is used for the hunk header
> instead of the whole match.

Umm. Shouldn't it be a path-name based attribute instead?

That way you can set it to be different things for different source files 
in the same repository.. IOW, think mixed Java/C codebases.

		Linus
