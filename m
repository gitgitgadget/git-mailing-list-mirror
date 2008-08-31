From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit] Debian packaging update
Date: Sun, 31 Aug 2008 09:00:43 +0200
Message-ID: <20080831070043.GA1125@diana.vm.bytemark.co.uk>
References: <20080818201036.7c2c00f8@whitehouse.id.au> <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com> <20080822235154.5e1f979c@whitehouse.id.au> <b0943d9e0808221457w42a84fbgdf62e3ddbb417389@mail.gmail.com> <20080828140929.GB3584@khazad-dum.debian.net> <20080828192450.GH4985@nan92-1-81-57-214-146.fbx.proxad.net> <20080828205255.GA28644@nan92-1-81-57-214-146.fbx.proxad.net> <20080828222711.GB21850@diana.vm.bytemark.co.uk> <b0943d9e0808301533x7a652c59x1a227d6fa4a35961@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Daniel White <daniel@whitehouse.id.au>, git@vger.kernel.org,
	stgit@packages.debian.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 08:42:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZgdr-00063V-AS
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 08:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbYHaGjK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Aug 2008 02:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbYHaGjJ
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 02:39:09 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3075 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbYHaGjI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 02:39:08 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KZgvT-0000If-00; Sun, 31 Aug 2008 08:00:43 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0808301533x7a652c59x1a227d6fa4a35961@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94457>

On 2008-08-30 23:33:01 +0100, Catalin Marinas wrote:

> 2008/8/28 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2008-08-28 22:52:55 +0200, Yann Dirson wrote:
> >
> > > The official package ships a copy of documentation pages from
> > > the wiki, because they contain information not otherwise
> > > available. Do we want to keep a copy of these files in the
> > > official repo ?
> >
> > We discussed this a while back, and i believe we agreed that
> > having the primary copy in the StGit tree is a good idea. So, yes.
>
> Yes, indeed. And it's on my plan to tidy up and improve the
> documentation (though I wasn't that active recently either :-( ).
> The generated html docs could be put on the web somewhere.

Relatedly, I'm right now teaching the command-line option parser
thingy to be able to generate asciidoc man page output (in addition to
the interactive help it already features). The end result should be
man pages for all stg commands -- with contents that can and should be
improved over time. :-)

This would allow some documentation about a specific command to live
in its man page, and allow the other docs to hyperlink to the man
page, etc.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
