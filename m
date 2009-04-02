From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] match_tree_entry(): a pathspec only matches at directory
 boundaries
Date: Thu, 2 Apr 2009 09:36:46 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904020923180.4130@localhost.localdomain>
References: <20090331094107.GC3307@atjola.homenet> <20090331150501.GA11446@atjola.homenet> <7vbprfn0ai.fsf@gitster.siamese.dyndns.org> <7vwsa3llac.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Eric Wong <normalperson@yhbt.net>,
	Anton Gyllenberg <anton@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 18:41:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpPyv-0005BE-Rg
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 18:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759498AbZDBQj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 12:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755012AbZDBQj6
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 12:39:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44563 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752337AbZDBQj6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 12:39:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n32Gal3B010762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Apr 2009 09:37:18 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n32Gaka7024717;
	Thu, 2 Apr 2009 09:36:47 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vwsa3llac.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.439 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115477>



On Wed, 1 Apr 2009, Junio C Hamano wrote:
>
> Previously the code did a simple prefix match, which means that a path in
> a directory "frotz/" would have matched with pathspec "f".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

I have this suspicion that we should be able to write it more readably, 
but yes:

	Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

because the current code is clearly buggy.

		Linus
