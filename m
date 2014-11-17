From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Mon, 17 Nov 2014 17:19:08 +0100
Message-ID: <546A1FFC.60605@alum.mit.edu>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>	<1416122508-30654-2-git-send-email-mhagger@alum.mit.edu>	<CAPig+cQ6j-3_Ng8DVT3FYk8T6DippEbYDhQq5v3DTJhGgBhPDQ@mail.gmail.com>	<5469C40B.4080601@alum.mit.edu> <xmqqbno5zvdm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 17:19:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqP1S-0007zF-8U
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 17:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbaKQQTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 11:19:22 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48283 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750806AbaKQQTV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Nov 2014 11:19:21 -0500
X-AuditID: 12074414-f79446d0000031d8-10-546a1fff90fc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1D.51.12760.FFF1A645; Mon, 17 Nov 2014 11:19:11 -0500 (EST)
Received: from [192.168.69.130] (p5DDB383E.dip0.t-ipconnect.de [93.219.56.62])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAHGJ8Wc012463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 17 Nov 2014 11:19:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <xmqqbno5zvdm.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsUixO6iqPtfPivEoH2LlkXXlW4mi4beK8wW
	C/8dZbf4v2MBi8X+piSLNd07mCzOvGlktOjs+MrowOGxc9Zddo9jx1qZPS5eUvZY/MDL4/Mm
	OY/bz7axeDRPOc8awB7FbZOUWFIWnJmep2+XwJ3ReS+7YC9vxY0XF5gbGA9wdTFycEgImEh8
	WsTexcgJZIpJXLi3nq2LkYtDSOAyo8TutptQzjkmielnrjOBVPEKaEr8+XUOrINFQFVidvNy
	sDibgK7Eop5mMFtUIEji5J7r7BD1ghInZz5hAbFFBNQkJrYdYgEZyixwmEniYtsUsISwQITE
	lG3HmCC2TWSS6O2exAqS4BSwluhd3skIYjML6EnsuP6LFcKWl2jeOpt5AqPALCRLZiEpm4Wk
	bAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkJgQ2cF45KTcIUYBDkYl
	Ht4d2ZkhQqyJZcWVuYcYJTmYlER514tmhQjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4Y25CFTO
	m5JYWZValA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBO0EOaKhgUWp6akVaZk4J
	QpqJgxNkOJeUSHFqXkpqUWJpSUY8KFbji4HRCpLiAdo7D6Sdt7ggMRcoCtF6ilFRShwiIQCS
	yCjNgxsLS3SvGMWBvhTmZQamPSEeYJKE634FNJgJaPCcDSAPFZckIqSkGhj9Ql83f/hZ+f7d
	IUPBm1O7W1mWX44qlNF4ue15ZdsD9aaH6633MZ66q9/qWayZr3+5sYlftzbLUPW/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2014 04:42 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This seems like a one-off bug caused by a specific instance of odd code.
>> It could only recur if somebody were to remove the line that I added,
>> which would be a *very* odd mistake to make given that its purpose is
>> pretty obvious.
> 
> Or some other code that comes _after_ your new code touches the
> file.
> 
> You cannot anticipate what mistake others make.

And yet we do so all the time, adding tests for the things we consider
most likely to break in the future and omitting them for breakages that
seem unlikely. Otherwise, what frees us from the obligation to add a '!
test -x "$GIT_DIR/config"' following every single git operation?

But it's OK with me, we can add a test.

> Shouldn't something like this be sufficient?
> 
>  t/t0001-init.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index e62c0ff..acdc1df 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -12,6 +12,13 @@ check_config () {
>  		echo "expected a directory $1, a file $1/config and $1/refs"
>  		return 1
>  	fi
> +
> +	if ! test_have_prereq POSIXPERM || test -x "$1/config"
> +	then
> +		echo "$1/config is executable?"
> +		return 1
> +	fi
> +
>  	bare=$(cd "$1" && git config --bool core.bare)
>  	worktree=$(cd "$1" && git config core.worktree) ||
>  	worktree=unset
> 

I think the logic should be

	if test_have_prereq POSIXPERM && test -x "$1/config"

, right? If the system doesn't have POSIXPERM, then aren't all bets off
regarding file permissions?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
