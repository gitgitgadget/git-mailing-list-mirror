From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for
	/etc/gitweb.conf (WIP)
Date: Tue, 07 Jun 2011 13:43:48 -0400
Message-ID: <1307468628.12888.81.camel@drew-northup.unet.maine.edu>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
	 <1307382271-7677-5-git-send-email-jnareb@gmail.com>
	 <20110606221236.GD30588@elie>
	 <1307451658.12283.39.camel@drew-northup.unet.maine.edu>
	 <20110607134404.GA12730@elie>
	 <1307464037.12888.49.camel@drew-northup.unet.maine.edu>
	 <7vtyc160ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:49:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU0P0-0005Ix-4F
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179Ab1FGRtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:49:13 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:43519 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab1FGRtN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:49:13 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p57HhquY022116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Jun 2011 13:43:53 -0400
In-Reply-To: <7vtyc160ha.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=6 Fuz1=6
	Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p57HhquY022116
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1308073436.57062@05/WFaIRObXnQ5Ao4mfrIw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175239>


On Tue, 2011-06-07 at 10:00 -0700, Junio C Hamano wrote:
> Drew Northup <drew.northup@maine.edu> writes:
> 
> > On Tue, 2011-06-07 at 08:44 -0500, Jonathan Nieder wrote:
> > ...
> > If this is what you are proposing then we should be working on a
> > "gitweb_config.perl" manpage and not a "gitweb.conf" manpage. I know a
> > fair number of people around here put priority on the former and would
> > just as soon ignore the latter. That's what your proposed change says to
> > me (while I also understand that your own position is likely far more
> > nuanced than that).
> 
> Hmm, do you want to have two (and then three, see below) separate manpages
> that essentially describe the same thing, and refer to each other when
> they talk about the precedence order?

No, I am just saying that if this isn't primarily meant to be
about /etc/gitweb.conf (which is what I was told to use here on this
very list) then we shouldn't name it after gitweb.conf, nor should we
focus on gitweb.conf (the removal of the gitweb.conf we are then
effectively deprecating can be discussed later; I have already voiced my
opinion on this strategy of ignoring /etc/gitweb.conf but still having
it anyway and been summarily declared insane).

The change he made isn't, to me anyway, one of precedence order but is
one of focus and theme. Perhaps most people around here aren't trained
to hew so closely to the stated purpose of a work as I am and therefore
don't see the change he suggested as starkly. So be it. 
I really don't like starting work on something for a project because I
was told that (1) it was needed and, (2) it would be welcome only to
find that neither statement was particularly true. I'd strongly prefer
to have been told from the outset "Don't bother to document that, as
you're the only one using it that way," and, "Document this instead, as
just because you're not using it doesn't mean that we don't think
everyone else should be."
> 
> >> >>> +*NOTE:* If per-instance configuration file ('gitweb_config.perl') exists,
> >> >>> +then system-wide configuration file ('/etc/gitweb.conf') is _not used at
> >> >>> +all_!!!
> >> >>
> >> >> Over the top. :)  I think the best way to document this is to contrast
> >> >> it with /etc/gitweb-common.conf once the latter exists.
> >> >
> >> > If we were to change gitweb to handle configuration files like the rest
> >> > of git (and in fact like most things we deal with daily, where settings
> >> > are overridden one by one) then this section becomes moot. Until or
> >> > unless that becomes the case it is important to loudly make note of it. 
> >> 
> >> Does using three exclamation marks and italics make it clearer?
> >
> > That could probably be cut down to one, I'll grant you that. I was
> > trying to avoid use of the <blink> tag.
> 
> I vaguely recall that there was an effort to document /etc/gitweb.conf as
> a mere "fallback default", not a "system-wide configuration file", which
> is what it is, and also to introduce a true "system-wide configuration" as
> a separate file, so that the system-wide one will be read, and then either
> per-instance gitweb_config.perl or the fallback default /etc/gitweb.conf
> will update it. What happened to that effort?

You shot it down, that's what. Or more correctly you shot down the use
of /etc/gitweb.conf as a system-wide source of default settings instead
proposing that it be used as a fallback (?) and that
an /etc/gitweb-defaults.conf (or something like that) be used as a
per-item default (or at least that's what I got out of what was said).
I'm not sure what to think of that, but I haven't had the chance to test
that patch-set in any case, much less incorporate it into the
documentation. All of that would come after I'm no longer confused as to
what the intended end-result would be.
> 
> In any case, with the current design, /etc/gitweb.conf is _not_ the
> system-wide configuration file but it is a fallback default for instances
> that do not have per-instance configuration, so the quoted part would need
> rewording anyway, I think.

And THAT is the problem. If it isn't a system-wide configuration file
then let's stop putting it in /etc, deprecate it, and get it over with.
I didn't even know that to be the case when I started writing this, I
was just trying to make more readily available the advice I'd been given
on this list. Only after getting started did I learn that gitweb treats
a file in /etc like nothing else I normally use (aside from
adduser/useradd's use of /etc/skel as a directory template).

I'm crawling back into my hole now.
-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
