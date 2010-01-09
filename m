From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv3 3/4 (resent)] gitweb: Optionally add "git" links in project list page
Date: Sat, 9 Jan 2010 12:20:19 +0100
Message-ID: <201001091220.20446.jnareb@gmail.com>
References: <1262534850-24572-1-git-send-email-jnareb@gmail.com> <1262534850-24572-4-git-send-email-jnareb@gmail.com> <4B47E06C.9070503@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "John 'Warthog9' Hawley" <warthog9@kernel.org>
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Jan 09 12:21:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTZO5-0005oP-Iy
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 12:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980Ab0AILUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 06:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841Ab0AILUf
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 06:20:35 -0500
Received: from mail-ew0-f214.google.com ([209.85.219.214]:42029 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743Ab0AILUe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 06:20:34 -0500
Received: by ewy6 with SMTP id 6so19822047ewy.29
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 03:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BXwN/AV5UqoBu02BbFOwsokMCy5X07uZqqpVpz5GUj0=;
        b=WcpRA5WCIr1z7vQtjtMM16nxR64vrXcY4HEKNSefF7BM7660n7Act5NCajJLNQ1Le3
         P4t51XwjwdPUJQ5JdHQDFNvQEx2sKWnkVOHN3O9o/FqyJQMDlmhn0Gv0JU1eMROFuYUG
         WaMFheznApJOd7oJiZhORL73ReTDa/QbjewXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tHyK3RMyMFXj8qtEDuFIA8LVA0ZwV2JDLPfOwzTokk5iwm6mg22bdqF6Y0xwr2hZP1
         E4nUEOmx57u+hvg2iIrPgWuiSmFcadel24w/WobsgWxHfpK9XwjOeAlAL8llRdacGAD5
         UnDAmOdzLl+xL7jQhYFGX2FjKkQmAjY/bxXXo=
Received: by 10.216.86.195 with SMTP id w45mr598314wee.82.1263036030862;
        Sat, 09 Jan 2010 03:20:30 -0800 (PST)
Received: from ?192.168.1.13? ([72.14.240.164])
        by mx.google.com with ESMTPS id i6sm9999336gve.16.2010.01.09.03.20.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Jan 2010 03:20:28 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4B47E06C.9070503@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136528>

On Sat, 9 Jan 2010, J.H. wrote:
> On 01/03/2010 08:07 AM, Jakub Narebski wrote:
> > From: John 'Warthog9' Hawley <warthog9@kernel.org>
> > 
> > This adds a "git" link for each project in the project list page,
> > should a common $gitlinkurl_base be defined and not empty.  The full
> > URL of each link is composed of $gitlinkurl_base and project name.
> > It is intended for git:// links, and in fact GITWEB_BASE_URL build
> > variable is used as its default value only if it starts with git://
> > 
> > This does make the assumption that the git repositories share a common
> > path.  Nothing to date is known to actually make use of introduced
> > link.
> > 
> > Created "git" link follows rel=vcs-* microformat specification:
> >   http://kitenet.net/~joey/rfc/rel-vcs/
> > 
> > Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> > I think it might be good idea... but for the fact "Nothing to date is
> > known to actually make use of introduced link".  What's its intended
> > use?
> > 
> > Differences to original version by John 'Warthog9' Hawley (J.H.):
> > * It doesn't cause syntax error ;-)
> > * Escaping of attribute value is left to CGI.pm (avoid double escaping)
> > * $gitlinkurl got renamed to $gitlinkurl_base, now includes git://
> >   prefix, and defaults to GITWEB_BASE_URL if it begins with git://
> > * Added description of $gitlinkurl_base to gitweb/README
> > * Uses rel=vcs-* microformat by Joey Hess

> >  gitweb/README      |    4 ++++
> >  gitweb/gitweb.perl |    8 ++++++++
> >  2 files changed, 12 insertions(+), 0 deletions(-)

A reminder - this patch series consists of the following patches:
 [PATCHv2 1/4 (resent)]     gitweb: Load checking
 [RFC/PATCHv2 2/4 (resent)] gitweb: Add option to force version match
 [PATCHv3 3/4 (resent)]     gitweb: Optionally add "git" links in project list page
 [PATCHv2/RFC 4/4 (resent)] gitweb: Makefile improvements

> Ok I've been debating this as I've been going through the patches, I've
> got small modifications on top of your patches Jakub for 1 and 2,
> haven't pushed them yet but they are relatively trivial.  The changes to
> the first patch sets things up for additional load checkers to be added
> later on.  

Good idea, although I think that such addition can be left for a separate
patch.  

By the way, are you doing if-elsif fallback chain, trying different
mechanisms (like '/proc/loadavg', BSD::getloadavg, etc.), or did
you made get_loadavg() into code reference, i.e. run it with 
$get_loadavg->(), which has the advantage that the gitweb admin can 
override it in gitweb config file (including such thing like simply 
using load average over last 5 minutes, and not over last minute)?

> The second changes the error message to use/abuse die_error() 
> vs. doing it's own thing (though I still think this should be on by
> default).  

True, the error message could use improvement (and not only using
its own class instead of abusing 'readme' class, or renaming 'readme'
class to something more generic).  The problem with error message for
this is who is the target of this message: is it gitweb administrator
(who can change gitweb configuration), or is it gitweb user (who need
to contact web admin).

The problem with this patch is that for it to be useful for protecting
against silent errors it should be on by default, but OTOH having it on
by default is quite inconvenient.

Best solution would be to treat core of this issue, namely eliminate
silent errors and always provide some message in case of error.

> Patch 4 I don't have anything to add or change at this point. 
>
> This patch has me pondering and I'm unsure of what I'd suggest, mainly
> because of the addition of the smart http support meaning that git://
> and http:// are legitimate and useful links for supporting full git
> transactions.
> 
> I may withdraw the patch entirely since the link on kernel.org has been
> around for years, and I'm unsure if anything actually uses it (though I
> can see it being useful still).  If it stays I think there's got to be a
> way to specifically mark a url as being the one to link to vs.
> defaulting to git:// (or allow for a marking to override the git://) and
> I need to ponder that.

Also, it has to be _fast_, I think, i.e. no reading cloneurl and repo 
config (for gitweb.url) for each repository.

You can always remove the check for "git://" prefix, and/or take first
base in @git_base_url_list.

> 
> I have given some initial thought to converting the $output options I'm
> currently using to a print <FH> that Jakub is suggesting & exploring.

It's 'print {$fh}', i.e. use indirect filehandle, not global filehandle.

> I think all told it's going to be a similarly sized patch, since all
> output still has to get adjusted (including the things that directly
> output but don't print).  

print -> print {$fh} can be separate patch, and it can be checked that
it produces the same results.  Well print -> $output .= could also be
separate patch...

> I'm unsure if there's a real advantage to 
> either way, other than design preference. My patch (forcing the output
> to get passed around) moves towards more of a modal style design
> separating data & layout vs. it's combined nature now, well it's a step
> in that direction anyway.

Errr... what?  Forcing buffering (you need to read whole output into
memory, including for snapshots (uncompressed in case of .tar.gz))
is IMVHO orthogonal to the issue of separating data & layout.
BTW. Modern web server interfaces like Rack, PSGI/Plack etc. explicitly
include streaming support.

The advantage of doing 'print {$fh}' is that $fh can be \*STDOUT, can
be \$buffer, but can be filehandle to (temporary) file on disk, and
you can even "tee" it, i.e. both write to memory/file, and to STDOUT.
The number of possible choices / possible improvements is much larger.

And what is also important it means that people who do not use caching
do not suffer latency penalty and memory pressure from caching 
infrastructure they do not use.


P.S. 
Subject: [Virus] Exploit.PDF-9669
X-Virus-Scanned: ClamAV 0.88.7/10275/Fri Jan  8 17:06:46 2010 on shards.monkeyblade.net
X-Virus-Status: Infected with Exploit.PDF-9669
X-Original-Subject: Re: [PATCHv3 3/4 (resent)] gitweb: Optionally add "git"
 links in project list page

A message sent from <warthog9@eaglescrag.net> to
        <jnareb@gmail.com>
        <git@vger.kernel.org>
        <warthog9@kernel.org>
contained Exploit.PDF-9669 and has not been delivered.

-- 
Jakub Narebski
Poland
