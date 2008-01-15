From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file
 descriptor
Date: Tue, 15 Jan 2008 12:20:31 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801151219530.2806@woody.linux-foundation.org>
References: <4787E981.7010200@nrlssc.navy.mil> <478C1D7A.6090103@nrlssc.navy.mil> <alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org> <478CECAB.2030906@nrlssc.navy.mil> <alpine.LFD.1.00.0801150931260.2806@woody.linux-foundation.org>
 <478CFAFF.6010006@nrlssc.navy.mil> <alpine.LFD.1.00.0801151036110.2806@woody.linux-foundation.org> <478D0CDA.5050709@nrlssc.navy.mil> <alpine.LFD.1.00.0801151207150.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Kristian H?gsberg <krh@redhat.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:23:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEsJB-0006tc-7i
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbYAOUWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 15:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbYAOUWY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:22:24 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51078 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751802AbYAOUWX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 15:22:23 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0FKKW5Q018493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 12:20:33 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0FKKVMp001344;
	Tue, 15 Jan 2008 12:20:31 -0800
In-Reply-To: <alpine.LFD.1.00.0801151207150.2806@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.72 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70551>



On Tue, 15 Jan 2008, Linus Torvalds wrote:
> 
> Your patch seems "ObviouslyCorrect(tm)".

And Kristian's more extensive patch that finds a few more cases looks 
better yet. Does that fix it for you?

		Linus
