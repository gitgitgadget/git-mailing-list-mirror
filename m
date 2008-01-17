From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 18:38:28 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161834380.2806@woody.linux-foundation.org>
References: <478D79BD.7060006@talkingspider.com>  <86hcheig3n.fsf@blue.stonehenge.com>  <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org>  <478E3D8E.1090300@talkingspider.com>  <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
 <46dff0320801161800y9f5bf0cvb1804a57c41c3f4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike <fromlists@talkingspider.com>,
	Neil Macneale <mac4-git@theory.org>, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 03:40:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFKfM-00047c-3m
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 03:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbYAQCjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 21:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbYAQCjJ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 21:39:09 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40295 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750941AbYAQCjI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 21:39:08 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H2cTjn007776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 18:38:30 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H2cS9d005116;
	Wed, 16 Jan 2008 18:38:28 -0800
In-Reply-To: <46dff0320801161800y9f5bf0cvb1804a57c41c3f4c@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.665 required=5 tests=AWL,BAYES_00,OSDL_NIGERIAN_URGENT
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70814>



On Thu, 17 Jan 2008, Ping Yin wrote:
>
> Using git to manage deployment environment and even as deployment
> tools is not always a bad idea.

I don't think it's alway sa bad idea, no. But it's a good idea only if you 
then accept things like ".git" subdirectories lying around in your 
deployment area (or you accept the use of tricks like GIT_DIR).

> 1. In case where development and deployment environment are almost the
> same, such as html files, js files, binding the two environments as
> one is convenient.
> 
> 2. Event In the case where the two environement are different very
> much, managing deployment environment in git sometimes still seems
> good, since we can easily back to any earlier version or fix some
> urgent bug ASAP (surely for the non-generated files).
> 
> 3. Use 'git pull' as deploy command seems simple enough.

Hey, I do it for all my kernels ("git pull" + "make" is just simpler than 
pushing tar-balls around), so I'm not entirely disagreeing. I *like* 
having the entire development environment around everywhere.

But it does seem like a lot of Mike's problems basically boil down to the 
fact that he doesn't really want to use it as a deployment tool.

		Linus
