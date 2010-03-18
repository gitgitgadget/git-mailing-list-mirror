From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 12:52:29 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181250200.18017@i5.linux-foundation.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>  <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>  <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org> 
 <b4087cc51003181232q6b8ec056lad79c62926b65a10@mail.gmail.com>  <alpine.LFD.2.00.1003181237450.18017@i5.linux-foundation.org> <b4087cc51003181247m26125efft3d03cd34a2dc9280@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:56:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLoz-0005Ny-En
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:55:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab0CRTzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:55:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56872 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751204Ab0CRTzw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 15:55:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IJtMnM018004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 12:55:23 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IJtMAP012423;
	Thu, 18 Mar 2010 12:55:22 -0700
In-Reply-To: <b4087cc51003181247m26125efft3d03cd34a2dc9280@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142510>



On Thu, 18 Mar 2010, Michael Witten wrote:

> On Thu, Mar 18, 2010 at 14:40, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > Random 16-letter letter-jumble? No. People will _never_ care. They'll
> > simply not care.
> 
> I don't think you've read one word that I've written.

Oh, I read them. They make no sense.

If the uuid isn't random, but tied to the email address, then it's 
worthless. 

If you like the random 16-letter jumbles, then for christ sake JUST CHANGE 
"git log" to hash the author name for you. You'll get the uuid's. What I'm 
telling you is that NOBODY SANE WANTS TO EVER SEE THEM.

And if nobody wants them, then nobody will maintain them, and they'll be 
much _less_ useful than the emails we already have.

		Linus
