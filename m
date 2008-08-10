From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Documentation: rev-list-options: clarify history
 simplification with paths
Date: Sun, 10 Aug 2008 12:27:58 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808101226130.3462@nehalem.linux-foundation.org>
References: <1218375840-4292-1-git-send-email-trast@student.ethz.ch> <7vabfk3cge.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 21:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSGbh-0008Gz-AL
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 21:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbYHJT2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 15:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbYHJT2f
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 15:28:35 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51715 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753321AbYHJT2f (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Aug 2008 15:28:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7AJRxa9022501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Aug 2008 12:28:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7AJRwl4028991;
	Sun, 10 Aug 2008 12:27:58 -0700
In-Reply-To: <7vabfk3cge.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.909 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91879>



On Sun, 10 Aug 2008, Junio C Hamano wrote:
> 
> Personally I do not think --full-history without --parents is of much
> usefulness (I'd let Linus or somebody else defend this usage, or make it
> imply revs.rewrite_parents otherwise).  If you remove that case from your
> set of experiments in the equation, do the rest of the results make sense?

Oh, it's _very_ useful.

The most common case is "git whatchanged". It's useful to find a commit 
that did some change _without_ any graphical front-end. 

And then the merges and parenthood are totally pointless - no human can 
try to tie things together in their head _anyway_, so why show them? You 
just want to find the change.

			Linus
