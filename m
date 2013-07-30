From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Documentation: fix typos in man pages
Date: Tue, 30 Jul 2013 10:51:38 -0400
Message-ID: <51F7D2FA.7020208@xiplink.com>
References: <1375132543-20361-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w5h5c3RlaW4gV2FsbGU=?= <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 16:51:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4BHA-0003CR-48
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 16:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab3G3Ovo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jul 2013 10:51:44 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:51066 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab3G3Ovn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 10:51:43 -0400
X-Greylist: delayed 72937 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Jul 2013 10:51:43 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp16.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id AB28E3D01DD;
	Tue, 30 Jul 2013 10:51:42 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp16.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id B8FFC3D00F6;
	Tue, 30 Jul 2013 10:51:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <1375132543-20361-1-git-send-email-oystwa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231362>

On 13-07-29 05:15 PM, =C3=98ystein Walle wrote:
> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
> I thought I'd take part in the typo fixing frenzy :)
>=20
> I have some other potential typos lines up. Right now the docs refer =
to both
> 'filesystem' and 'file system', as well as both 'testsuite' and 'test=
 suite'. I
> think words like these are generally split in English but I'm not sur=
e.

I generally prefer to see the spaces in these words, otherwise it start=
s to
look more like German.

But of course English is full of exceptions...

> There are also some words that I think look better with with a dash, =
e.g.
> 'trade-off'. Should I just send these as a patch too instead of jabbe=
ring on
> about it?

I'm indifferent to that.  I guess it depends on the context, so seeing =
the
patch would help.


I personally don't have a lot of time to investigate the nuances of Eng=
lish.
 However, I desperately hope this list can avoid any linguistic flame w=
ars.
In that spirit, I suggest that anyone posting an orthographic patch (i.=
e. for
something that isn't an obvious spelling mistake) could helpfully inclu=
de a
link or two to an explanation of the reasoning for the change.  Especia=
lly
for folks who aren't native English speakers, this could help avoid a l=
ot of
back-and-forth.

One general source I've found is the English StackExchange:
	http://english.stackexchange.com/

>  Documentation/git-check-ignore.txt | 2 +-
>  Documentation/git-clone.txt        | 2 +-
>  Documentation/git-daemon.txt       | 2 +-
>  Documentation/git-diff.txt         | 2 +-
>  Documentation/gitcli.txt           | 2 +-
>  Documentation/githooks.txt         | 2 +-
>  Documentation/gitweb.conf.txt      | 4 ++--
>  Documentation/user-manual.txt      | 2 +-
>  8 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-c=
heck-ignore.txt
> index d2df487..5354301 100644
> --- a/Documentation/git-check-ignore.txt
> +++ b/Documentation/git-check-ignore.txt
> @@ -35,7 +35,7 @@ OPTIONS
>  	Read file names from stdin instead of from the command-line.
> =20
>  -z::
> -	The output format is modified to be machine-parseable (see
> +	The output format is modified to be machine-parsable (see

I believe this is a US/UK nuance.  As I've recently stated, I think thi=
s kind
of change isn't all that helpful as we're likely to see some well-inten=
tioned
person switch it back sometime in the future.  If the git project could
choose an official English dialect it would go a long way towards mitig=
ating
such churn.

>  	below).  If `--stdin` is also given, input paths are separated
>  	with a NUL character instead of a linefeed character.
> =20
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.tx=
t
> index 450f158..3865658 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -213,7 +213,7 @@ objects from the source repository into a pack in=
 the cloned repository.
>  --separate-git-dir=3D<git dir>::
>  	Instead of placing the cloned repository where it is supposed
>  	to be, place the cloned repository at the specified directory,
> -	then make a filesytem-agnostic Git symbolic link to there.
> +	then make a filesystem-agnostic Git symbolic link to there.
>  	The result is Git repository can be separated from working
>  	tree.
> =20
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.=
txt
> index 223f731..a3283e1 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -189,7 +189,7 @@ Git configuration files in that directory are rea=
dable by `<user>`.
>  	service by exiting with a non-zero status (or to allow it by
>  	exiting with a zero status).  It can also look at the $REMOTE_ADDR
>  	and $REMOTE_PORT environment variables to learn about the
> -	requestor when making this decision.
> +	requester when making this decision.

Although I prefer the -or form for this word, this really is one of Eng=
lish's
vague areas.  Some words that end with -st definitely take the -er suff=
ix
(tester, jester) but others take the -or suffix (investor).  A bit of
Googling also gave no firm result[1][2].

So I think this change is neither good nor bad.  However, like the
UK/US-isms, I wonder if there's some way to avoid people changing this =
back
and forth.  But I don't think simply choosing a dialect will help here.

[1]
http://english.stackexchange.com/questions/29254/whats-the-difference-b=
etween-requester-and-requestor
[2] http://www.spelling.hemscott.net/ends4.html

>  +
>  The external command can optionally write a single line to its
>  standard output to be sent to the requestor as an error message when
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 78d6d50..fe42bf6 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -39,7 +39,7 @@ directories. This behavior can be forced by --no-in=
dex.
>  	commit relative to the named <commit>.  Typically you
>  	would want comparison with the latest commit, so if you
>  	do not give <commit>, it defaults to HEAD.
> -	If HEAD does not exist (e.g. unborned branches) and
> +	If HEAD does not exist (e.g. unborn branches) and
>  	<commit> is not given, it shows all staged changes.
>  	--staged is a synonym of --cached.
> =20
> diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
> index 9ac5088..670c285 100644
> --- a/Documentation/gitcli.txt
> +++ b/Documentation/gitcli.txt
> @@ -28,7 +28,7 @@ arguments.  Here are the rules:
>     they can be disambiguated by placing `--` between them.
>     E.g. `git diff -- HEAD` is, "I have a file called HEAD in my work
>     tree.  Please show changes between the version I staged in the in=
dex
> -   and what I have in the work tree for that file". not "show differ=
ence
> +   and what I have in the work tree for that file", not "show differ=
ence

Good eyes!

		M.
