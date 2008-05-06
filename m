From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge renamed files/directories?
Date: Mon, 5 May 2008 17:29:12 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805051724510.32269@woody.linux-foundation.org>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com> <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com> <200805052349.35867.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org>
 <ADDE27A8-6329-4C09-BC07-8EB023BA6D48@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue May 06 02:30:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtB4p-0000Hf-5a
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 02:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757842AbYEFA3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 20:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757153AbYEFA3u
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 20:29:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34591 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756910AbYEFA3u (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2008 20:29:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m460TDJx002943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 May 2008 17:29:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m460TCKx013145;
	Mon, 5 May 2008 17:29:12 -0700
In-Reply-To: <ADDE27A8-6329-4C09-BC07-8EB023BA6D48@midwinter.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.424 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81316>



On Mon, 5 May 2008, Steven Grimm wrote:
>
> Doesn't seem *fundamentally* impossible to produce the results that are most
> likely to be what people want.

You didn't understand what was fundamentally impossible.

And btw, this has nothing to do with directory renames either. There are 
tons of these kinds of merge issues that bad SCM developes have been 
masturbating over for YEARS. There's a whole science of making idiotic new 
merging models, one fancier than the other. The fact is, you cannot do a 
perfect job, the best thing you can do is pick a simple model, and try to 
make it repeatable and easy to fix up.

Maybe somebody bothers to implement some directory rename heuristic some 
day. Quite frankly, I personally cannot care less. It really is mental 
masturbation, and has absolutely no relevance for any real-world problem.

		Linus
