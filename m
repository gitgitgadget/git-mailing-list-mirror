From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 19:35:42 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111933500.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com> <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org> <7vprxcdhis.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0712111523210.25032@woody.linux-foundation.org> <alpine.LFD.0.9999.0712111548200.25032@woody.linux-foundation.org>
 <Pine.LNX.4.64.0712111611570.1671@alien.or.mcafeemobile.com> <alpine.LFD.0.9999.0712111648180.25032@woody.linux-foundation.org> <Pine.LNX.4.64.0712111653520.1671@alien.or.mcafeemobile.com> <alpine.LFD.0.9999.0712111806320.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Berlin <dberlin@dberlin.org>,
	Git Mailing List <git@vger.kernel.org>
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 04:36:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2IOL-0007X0-6n
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 04:36:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbXLLDft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 22:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbXLLDft
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 22:35:49 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51301 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750952AbXLLDfs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 22:35:48 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBC3ZhKM015162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 19:35:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBC3ZgdD023580;
	Tue, 11 Dec 2007 19:35:42 -0800
In-Reply-To: <alpine.LFD.0.9999.0712111806320.25032@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67988>



On Tue, 11 Dec 2007, Linus Torvalds wrote:
> 
> I'm not saying it's useless. I'm saying it's ineffective.

Sorry, I _did_ call it "fairly useless". 

The rest of the comment stands. I'm sure the trimming that xdiff does is 
good at avoiding some common O(n*m) cases, it's just not as good as it 
could be, and leaves a big constant factor of the O(n) case on the table.

			Linus
