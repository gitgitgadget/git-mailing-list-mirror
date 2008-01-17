From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Thu, 17 Jan 2008 10:51:58 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801171046040.14959@woody.linux-foundation.org>
References: <20080114202932.GA25130@steel.home>  <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com>  <200801160002.51048.robin.rosenberg.lists@dewire.com>  <20080116071832.GA2896@steel.home>  <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com>
  <20080116183124.GA3181@steel.home>  <a5eb9c330801161048x4b5a88dcsebd7cf9754f72ba6@mail.gmail.com>  <20080116191737.GD3181@steel.home>  <a5eb9c330801161344i1da447c7sb447bf6274d408e8@mail.gmail.com>  <20080116234527.GA3499@steel.home>
 <a5eb9c330801171037v333becc2lbc5873383d07a358@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Paul Umbers <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:53:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZri-0007nn-Aw
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000AbYAQSwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 13:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755871AbYAQSwO
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:52:14 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60396 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752067AbYAQSwM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 13:52:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HIpw6J021108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 10:52:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HIpwXe007251;
	Thu, 17 Jan 2008 10:51:58 -0800
In-Reply-To: <a5eb9c330801171037v333becc2lbc5873383d07a358@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70902>



On Thu, 17 Jan 2008, Paul Umbers wrote:
> 
> Incidentally, I've tried this on two other machines at work with the
> same results. The steps to reproduce are annoyingly simple: download
> cygwin installer & execute (accept all defaults), select the packages
> specified for the binary windows install on the git wiki, try to
> create a git repository and add files. Frustrating - especially since
> my desktop at my last job worked just fine.

Is there perhaps some odd virus scanner or something that interferes with 
filesystem operations? It sounds like you have consistent problems on 
*some* machines, but others cannot reproduce them, which makes me wonder 
if there is some setup issue. Maybe your company machines have some DLL or 
something that interferes subtly with cygwin.

(Eg there might be another cygwin install hidden off somewhere?)

The "virus scanner" thing was just a random thought, but under windows 
it's not unheard of to have things that intercept filesystem accesses for 
things like that. Virus scanners, "security features", rootkits from Sony 
or other sources of trouble etc - you name it. 

That kind of environmental difference would explain why you didn't see it 
on another machine, and why others seem to not be able to reproduce it 
either.

			Linus
