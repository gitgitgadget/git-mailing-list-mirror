From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix branches file configuration
Date: Tue, 25 Mar 2008 17:03:29 -0700
Message-ID: <20080325170329.fadc9273.akpm@linux-foundation.org>
References: <alpine.LNX.1.00.0803251931500.19665@iabervon.org>
	<7v3aqel5ms.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 01:06:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeJ8m-0004jj-EQ
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 01:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756083AbYCZAEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 20:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755637AbYCZAEe
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 20:04:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38856 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754569AbYCZAEd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 20:04:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2Q03TT1012204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Mar 2008 17:03:30 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m2Q03TfQ020462;
	Tue, 25 Mar 2008 17:03:29 -0700
In-Reply-To: <7v3aqel5ms.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-4.776 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78235>

On Tue, 25 Mar 2008 16:56:43 -0700 Junio C Hamano <gitster@pobox.com> wrote:

> (the support for "branches" file is not
> deprecated, even though I personally do not see a reason to use it in new
> repositories).

I looked at the new (verbose) format a year or two back and thought "why
the heck would I want to use that".

I have 213 files in my .git/branches/ and I change them a lot.  The
succinct one-line format is nice...
