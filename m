From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Tue, 09 Jul 2013 22:27:43 +0200
Message-ID: <51DC723F.2000602@alum.mit.edu>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <1373399610-8588-1-git-send-email-gitster@pobox.com> <1373399610-8588-8-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 22:27:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UweVr-0003iP-3r
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 22:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271Ab3GIU1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 16:27:47 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49550 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752808Ab3GIU1q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 16:27:46 -0400
X-AuditID: 1207440d-b7f006d000000adf-6f-51dc724278e4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 28.B0.02783.2427CD15; Tue,  9 Jul 2013 16:27:46 -0400 (EDT)
Received: from [192.168.69.140] (p57A24C98.dip0.t-ipconnect.de [87.162.76.152])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r69KRhIN004367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 9 Jul 2013 16:27:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <1373399610-8588-8-git-send-email-gitster@pobox.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1HUquhNo8PoVr0XXlW4mi4beK8wO
	TB4XLyl7fN4kF8AUxW2TlFhSFpyZnqdvl8CdMbFlCWtBj3zF75WvmBoYv0t0MXJySAiYSDya
	fYsZwhaTuHBvPVsXIxeHkMBlRolbSxqYIJxzTBKdzfvYuxg5OHgFtCXO91eDNLAIqEq82LaA
	EcRmE9CVWNTTzARSIioQJnHltypImFdAUOLkzCcsILaIgJrExLZDLCAlzALiEv3/wMLCAoYS
	KxrXg00REpjPKHGpIRikhFPAUWLWU3aQMLOAjsS7vgfMELa8xPa3c5gnMArMQrJgFpKyWUjK
	FjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdLLzSzRS00p3cQICVDeHYz/18kcYhTgYFTi
	4T2gcCdQiDWxrLgy9xCjJAeTkiivYQFQiC8pP6UyI7E4I76oNCe1+BCjBAezkghvEh9Qjjcl
	sbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwfsJZKhgUWp6akVaZk4JQpqJ
	gxNkOJeUSHFqXkpqUWJpSUY8KEbji4FRCpLiAdr7FKSdt7ggMRcoCtF6ilGX48CPLe8ZhVjy
	8vNSpcR5v4MUCYAUZZTmwa2ApaNXjOJAHwvzahUCVfEAUxncpFdAS5iAluxJAVtSkoiQkmpg
	jPVlsfi/KtXsZOKh+LJVC2KFtTklXvN4255Z9spJb39j0ErbpKjNk3bOmt7TuuZA/saAY1f8
	vXpsig7NLqy/MW/Z1JgtLr/8eFg2pUxsqrovvoyd6ZpVNsvhSYWc7DsP6c+aXHjs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230002>

On 07/09/2013 09:53 PM, Junio C Hamano wrote:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-push.txt | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index f7dfe48..e7c8bd6 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
>  	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
> +	   [--lockref[=<refname>[:[<expect>]]]]
>  	   [--no-verify] [<repository> [<refspec>...]]
>  
>  DESCRIPTION
> @@ -146,6 +147,31 @@ already exists on the remote side.
>  	to the `master`	branch). See the `<refspec>...` section above
>  	for details.
>  
> +--lockref::
> +--lockref=<refname>::
> +--lockref=<refname>:<expect>::
> +	When updating <refname> at the remote, make sure that the
> +	ref currently points at <expect> (an object name), and else
> +	fail the push, even if `--force` is specified.  If only
> +	<refname> is given, the expected value is taken from the
> +	remote-tracking branch that holds the last-observed value of
> +	the <refname>.  <expect> given as an empty string means the
> +	<refname> should not exist and this push must be creating
> +	it.  If `--lockref` (without any value) is given, make sure
> +	each ref this push is going to update points at the object
> +	our remote-tracking branch for it points at.

I thought that the explanation in your patch 4/7 log message was
clearer.  In particular, I think that documenting the forms separately,
as you did in the log message, makes it unambiguous, whereas for example
the distinction in prose between "If only <refname> is given" and
"<expect> given as an empty string" is easy to miss.

Does "--lockref" only apply to references that need non-ff updates, or
to all references that are being pushed?  This is mostly interesting for
the zero-argument form (especially if a config option is invented to
make this the default), but the question should also be answered for the
other forms.

> +This is meant to make `--force` safer to use.  Imagine that you have
> +to rebase what you have already published.  You will have to
> +`--force` the push to replace the history you originally published
> +with the rebased history.  If somebody else built on top of your
> +original history while you are rebasing, the tip of the branch at

s/are/were/

> +the remote may advance with her commit, and blindly pushing with

s/advance/have advanced/

> +`--force` will lose her work.  By using this option to specify that
> +you expect the history you are updating is what you rebased and want
> +to replace, you can make sure other people's work will not be losed

s/losed/lost/

> +by a forced push. in such a case.

s/push./push/ or s/in such a case.//

> +
>  --repo=<repository>::
>  	This option is only relevant if no <repository> argument is
>  	passed in the invocation. In this case, 'git push' derives the
> 

Another minor point: "git update-ref" allows either 40 "0" or the empty
string to check that the ref doesn't already exist.  For consistency it
might be nice to accept 40 "0" here as well.

I still really like the idea of the feature.

<bikeshed>
The name "--lockref" is OK, but for me it's less a question of
"locking", because as far as the user is concerned the push is an atomic
operation so there is no sense of a "lock" that is being held for a
finite period of time.  For me it is more a question of "checking" or
"verifying".  I see that the word "verify" already has a meaning for
this command, so maybe "--checkref" or "--checkold" or "--checkoldref"?
</bikeshed>

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
