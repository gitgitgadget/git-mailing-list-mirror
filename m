From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 2/1] support -4 and -6 switches for remote operations
Date: Sun, 31 Jan 2016 00:34:31 +0100
Message-ID: <56AD4887.3070207@web.de>
References: <20160128225123.GA20045@dcvr.yhbt.net>
 <xmqqegd1l13l.fsf@gitster.mtv.corp.google.com>
 <20160130085056.GA20118@dcvr.yhbt.net> <20160130131353.GA20429@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 00:35:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPf2z-00070O-K1
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 00:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170AbcA3XfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 18:35:11 -0500
Received: from mout.web.de ([212.227.15.3]:50616 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757156AbcA3XfK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 18:35:10 -0500
Received: from macce.local ([79.223.103.61]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0M4HmV-1a8POr0Z51-00rpQL; Sun, 31 Jan 2016 00:34:34
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.5.1
In-Reply-To: <20160130131353.GA20429@dcvr.yhbt.net>
X-Provags-ID: V03:K0:NT0q1T2OBygkR85AS7R6iWq1E/iNjGA/J/1w752DAA7JyJq2pMA
 MHy7LwEpW8PdyecAPyHUbMzi6NN6Xh9riEO2Y4aOnQ7lwBwSQjM/4iyY1Pz8APTCGrlbIh/
 spLOWXVrzyI+cxGAfTfY6yXk6uHkJUSbIR5MKCrXkRS461EI7XRs1ClzLqdgYEY+QKeA2T5
 2DHt/7O5q4oIZgMiPwkVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BMGTRkkdCGo=:NU6Iu+zMdMDJ6gKv6WtQPf
 xWyG+sssM03P6jJ/4RGTqyjk6GcvQTJwNAgtVv0/owfHzxBVrPbyN80jd/39g4Xbcl877XsuI
 Nika00O6Ek9UuWCGujeUlO9+XERcNJPvS77WrFstk54YcylL8oPAqjcIIJUCHf5kk/sXTAQUh
 KQjg114hgbubDLUpw06era6BfKVWOhglN6WHWEvZtTpR0OWc9AN/IMbSshd1aBQEIbFFJZwjk
 CzkZfQfmaQhSh8Onm/0/7lkMSvrI+TN6BatXJDwQwXG4rJ4/9DDtiVcYP59lr3vwwe603lsHs
 w0hPxI15vHQS+IqBhJ0w0mTAFl5OS9yrumK7sH0TsaoAmfLXZIHBRvwq648sTdUTL8iOAIXyl
 RT7Bn3wac2gDRXUuQ175Z2ahyZs25yKg118ZO4vq6yvVlOFaNph7ouBqwrkQfqSZLeO1H/l0N
 KknUuyazos1TKar+CGjBqos5W9gYY0wGSrtltVDqOIARPK3QGUb10USaywM/KN4/e+EXA0rfM
 diMHf3rkngTKhfnv34GN54WKOCewnQclUEilqsJoo9z6UPS+12bmljtxrYQ90QvTrlw1pzsY4
 ULAm70n9wj3M/EX1lWjXoluLYr1CvS3u4UL6g/gtEvh55fUxd/+wCZFo5+ut6np2EoW48v0nd
 +0pnjp0k3gobVssr2kuiJnCbKlVOG/oFbN4zRe2IiA44bCTYGaROlGeH3ftlQVc040jVCvSkm
 Fb/fIi1uIRSGEifb+V5nN/7/0E/Ql3j8d36EUyndlaZEcre+2TF02kZLVXmylyCr/a6vQVyn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285130>

On 2016-01-30 14.13, Eric Wong wrote:
Nicely done, some minor questions inline.
> Sometimes, it is necessary to force IPv4-only or IPv6-only
> operation on networks where name lookups may return a
> non-routable address and stall remote operations.
>
> The ssh(1) command has an equivalent switches which we may
> pass when we run them.
Should we mention that putty and tortoiseplink don't have these options ?
At least in the commit message ?
> rsync support is untouched for now since it is deprecated
> and scheduled to be removed.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  Documentation/fetch-options.txt |  8 ++++++++
>  Documentation/git-push.txt      |  7 +++++++
>  builtin/clone.c                 |  4 ++++
>  builtin/fetch.c                 |  4 ++++
>  builtin/push.c                  |  4 ++++
>  connect.c                       |  8 ++++++++
>  connect.h                       |  2 ++
>  http.c                          |  9 +++++++++
>  http.h                          |  1 +
>  remote-curl.c                   | 19 +++++++++++++++++++
>  transport-helper.c              |  7 +++++++
>  transport.c                     | 18 ++++++++++++++++++
>  transport.h                     | 11 +++++++++++
>  13 files changed, 102 insertions(+)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index 952dfdf..6ec7dde 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -158,3 +158,11 @@ endif::git-pull[]
>  	by default when it is attached to a terminal, unless -q
>  	is specified. This flag forces progress status even if the
>  	standard error stream is not directed to a terminal.
> +
> +-4::
> +--ipv4::
> +	Resolve IPv4 addresses only, ignoring IPv6 addresses.
> +
> +-6::
> +--ipv6::
> +	Resolve IPv6 addresses only, ignoring IPv4 addresses.
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 32482ce..559c166 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -277,6 +277,13 @@ origin +master` to force a push to the `master` branch). See the
>  	default is --verify, giving the hook a chance to prevent the
>  	push.  With --no-verify, the hook is bypassed completely.
>  
> +-4::
> +--ipv4::
> +	Resolve IPv4 addresses only, ignoring IPv6 addresses.
> +
> +-6::
> +--ipv6::
> +	Resolve IPv6 addresses only, ignoring IPv4 addresses.
>  
>  include::urls-remotes.txt[]
>  
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 81e238f..3feae64 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -47,6 +47,7 @@ static const char *real_git_dir;
>  static char *option_upload_pack = "git-upload-pack";
>  static int option_verbosity;
>  static int option_progress = -1;
> +static int ipv4, ipv6;
Do we need 2 variables here ?

Or would
int preferred_ip_version
be better ?
>  static struct string_list option_config;
>  static struct string_list option_reference;
>  static int option_dissociate;
> @@ -92,6 +93,8 @@ static struct option builtin_clone_options[] = {
>  		   N_("separate git dir from working tree")),
>  	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
>  			N_("set config inside the new repository")),
> +	OPT_BOOL('4', "ipv4", &ipv4, N_("resolve IPv4 addresses only")),
> +	OPT_BOOL('6', "ipv6", &ipv6, N_("resolve IPv6 addresses only")),
Technically OK to mention resolve, but does it give any information to the user ?
s/resolve IPv4 addresses only/use IPv4 addresses only/

>  	OPT_END()
>  };
>  
> @@ -970,6 +973,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	remote = remote_get(option_origin);
>  	transport = transport_get(remote, remote->url[0]);
>  	transport_set_verbosity(transport, option_verbosity, option_progress);
> +	transport_set_family(transport, ipv4, ipv6);
>  
Does it make sense to name the variable into
ipv4only (to make clear that it does not mean ipv4_allowed ?)
(and similar in the rest of the code)

[snip]
