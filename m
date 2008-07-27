From: Petr Baudis <pasky@suse.cz>
Subject: Re: Official Git Homepage change? Re: git-scm.com
Date: Sun, 27 Jul 2008 14:22:36 +0200
Message-ID: <20080727122236.GY10151@machine.or.cz>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com> <20080726015314.GU32184@machine.or.cz> <20080726020951.GV32184@machine.or.cz> <7v4p6dnv5k.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807260627480.26810@eeepc-johanness> <7vtzedmeqh.fsf@gitster.siamese.dyndns.org> <20080726144040.GZ32184@machine.or.cz> <7v8wvok3f6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 14:26:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN5Kx-00080i-3x
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 14:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbYG0MWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 08:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbYG0MWj
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 08:22:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50249 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbYG0MWi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 08:22:38 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id B8B21393B320; Sun, 27 Jul 2008 14:22:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8wvok3f6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90332>

On Sat, Jul 26, 2008 at 09:37:01AM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> >   I don't know if this should have any immediate effect on how we
> > develop Git etc., but I think it is good to be aware of the fact that
> > silently, huge amount of "dark mass" Git projects is accumulating and
> > that Git is making headways in areas many of us were little aware of.
> 
> The developer community and "dark matter" community are totally separate
> entities that do not interact with each other very much, and they will go
> their separate ways?  I think it is inevitable for any project once it
> becomes popular enough.

  I don't think this is inevitable. I think we are getting into this
position two few simple reasons:

  (i) The traffic on the main list is simply too high for regular users
to keep up with. If we care to get more in touch with our users,
the solution might be to spread the word about the Git Users Google
Group more, and monitor it more actively.

  (ii) The tone on the mailing list seems frequently unnecessarily
harsh. This was mentioned by some of the "dark matter" people (not Scott
himself) as the reason why didn't they announce their work on the
mailing list; fear of being flamed. Especially at the beginning of
summer when I "returned" after quite a while of inactivity, I perceived
this rather unfriendly tone rather strongly as well (not at me
personally, but reading replies to other people's contributions), though
I got kind of used to it quickly again. If we care to encourage postings
by "external" developers to the mailing list, we should keep the usual
strength of our criticism, but try to make the tone more encouraging.

> Where does this observation lead us in this "Official" git homepage
> discussion?  Perhaps the conclusion would be that there does not have to
> be any _single_ official home?  I dunno.

  That is not good idea; this would only split the community further,
*and* create confusion as some people would be directed to homepage A,
others to homepage B, each would have its resources kept up-to-date
in different manner, ...

  Also, we need someplace to link at from git itself:

	README:Many Git online resources are accessible from http://git.or.cz/
	gitweb/gitweb.perl:our $logo_url = "http://git.or.cz/";

In case of README, we could add another link easily, in case of gitweb,
much less so.

  This ultimately comes down to what address would *you* write on
a piece of paper if someone walked to you on say, some conference
and asked you "I like Git, where can I learn more?" Or you could start
explaining how Git does not have a single homepage and start writing
multiple URLs noting the differences. Would that make good impression?

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
