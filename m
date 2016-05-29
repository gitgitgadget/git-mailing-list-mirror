From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 1/2] Do not output whitespace on blank lines
Date: Sun, 29 May 2016 19:25:08 +0200
Message-ID: <574B25F4.8090409@web.de>
References: <01020154fd28aa12-f536bf3e-58df-4d1f-b903-929b429954d3-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dave Nicolson <david.nicolson@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 19:25:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b74So-0006iT-Po
	for gcvg-git-2@plane.gmane.org; Sun, 29 May 2016 19:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbcE2RZT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2016 13:25:19 -0400
Received: from mout.web.de ([217.72.192.78]:58884 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782AbcE2RZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2016 13:25:17 -0400
X-Greylist: delayed 95897 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 May 2016 13:25:17 EDT
Received: from [192.168.178.36] ([79.213.127.144]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LzK61-1bbmTx3009-014Ppq; Sun, 29 May 2016 19:25:12
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <01020154fd28aa12-f536bf3e-58df-4d1f-b903-929b429954d3-000000@eu-west-1.amazonses.com>
X-Provags-ID: V03:K0:c7beEe53wvjXOnXnkaSpOLfq4nkOW+Ur1Y6tzdhbT8CSQYcLoA9
 VKOsg1+Mkrx3pyo3otbvjXjyPkiyQ3XwhauDgAulyLrNxxIXf8O71ENjd2jscz5m7nA7Kn4
 hFf2a+xLZyqL18fs129gTdQPfh2e6rb2Uoh3swrxQaUxP5W8qctWdyYjJtw8bYb6P4FccNR
 1xa6Z3C8mHOax7J7rsDuA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S10j4LssWsc=:NdPEkSKERK4Z4jn4yHFZ/x
 ZrqcXyYZrOv9aw2k0MYtWYz4u46VRJWIGCo0DqfQWohhpN6ka51IC9ATUAe8XkQzZsIpIHjqP
 p9KuIFCmGnhmX16XveRRpc0iT3P1nybHdDOj7sfUlxRkY0lSr5Rs4/+jAPYwMt4L7MOvX2Oh6
 5r69RJ8j1eLEZslYIPqll0w8omcW48IMwcoh40q8yk6A7imJNVIlr/k6JnmFgT7z0iQU0MOHk
 4ATBc/3+n1fPIxGH043/Sd7rD6if4hAxrPSxHBSW0NeslMuutX/nuvMQ3lG0PkshGhY5Bfy11
 xo++cQSRo6e6qu8lBgDoLovWIBEMmCauOeJbsHMO01yjO8PRzI2/GiokNzFd+1H1Vq8fD9p+7
 afXCUARjUFK2OOaSHc+Y4zNRvbU35nBI5HUO5MbP9wxkVQRig0rIvSkVgR1CYUhX2dF+F4hia
 niUGzs5GI8SyoqGhhGtc2IXZxWlA7FPMPXFvRvc87GJMzFkpVn7dtwNb7F6zKDIST6Pj0paA5
 YU56zXzmxiEjyVe0ITD5VEi/Pmv5ugavl49I7i/yoLsfdwuZykBn207WGCwjsOrG9ztMjdBn+
 xvGTDJSujxmRQw6H0fjjUhBGPi1JVweRtQFYpEt4y7H/PlzKtYH3e9tsfuP6Os61ft4PSxy+W
 D7vZIQi9blBcPYMnqhE+2vsDyea64oh6+5nS+T+2sjPSJ5REkGi4wkE6beEYzMhiu3EtKl1nC
 99SAZ4MIM5S810Ct5JH9ZZMFlpV/axvDbw/omz3uqfmCL4DsICrG1DJjhJvNlL0HhkFf6ctV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295839>

Am 29.05.2016 um 17:36 schrieb Dave Nicolson:
> ---

git diff marks context lines (in unified diff format) with a preceding=20
space character.  Your intent is to remove that marker for empty contex=
t=20
lines, right?  Why?  How much smaller do diffs get by that (assuming=20
output size reduction is one of the reasons)?

How compatible is it with patch, git apply and other programs that=20
handle diffs?  Interestingly in that context, POSIX [*] allows it,=20
saying: "It is implementation-defined whether an empty unaffected line=20
is written as an empty line or a line containing a single <space>=20
character."

Also: missing sign-off (see Documentation/SubmittingPatches).

>   diff.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index d3734d3..459b36a 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -471,7 +471,7 @@ static void emit_line_0(struct diff_options *o, c=
onst char *set, const char *res
>   		has_trailing_carriage_return =3D (len > 0 && line[len-1] =3D=3D '=
\r');
>   		if (has_trailing_carriage_return)
>   			len--;
> -		nofirst =3D 0;
> +		nofirst =3D len =3D=3D 0 && (char)first =3D=3D ' ' ? 1 : 0;

Why the cast from int to char?  And you also don't need the "? 1 : 0" p=
art.

>   	}
>
>   	if (len || !nofirst) {
>
> --
> https://github.com/git/git/pull/245

Your second patch adjusts tests.  It would be better to combine the two=
=20
in order to keep tests working with each commit.

Ren=E9


[*] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/diff.html
