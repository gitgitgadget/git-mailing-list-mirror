From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge renamed files/directories?
Date: Mon, 5 May 2008 17:40:25 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805051737180.32269@woody.linux-foundation.org>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com> <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com> <200805052349.35867.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org>
 <ADDE27A8-6329-4C09-BC07-8EB023BA6D48@midwinter.com> <alpine.LFD.1.10.0805051724510.32269@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue May 06 02:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtBFJ-0002ls-3Q
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 02:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284AbYEFAkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 20:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756772AbYEFAkk
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 20:40:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34748 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756249AbYEFAkk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2008 20:40:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m460eQKo003498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 May 2008 17:40:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m460ePGm013585;
	Mon, 5 May 2008 17:40:26 -0700
In-Reply-To: <alpine.LFD.1.10.0805051724510.32269@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.424 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81318>



On Mon, 5 May 2008, Linus Torvalds wrote:
> 
> There are tons of these kinds of merge issues that bad SCM developes 
> have been masturbating over for YEARS.

.. and if I sound rather less than enthused about these kinds of issues, 
it's because of having seen years and years of people talking about merge 
strategies, and then at the same time using SVN which doesn't even record 
the parenthood of the resulting merges, or thinking that code always 
moves with whole files.

In other words, the details don't even matter. What matters is not being a 
total piece of sh*t in the big picture. 

		Linus
