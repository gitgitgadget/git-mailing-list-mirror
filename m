From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] branch: change install_branch_config() to use skip_prefix()
Date: Thu, 27 Feb 2014 12:42:03 +0100
Message-ID: <530F248B.6030506@alum.mit.edu>
References: <530F1DED.50308@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
X-From: git-owner@vger.kernel.org Thu Feb 27 12:42:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIzM5-0007Kw-Rx
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 12:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbaB0LmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 06:42:12 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60889 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752754AbaB0LmH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 06:42:07 -0500
X-AuditID: 1207440d-f79d86d0000043db-a7-530f248e59c8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.54.17371.E842F035; Thu, 27 Feb 2014 06:42:06 -0500 (EST)
Received: from [192.168.69.148] (p57A24AC7.dip0.t-ipconnect.de [87.162.74.199])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1RBg3Vf028868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 27 Feb 2014 06:42:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <530F1DED.50308@yandex.ru>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqNunwh9ssPK/qMXBrafZLbqudDM5
	MHl83iTncbihnyWAKYrbJimxpCw4Mz1P3y6BO+PRyqVMBct4Kv4t2MPUwPiVs4uRg0NCwERi
	7rOMLkZOIFNM4sK99WxdjFwcQgKXGSVW7DnEBOGcZ5LYuqGbBaSKV0Bb4sTTz6wgNouAqsSq
	5m3sIDabgK7Eop5mJhBbVCBYYvXlB1D1ghInZz4Bs0UEzCWav85mB1nMLCAu0f8PLCwsECAx
	eWU7M4gtJKAmsav5ACOIzSmgLrH9yndmiDvFJXoagyA61SXWzxMCqWAWkJfY/nYO8wRGwVlI
	ds1CqJqFpGoBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJDA5d3B+H+d
	zCFGAQ5GJR7eE8x8wUKsiWXFlbmHGCU5mJREebvk+YOF+JLyUyozEosz4otKc1KLDzFKcDAr
	ifCuZwLK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeKcrAzUKFqWm
	p1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgyI3vhgYuyApHqC9x0DaeYsLEnOBohCtpxh1
	OW63/frEKMSSl5+XKiXO26wEVCQAUpRRmge3ApamXjGKA30szHsTZBQPMMXBTXoFtIQJaMlR
	aR6QJSWJCCmpBkaxf19456V3CrZJXF+7KCs6Rkd4J//RlaUnY5dI32MU/mv17edXmxCFUrlD
	v1LlVyXur1ru+KHoavrL80wv3FQfCWk+KvLI81Pb+/ewbM6n6u3M/ctC72h/vMFY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242810>

Dmitry,

Thanks for your patch.  Please see my comments below.

On 02/27/2014 12:13 PM, Dmitry S. Dolzhenko wrote:
> Change install_branch_config() function to use skip_prefix()
> for getting short name of remote branch.

English tweak suggestion:

Change THE install_branch_config() function to use skip_prefix()
for getting THE short name of THE remote branch.

> Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
> ---
>  branch.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/branch.c b/branch.c
> index 723a36b..310749b 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -4,6 +4,8 @@
>  #include "remote.h"
>  #include "commit.h"
>  
> +static const char refs_heads_prefix[] = "refs/heads/";
> +
>  struct tracking {
>  	struct refspec spec;
>  	char *src;
> @@ -49,8 +51,8 @@ static int should_setup_rebase(const char *origin)
>  
>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
> -	const char *shortname = remote + 11;
> -	int remote_is_branch = starts_with(remote, "refs/heads/");
> +	const char *shortname = skip_prefix(remote, refs_heads_prefix);
> +	int remote_is_branch = starts_with(remote, refs_heads_prefix);
>  	struct strbuf key = STRBUF_INIT;
>  	int rebasing = should_setup_rebase(origin);
>  
> 

If you look at what skip_prefix() and starts_with() do, I think you will
find that you are doing too much work here.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
