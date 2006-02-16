From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Thu, 16 Feb 2006 08:54:40 +0100
Message-ID: <20060216075440.GA11939@diana.vm.bytemark.co.uk>
References: <20060210195914.GA1350@spearce.org> <20060210211740.GO31278@pasky.or.cz> <20060213210001.GA31278@pasky.or.cz> <tnxoe1aqoj2.fsf@arm.com> <20060214100844.GA1234@diana.vm.bytemark.co.uk> <43F1F5CB.10402@citi.umich.edu> <20060214160747.GA6350@diana.vm.bytemark.co.uk> <43F2445A.6020109@citi.umich.edu> <20060214222913.GK31278@pasky.or.cz> <b0943d9e0602150925v6f01accfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Feb 16 08:54:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9dyP-0004vY-Ba
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 08:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWBPHym convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 16 Feb 2006 02:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWBPHym
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 02:54:42 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:14340 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932509AbWBPHym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 02:54:42 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1F9dyK-00039D-00
	for <git@vger.kernel.org>; Thu, 16 Feb 2006 07:54:40 +0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0602150925v6f01accfw@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16279>

On 2006-02-15 17:25:30 +0000, Catalin Marinas wrote:

> On 14/02/06, Petr Baudis <pasky@suse.cz> wrote:
>
> > It is ok as long as you know what are you doing - if you don't
> > push out the commits you've just "undid" (or work on a public
> > accessible repository in the first place, but I think that's kind
> > of rare these days; quick survey - does anyone reading these lines
> > do that?), there's nothing wrong on it, and it gives you nice
> > flexibility.
> >
> > For example, to import bunch of patches (I guess that's the
> > original intention behind this) you just run git-am on them and
> > then stg uncommit all of the newly added commits.
>
> This is a sensible way of using an uncommit command but I initially
> thought it would be better to make things harder for people wanting
> to re-write the history. Anyway, I'll keep this command on my todo
> list.

stgit rewrites history all the time anyway. And as far as I recall,
there's nothing in the documentation that warns the user not to
publish stgit-managed branches. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
