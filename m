From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] Provide a mechanism to turn off symlink resolution in ceiling
 paths
Date: Fri, 22 Feb 2013 08:23:08 +0100
Message-ID: <51271CDC.4000001@alum.mit.edu>
References: <1361351364-15479-1-git-send-email-mhagger@alum.mit.edu> <7vk3q1th1l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@MIT.EDU>,
	David Aguilar <davvid@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	David Reiss <dreiss@facebook.com>,
	Johannes Sixt <j6t@kdbg.org>,
	"Lars R. Damerow" <lars@pixar.com>, Jeff King <peff@peff.net>,
	Marc Jordan <marc.jordan@disneyanimation.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 08:23:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8myq-0004CB-TB
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 08:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576Ab3BVHXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 02:23:16 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:55284 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752285Ab3BVHXP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2013 02:23:15 -0500
X-AuditID: 12074414-b7f926d000001263-06-51271ce229b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 22.12.04707.2EC17215; Fri, 22 Feb 2013 02:23:14 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r1M7N9ns025789
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Feb 2013 02:23:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7vk3q1th1l.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTURzn3HPdro8bx5vmab5qUko1KzK7gYVEH+4nS8IKIfTqrttqu67d
	LZwQWJrCdNmDPqQGlj0sEk0iG2bUSHRmqT0x0spsmVnUhOhJ3esw/XL4nfN7cfj/Kcj4QzSU
	SbQLNpE3a1VhJKPeulQ3FpecvebB+3i2/+gutu3CVcjemxqHrOtJNcGWuZ9AdvzMCGT9J6+p
	2e4+lq08dZ1kv1fUQLb181OYGc4dqa1WcVNVbsB56kbU3JtJl5o73N8NOb/7FuAGO3yQG3qU
	xE23J2wPzQ3PKODtB3aYDOLqzfnhxsDATuvPLSUTA11kGTiU7gKhFEZpuLatiwjiRXhwtFXl
	AmEUgx4D3P+hPiR46SFw19kA6QIURaOVeGqYUwwkWobHzt8NUbAK6fC5mvKZoGi0E7s/PgQK
	plEk9p0eJxUchZbj45VeUsmEqAziVy/qZ8wL0W789lTbjIFBIi5vvqpWcChKx6OvmlUKhnLB
	cO9XIogTccenBngMoLp5HXXzZHXzZI0AXgEJvNlh0Vl4k1kSCnVSIS+Kgk3HplpM9lRB72gH
	wQlF3QT3fAlegCigjaCPbF2ezYTwBySnxQsWU4Q2mu7UJGczCwqK9U4jLxnzbA6zIHkBpqA2
	il6dI8tpPe8sFWzFs1QsRWpj6G9NyVkMMvB2YZ8gWAXbLBtHUVpMB2Ll0EibYBBKikxm+xxN
	UKFKeJgmShJEvWDjHXZjnjLUPEmeqkJFyL1L5aViaMnKW+TXoLUPrKMan41NAKrzs3wypFgs
	CpoYOkKRIkVqdIj/i2bXcxLEyP9eSC9RVBHy8v7Pm5SrCLmq5VKSUmXn5yhNGWga 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216821>

On 02/21/2013 11:53 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Unfortunately I am swamped with other work right now so I don't have
>> time to test the code and might not be able to respond promptly to
>> feedback.
> 
> A note like the above is a good way to give a cue to others so that
> we can work together to pick up, tie the loose ends and move us
> closer to the goal, and is very much appreciated.
> 
> I think the patch makes sense; I expanded on the part that has
> Anders's report in the log message and added a trivial test.
> 
> Testing and eyeballing by others would help very much.  We'd
> obviously need our sign-off as well ;-)

Thanks for following up on this.  Your tests look OK by eyeball and they
run successfully here whether the testing --root is under a symlink or
not.  I did notice some minor niggles in the text (including one in my
original submission); see below.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael

> -- >8 --
> From: Michael Haggerty <mhagger@alum.mit.edu>
> Date: Wed, 20 Feb 2013 10:09:24 +0100
> Subject: [PATCH] Provide a mechanism to turn off symlink resolution in ceiling paths
> 
> Commit 1b77d83cab 'setup_git_directory_gently_1(): resolve symlinks
> in ceiling paths' changed the setup code to resolve symlinks in the
> entries in GIT_CEILING_DIRECTORIES.  Because those entries are
> compared textually to the symlink-resolved current directory, an
> entry in GIT_CEILING_DIRECTORIES that contained a symlink would have
> no effect.  It was known that this could cause performance problems
> if the symlink resolution *itself* touched slow filesystems, but it
> was thought that such use cases would be unlikely.  The intention of
> the earlier change was to deal with a case when the user has this:
> 
> 	GIT_CEILING_DIRECTORIES=/home/gitster
> 
> but in reality, /home/gitster is a symbolic link to somewhere else,
> e.g. /net/machine/home4/gitster. A textual comparison between the
> specified value /home/gitster and the location getcwd(3) returns
> would not help us, but readlink("/home/gitster") would still be
> fast.
> 
> After this change was released, Anders Kaseorg <andersk@mit.edu>
> reported:
> 
>> [...] my computer has been acting so slow when I$B!G(Bm not connected to
>> the network.  I put various network filesystem paths in
>> $GIT_CEILING_DIRECTORIES, such as
>> /afs/athena.mit.edu/user/a/n/andersk (to avoid hitting its parents
>> /afs/athena.mit.edu, /afs/athena.mit.edu/user/a, and
>> /afs/athena.mit.edu/user/a/n which all live in different AFS
>> volumes).  Now when I$B!G(Bm not connected to the network, every
>> invocation of Git, including the __git_ps1 in my shell prompt, waits
>> for AFS to timeout.
> 
> To allow users to work this around, give them a mechanism to turn

s/this around/around this problem/

> off symlink resolution in GIT_CEILING_DIRECTORIES entries.  All the
> entries that follow an empty entry will not be checked for symbolic
> links and used literally in comparison.  E.g. with these:

Make it clear that "not" doesn't apply to both sides of the "and", since
the operator precedence in English is undocumented:

s/and/but rather will be/

> 
> 	GIT_CEILING_DIRECTORIES=:/foo/bar:/xyzzy or
> 	GIT_CEILING_DIRECTORIES=/foo/bar::/xyzzy
> 
> we will not readlink("/xyzzy"), and with the former, we will not
> readlink("/foo/bar"), either.
> ---
>  Documentation/git.txt   | 19 +++++++++++++------
>  setup.c                 | 32 ++++++++++++++++++++++----------
>  t/t1504-ceiling-dirs.sh | 17 +++++++++++++++++
>  3 files changed, 52 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 6710cb0..5c03616 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -653,12 +653,19 @@ git so take care if using Cogito etc.
>  	The '--namespace' command-line option also sets this value.
>  
>  'GIT_CEILING_DIRECTORIES'::
> -	This should be a colon-separated list of absolute paths.
> -	If set, it is a list of directories that git should not chdir
> -	up into while looking for a repository directory.
> -	It will not exclude the current working directory or
> -	a GIT_DIR set on the command line or in the environment.
> -	(Useful for excluding slow-loading network directories.)
> +	This should be a colon-separated list of absolute paths.  If
> +	set, it is a list of directories that git should not chdir up
> +	into while looking for a repository directory (useful for
> +	excluding slow-loading network directories).  It will not
> +	exclude the current working directory or a GIT_DIR set on the
> +	command line or in the environment.  Normally, Git has to read
> +	the entries in this list are read to resolve any symlinks that

"read" is duplicated:

s/are read to//

> +	might be present in order to compare them with the current
> +	directory.  However, if even this access is slow, you
> +	can add an empty entry to the list to tell Git that the
> +	subsequent entries are not symlinks and needn't be resolved;
> +	e.g.,
> +	'GIT_CEILING_DIRECTORIES=/maybe/symlink::/very/slow/non/symlink'.
>  
>  'GIT_DISCOVERY_ACROSS_FILESYSTEM'::
>  	When run in a directory that does not have ".git" repository
> diff --git a/setup.c b/setup.c
> index f108c4b..1b12017 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -624,22 +624,32 @@ static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_
>  /*
>   * A "string_list_each_func_t" function that canonicalizes an entry
>   * from GIT_CEILING_DIRECTORIES using real_path_if_valid(), or
> - * discards it if unusable.
> + * discards it if unusable.  The presence of an empty entry in
> + * GIT_CEILING_DIRECTORIES turns off canonicalization for all
> + * subsequent entries.
>   */
>  static int canonicalize_ceiling_entry(struct string_list_item *item,
> -				      void *unused)
> +				      void *cb_data)
>  {
> +	int *empty_entry_found = cb_data;
>  	char *ceil = item->string;
> -	const char *real_path;
>  
> -	if (!*ceil || !is_absolute_path(ceil))
> +	if (!*ceil) {
> +		*empty_entry_found = 1;
>  		return 0;
> -	real_path = real_path_if_valid(ceil);
> -	if (!real_path)
> +	} else if (!is_absolute_path(ceil)) {
>  		return 0;
> -	free(item->string);
> -	item->string = xstrdup(real_path);
> -	return 1;
> +	} else if (*empty_entry_found) {
> +		/* Keep entry but do not canonicalize it */
> +		return 1;
> +	} else {
> +		const char *real_path = real_path_if_valid(ceil);
> +		if (!real_path)
> +			return 0;
> +		free(item->string);
> +		item->string = xstrdup(real_path);
> +		return 1;
> +	}
>  }
>  
>  /*
> @@ -679,9 +689,11 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
>  		return setup_explicit_git_dir(gitdirenv, cwd, len, nongit_ok);
>  
>  	if (env_ceiling_dirs) {
> +		int empty_entry_found = 0;
> +
>  		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
>  		filter_string_list(&ceiling_dirs, 0,
> -				   canonicalize_ceiling_entry, NULL);
> +				   canonicalize_ceiling_entry, &empty_entry_found);
>  		ceil_offset = longest_ancestor_length(cwd, &ceiling_dirs);
>  		string_list_clear(&ceiling_dirs, 0);
>  	}
> diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
> index cce87a5..3d51615 100755
> --- a/t/t1504-ceiling-dirs.sh
> +++ b/t/t1504-ceiling-dirs.sh
> @@ -44,6 +44,10 @@ test_prefix ceil_at_sub ""
>  GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/"
>  test_prefix ceil_at_sub_slash ""
>  
> +if test_have_prereq SYMLINKS
> +then
> +	ln -s sub top
> +fi
>  
>  mkdir -p sub/dir || exit 1
>  cd sub/dir || exit 1
> @@ -68,6 +72,19 @@ test_fail subdir_ceil_at_sub
>  GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/"
>  test_fail subdir_ceil_at_sub_slash
>  
> +if test_have_prereq SYMLINKS
> +then
> +	GIT_CEILING_DIRECTORIES="$TRASH_ROOT/top"
> +	test_fail subdir_ceil_at_top
> +	GIT_CEILING_DIRECTORIES="$TRASH_ROOT/top/"
> +	test_fail subdir_ceil_at_top_slash
> +
> +	GIT_CEILING_DIRECTORIES=":$TRASH_ROOT/top"
> +	test_prefix subdir_ceil_at_top_no_resolve "sub/dir/"
> +	GIT_CEILING_DIRECTORIES=":$TRASH_ROOT/top/"
> +	test_prefix subdir_ceil_at_top_slash_no_resolve "sub/dir/"
> +fi
> +
>  GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/dir"
>  test_prefix subdir_ceil_at_subdir "sub/dir/"
>  
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
