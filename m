From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 00:11:05 -0500
Message-ID: <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 	 <20071205.202047.58135920.davem@davemloft.net> 	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> 	 <20071205.204848.227521641.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: "David Miller" <davem@davemloft.net>
X-From: gcc-return-142722-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 06:11:34 2007
Return-path: <gcc-return-142722-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J091I-0005Wz-OP
	for gcc@gmane.org; Thu, 06 Dec 2007 06:11:33 +0100
Received: (qmail 14153 invoked by alias); 6 Dec 2007 05:11:13 -0000
Received: (qmail 14143 invoked by uid 22791); 6 Dec 2007 05:11:12 -0000
X-Spam-Check-By: sourceware.org
Received: from wa-out-1112.google.com (HELO wa-out-1112.google.com) (209.85.146.179)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 05:11:08 +0000
Received: by wa-out-1112.google.com with SMTP id m16so196764waf         for <gcc@gcc.gnu.org>; Wed, 05 Dec 2007 21:11:06 -0800 (PST)
Received: by 10.142.177.7 with SMTP id z7mr1470393wfe.1196917865823;         Wed, 05 Dec 2007 21:11:05 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Wed, 5 Dec 2007 21:11:05 -0800 (PST)
In-Reply-To: <20071205.204848.227521641.davem@davemloft.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67239>

On 12/5/07, David Miller <davem@davemloft.net> wrote:
> From: "Daniel Berlin" <dberlin@dberlin.org>
> Date: Wed, 5 Dec 2007 23:32:52 -0500
>
> > On 12/5/07, David Miller <davem@davemloft.net> wrote:
> > > From: "Daniel Berlin" <dberlin@dberlin.org>
> > > Date: Wed, 5 Dec 2007 22:47:01 -0500
> > >
> > > > The size is clearly not just svn data, it's in the git pack itself.
> > >
> > > And other users have shown much smaller metadata from a GIT import,
> > > and yes those are including all of the repository history and branches
> > > not just the trunk.
> > I followed the instructions in the tutorials.
> > I followed the instructions given to by people who created these.
> > I came up with a 1.5 gig pack file.
> > You want to help, or you want to argue with me.
>
> Several people replied in this thread showing what options can lead to
> smaller pack files.

Actually, one person did, but that's okay, let's assume it was several.
I am currently trying Harvey's options.

I asked about using the pre-existing repos so i didn't have to do
this, but they were all
1. Done using read-only imports or
2. Don't contain full history
(IE the one that contains full history that is often posted here was
done as a read only import and thus doesn't have the metadata).

> They also listed what the GIT limitations are that would effect the
> kind of work you are doing, which seemed to mostly deal with the high
> space cost of branching and tags when converting to/from SVN repos.

Actually, it turns out that git-gc --aggressive does this dumb thing
to pack files sometimes regardless of whether you converted from an
SVN repo or not.
