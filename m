From: Yann Dirson <ydirson-whniv8GeeGkdnm+yROfE0A@public.gmane.org>
Subject: Re: Distributed VCS with good user verification?
Date: Sun, 10 May 2009 21:59:07 +0200
Message-ID: <20090510195907.GA5994@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20090505212420.GC2761@lasse.mail.plastictre.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, better-scm-discuss-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Lasse Kliemann <lasse-list-scm-discuss-2009-+PtzecH+k/46pNmcfySr8OTW4wlIGRCZ@public.gmane.org>
X-From: better-scm-discuss-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org Sun May 10 21:59:20 2009
Return-path: <better-scm-discuss-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
Envelope-to: gcvd-better-scm-discuss@m.gmane.org
Received: from bat.berlios.de ([195.37.77.135] helo=mail.berlios.de)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3FB7-0006I2-Po
	for gcvd-better-scm-discuss@m.gmane.org; Sun, 10 May 2009 21:59:17 +0200
Received: from bat.berlios.de (localhost [127.0.0.1])
	by mail.berlios.de (Postfix) with ESMTP id BAFD217E413;
	Sun, 10 May 2009 21:59:16 +0200 (CEST)
X-Original-To: better-scm-discuss-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Delivered-To: better-scm-discuss-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by mail.berlios.de (Postfix) with ESMTP id DEAA717C2B0
	for <better-scm-discuss-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>;
	Sun, 10 May 2009 21:59:13 +0200 (CEST)
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 782A1940193;
	Sun, 10 May 2009 21:59:09 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
	[81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 79BA294014A;
	Sun, 10 May 2009 21:59:07 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id CE3A91F0A7; Sun, 10 May 2009 21:59:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090505212420.GC2761-KgLppkx3sYOz9XH0brcyGRf3AA1FrM/fXqFh9Ls21Oc@public.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-BeenThere: better-scm-discuss-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: <better-scm-discuss.lists.berlios.de>
List-Unsubscribe: <https://lists.berlios.de/mailman/listinfo/better-scm-discuss>, 
	<mailto:better-scm-discuss-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/better-scm-discuss>
List-Post: <mailto:better-scm-discuss-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:better-scm-discuss-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/better-scm-discuss>, 
	<mailto:better-scm-discuss-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: better-scm-discuss-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: better-scm-discuss-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118741>

On Tue, May 05, 2009 at 11:24:20PM +0200, Lasse Kliemann wrote:
> This list hasn't seen any traffic for over a year, but since 
> usually no-one unsubscribes from a list with no traffic, I hope 
> someone will read this.
> 
> 
> I am looking for a VCS that makes it easy to see who committed 
> which revision and to be certain that this information is 
> correct.
> 
> When I look at the commit log, I want to see at a glance who 
> committed which revision. I want to be sure that those names 
> displayed are really meaningful. That is, it should be guaranteed 
> that in fact that person which I associate with the displayed 
> name has committed the respective revision.
> 
> In Subversion, a centralized VCS, this can be ensured by 
> correctly setting '--tunnel-user=USER' on the server, when using 
> SSH. Then, a user authenticates himself by his SSH key, then the 
> SSH server picks the corresponding entry in 
> '~/.ssh/authorized_keys', and this will cause the intended user 
> name to be recorded as the committer.
> 
> In a distributed VCS, this is no option since commits happen 
> locally. Instead, revisions must be cryptographically signed.  
> However, signing is not everything. In addition, signatures must 
> be verified, and the commit log should reflect which commits have 
> valid signatures and wich not.


If you're only relying on an ssh tunnel for svn, I suppose it should
be OK for you as well to use this mechanism with a DSCM.  If so,
gitosis provides the necessay infrastucture to do so comfortably on
top of git (gitosis upstream does not seem very active, but there is
at least one gentoo person writing patches, and I registered a mirror
of his repository as a fork on http://repo.or.cz/w/gitosis.git.  FWIW,
I have started to make a couple of cleanups of this code recently, and
will push them as another fork shortly).

OTOH, it does enforce a centralized verification scheme.  If you want
something more flexible, I believe that could easily be done on top of
commit notes (development for that feature has unfortunately stalled
AFAIK).  I'm cc'ing the git list so others have the opportunity to
comment.

> 
> I tested several systems in this respect without finding any 100% 
> satisfactory solution.
> 
> Here is what I found:
> 
> - Mercurial provides an extension to explicitly sign certain 
>   revisions. The act of signing creates a new revision by itself. 
>   It seems like there is no way of automatically checking all 
>   signatures or to detect revisions without signatures.
> 
> - Git only allows to sign tags and to verify those signatures on 
>   demand.
> 
> - Monotone has mandatory signatures, which looks rather good to 
>   me. However, the monotone server does not support encryption 
>   and also does not seem to support SSH tunneling in a convenient 
>   way (like most other systems, by calling 'ssh'), but only by a 
>   "real" tunnel (opening a local port and such). So, 
>   unfortunately, monotone is ruled out by this other criterion.
> 
> - Bazaar can sign revisions, and it can be told to sign each and 
>   every revision upon commit. However, I did not find any 
>   built-in way to check signatures. There is an option 
>   'check_signatures' which can be set to 'required', but I could 
>   not find out what it does actually. It is not documented.
> 
>   There is a plugin for Bazaar, however, with which one can get 
>   statistics on how many revisions are signed and which 
>   signatures cause problems. When this statistics says that 
>   everything is signed and okay, then one can trust the user 
>   names in the commit log.
> 
> Bottom line is that Bazaar is closest to my needs, but not yet 100%.
> 
> Suggestions?
> 
> Thank you!
> Lasse
> 



> _______________________________________________
> Better-scm-discuss mailing list
> Better-scm-discuss-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
> https://lists.berlios.de/mailman/listinfo/better-scm-discuss
