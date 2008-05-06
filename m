From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge renamed files/directories?
Date: Tue, 6 May 2008 09:15:22 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805060914190.32269@woody.linux-foundation.org>
References: <4819CF50.2020509@tikalk.com> <481D52CC.1030503@tikalk.com> <32541b130805050940x1297e907ofc67ee65494897eb@mail.gmail.com> <200805052349.35867.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.10.0805051512060.32269@woody.linux-foundation.org>
 <ADDE27A8-6329-4C09-BC07-8EB023BA6D48@midwinter.com> <alpine.LFD.1.10.0805051724510.32269@woody.linux-foundation.org> <20080506154709.GF6918@mit.edu> <alpine.LFD.1.10.0805060851470.32269@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 06 18:17:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtPqZ-0006wJ-4J
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 18:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbYEFQQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 12:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbYEFQQF
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 12:16:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49542 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751203AbYEFQQD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 12:16:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m46GFODA020245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 May 2008 09:15:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m46GFMq0015575;
	Tue, 6 May 2008 09:15:23 -0700
In-Reply-To: <alpine.LFD.1.10.0805060851470.32269@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.422 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81366>



On Tue, 6 May 2008, Linus Torvalds wrote:
> 
>							I can pretty much 
> guarantee that any sane project will have more data conflicts than they 
> will have rename conflicts (whether single-file or directory), and it's 
> not only a problem, it's something that is absolutely *required* from a 
         ^^^-- not
> source control management system!

Oops. That didn't read well.

			Linus
