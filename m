From: NightStrike <nightstrike@gmail.com>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 13:24:34 -0500
Message-ID: <b609cb3b0712061024rc48022bhc3fbfba02061dd94@mail.gmail.com>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 	 <20071205.202047.58135920.davem@davemloft.net> 	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> 	 <20071205.204848.227521641.davem@davemloft.net> 	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> 	 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Daniel Berlin" <dberlin@dberlin.org>, "David Miller" <davem@davemloft.net>,  	ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: gcc-return-142755-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 19:25:16 2007
Return-path: <gcc-return-142755-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0LPG-0002Ud-DB
	for gcc@gmane.org; Thu, 06 Dec 2007 19:25:06 +0100
Received: (qmail 23359 invoked by alias); 6 Dec 2007 18:24:48 -0000
Received: (qmail 23349 invoked by uid 22791); 6 Dec 2007 18:24:47 -0000
X-Spam-Check-By: sourceware.org
Received: from nz-out-0506.google.com (HELO nz-out-0506.google.com) (64.233.162.239)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 18:24:38 +0000
Received: by nz-out-0506.google.com with SMTP id i11so150406nzh         for <gcc@gcc.gnu.org>; Thu, 06 Dec 2007 10:24:36 -0800 (PST)
Received: by 10.142.83.4 with SMTP id g4mr1818981wfb.1196965475061;         Thu, 06 Dec 2007 10:24:35 -0800 (PST)
Received: by 10.142.126.8 with HTTP; Thu, 6 Dec 2007 10:24:34 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
Content-Disposition: inline
X-IsSubscribed: yes
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67313>

On 12/6/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 6 Dec 2007, Daniel Berlin wrote:
> >
> > Actually, it turns out that git-gc --aggressive does this dumb thing
> > to pack files sometimes regardless of whether you converted from an
> > SVN repo or not.
> I'll send a patch to Junio to just remove the "git gc --aggressive"
> documentation. It can be useful, but it generally is useful only when you
> really understand at a very deep level what it's doing, and that
> documentation doesn't help you do that.

No disrespect is meant by this reply.  I am just curious (and I am
probably misunderstanding something)..  Why remove all of the
documentation entirely?  Wouldn't it be better to just document it
more thoroughly?  I thought you did a fine job in this post in
explaining its purpose, when to use it, when not to, etc.  Removing
the documention seems counter-intuitive when you've already gone to
the trouble of creating good documentation here in this post.
