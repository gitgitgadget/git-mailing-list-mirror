From: "=?ISO-8859-1?Q?Erik_B=E5gfors?=" <zindar@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 24 Oct 2006 09:31:07 +0200
Message-ID: <845b6e870610240031x66c6b942u54ee0d357725fae1@mail.gmail.com>
References: <20061022074513.GF29927@artax.karlin.mff.cuni.cz>
	<87zmbozau2.wl%cworth@cworth.org>
	<20061022185350.GW75501@over-yonder.net>
	<Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>
	<20061023222131.GB17019@over-yonder.net> <ehjgli$lft$1@sea.gmane.org>
	<845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com>
	<Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>
	<20061024002657.GD17019@over-yonder.net>
	<87y7r6zgic.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: bazaar-ng-bounces@lists.canonical.com Tue Oct 24 09:59:41 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcHCC-0000oU-PY
	for gcvbg-bazaar-ng@m.gmane.org; Tue, 24 Oct 2006 09:59:37 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GcHC3-0006Wb-3w; Tue, 24 Oct 2006 08:59:27 +0100
Received: from py-out-1112.google.com ([64.233.166.179])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <zindar@gmail.com>) id 1GcHC0-0006WG-PY
	for bazaar-ng@lists.canonical.com; Tue, 24 Oct 2006 08:59:24 +0100
Received: by py-out-1112.google.com with SMTP id f25so14570pyf
	for <bazaar-ng@lists.canonical.com>;
	Tue, 24 Oct 2006 00:59:24 -0700 (PDT)
Received: by 10.35.119.8 with SMTP id w8mr8323711pym;
	Tue, 24 Oct 2006 00:31:07 -0700 (PDT)
Received: by 10.35.116.4 with HTTP; Tue, 24 Oct 2006 00:31:07 -0700 (PDT)
To: "Carl Worth" <cworth@cworth.org>
In-Reply-To: <87y7r6zgic.wl%cworth@cworth.org>
Content-Disposition: inline
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29942>

On 10/24/06, Carl Worth <cworth@cworth.org> wrote:
> On Mon, 23 Oct 2006 19:26:57 -0500, "Matthew D. Fuller" wrote:
> >
> > On Mon, Oct 23, 2006 at 04:24:30PM -0700 I heard the voice of
> > Linus Torvalds, and lo! it spake thus:
> > >
> > > The problem? How do you show a commit that is _common_ to two
> > > branches, but has different revision names in them?
> >
> > Why would you?
>
> Assume you've got two long-lived branches and one periodically gets
> merged into the other one. The combined history might look as follows
> (more recent commits first):
>
>  f   g
>  |   |
>  d   e
>  |\ /
>  b c
>  |/
>  a
>
> The point is that it is extremely nice to be able to visualize things
> that way. Say I've got a "dev" branch that points at f and a "stable"
> branch that points at g. With this, a command like:
>
>         gitk dev stable
>
> would result in a picture just like the above. Can a similar figure be
> made with bzr? Or only the following two separate pictures:

The above picture can easily be created with bzr if you have a
utility/plugin that does it. There is none that does it yet, but there
are no problems doing one.

Of course, in such a context revision numbers have no use.  But see,
revision numbers is not mandatory in bzr, so that's not a problem.

I haven't really had a need for such a tool, but I do see where it can
be very useful to have.

>  f    g
>  |    |
>  d    e
>  |\   |
>  b c  c
>  |/   |
>  a    a
>

This is what you would get if you visualize the two separate branches,
and not the common repository.

/Erik
