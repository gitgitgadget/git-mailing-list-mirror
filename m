From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
 completion
Date: Sun, 13 Jul 2008 16:52:22 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 01:54:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIBOT-0001ux-Ny
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 01:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342AbYGMXwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 19:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbYGMXws
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 19:52:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32936 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753326AbYGMXws (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jul 2008 19:52:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6DNqOrx030206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 Jul 2008 16:52:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6DNqMqf012494;
	Sun, 13 Jul 2008 16:52:23 -0700
In-Reply-To: <7vhcatnz80.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.397 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88359>



On Sun, 13 Jul 2008, Junio C Hamano wrote:
> 
> I think that is what Shawn sent a few minutes ago, so you two are in
> agreement, and I will be happy with it, too.

Does it fix this one too:

	git show origin/pu:Makef<tab>

which totally screws up and becomes

	git show Makefile

dropping the version specifier?

I don't speak completion-script, so somebody else would have to fix this 
really annoying bug (*)

		Linus

(*) Ok, so it's rare. I have been bitten by it something like twice in the 
last months. But when it happens it's really annoying.
