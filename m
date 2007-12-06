From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 10:45:40 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712061036200.13796@woody.linux-foundation.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>  <20071205.202047.58135920.davem@davemloft.net>  <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>  <20071205.204848.227521641.davem@davemloft.net>   <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>  <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org> <b609cb3b0712061024rc48022bhc3fbfba02061dd94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Berlin <dberlin@dberlin.org>, David Miller <davem@davemloft.net>,         ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: NightStrike <nightstrike@gmail.com>
X-From: gcc-return-142758-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 19:46:49 2007
Return-path: <gcc-return-142758-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0LkB-00031b-Cb
	for gcc@gmane.org; Thu, 06 Dec 2007 19:46:43 +0100
Received: (qmail 4770 invoked by alias); 6 Dec 2007 18:46:25 -0000
Received: (qmail 4762 invoked by uid 22791); 6 Dec 2007 18:46:24 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 18:46:18 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB6IjfUu023394 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Thu, 6 Dec 2007 10:45:42 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB6Ijebt006254; 	Thu, 6 Dec 2007 10:45:41 -0800
In-Reply-To: <b609cb3b0712061024rc48022bhc3fbfba02061dd94@mail.gmail.com>
X-MIMEDefang-Filter: lf$Revision: 1.188 $
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67318>



On Thu, 6 Dec 2007, NightStrike wrote:
> 
> No disrespect is meant by this reply.  I am just curious (and I am
> probably misunderstanding something)..  Why remove all of the
> documentation entirely?  Wouldn't it be better to just document it
> more thoroughly?

Well, part of it is that I don't think "--aggressive" as it is implemented 
right now is really almost *ever* the right answer. We could change the 
implementation, of course, but generally the right thing to do is to not 
use it (tweaking the "--window" and "--depth" manually for the repacking 
is likely the more natural thing to do).

The other part of the answer is that, when you *do* want to do what that 
"--aggressive" tries to achieve, it's such a special case event that while 
it should probably be documented, I don't think it should necessarily be 
documented where it is now (as part of "git gc"), but as part of a much 
more technical manual for "deep and subtle tricks you can play".

> I thought you did a fine job in this post in explaining its purpose, 
> when to use it, when not to, etc.  Removing the documention seems 
> counter-intuitive when you've already gone to the trouble of creating 
> good documentation here in this post.

I'm so used to writing emails, and I *like* trying to explain what is 
going on, so I have no problems at all doing that kind of thing. However, 
trying to write a manual or man-page or other technical documentation is 
something rather different.

IOW, I like explaining git within the _context_ of a discussion or a 
particular problem/issue. But documentation should work regardless of 
context (or at least set it up), and that's the part I am not so good at.

In other words, if somebody (hint hint) thinks my explanation was good and 
readable, I'd love for them to try to turn it into real documentation by 
editing it up and creating enough context for it! But I'm nort personally 
very likely to do that. I'd just send Junio the patch to remove a 
misleading part of the documentation we have.

		Linus
