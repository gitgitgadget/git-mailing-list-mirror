From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] parse-options.c:parse_options_check() change OPTION_NUMBER
 to OPTION_CMDMODE
Date: Fri, 28 Feb 2014 11:15:45 +0100
Message-ID: <531061D1.2060206@alum.mit.edu>
References: <1393578442-2822-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 11:15:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJKU0-00029o-OX
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 11:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbaB1KPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 05:15:51 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:50614 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751081AbaB1KPt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 05:15:49 -0500
X-AuditID: 12074414-f79d96d000002d2b-22-531061d4baef
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 7B.BA.11563.4D160135; Fri, 28 Feb 2014 05:15:48 -0500 (EST)
Received: from [192.168.69.148] (p57A2462E.dip0.t-ipconnect.de [87.162.70.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1SAFkha023530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 28 Feb 2014 05:15:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <1393578442-2822-1-git-send-email-sunheehnus@gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqHslUSDY4Os3DouuK91MFm23tzM6
	MHnsnHWX3ePzJrkApihum6TEkrLgzPQ8fbsE7oydq/4wFxznr5jY3czUwLiGp4uRk0NCwERi
	f9sONghbTOLCvfVANheHkMBlRomVs56xgiSEBM4xSXx8pwti8wpoS7yde4gdxGYRUJXY+v0j
	WDObgK7Eop5mJhBbVCBYYvXlBywQ9YISJ2c+AbNFBBQlDh7fytzFyMHBLCAu0f8PLCwskCxx
	pu0GE8QqZ4kT6x+CjecUcJHY2jmFCaRcAqi8pzEIJMwsoCPxru8BM4QtL7H97RzmCYyCs5As
	m4WkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJTSjcxQoJXZAfjkZNy
	hxgFOBiVeHgnePIHC7EmlhVX5h5ilORgUhLlZUwQCBbiS8pPqcxILM6ILyrNSS0+xCjBwawk
	wpvnDpTjTUmsrEotyodJSXOwKInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLg/QcyVLAoNT21
	Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4UvfHFwPgFSfEA7RVIBNlbXJCYCxSFaD3FqMtx
	u+3XJ0Yhlrz8vFQpcV4ekCIBkKKM0jy4FbBU9YpRHOhjYV5BkCoeYJqDm/QKaAkT0BJOT7Al
	JYkIKakGxpp1wdXHdhTKbK/3ipnP9uzYeQe5Ettvc37IbL1YdDTaZccNhnUuuzk1F7jvTr0d
	9fuy0YXkgJqkg2cnfTgwo8BoTte6JF9NO+0roYpmOrNKZ3wx0JjFf17GSuY7x+m+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242937>

On 02/28/2014 10:07 AM, Sun He wrote:
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>  parse-options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index 7b8d3fa..59a52b0 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -371,7 +371,7 @@ static void parse_options_check(const struct option *opts)
>  		case OPTION_NEGBIT:
>  		case OPTION_SET_INT:
>  		case OPTION_SET_PTR:
> -		case OPTION_NUMBER:
> +		case OPTION_CMDMODE:
>  			if ((opts->flags & PARSE_OPT_OPTARG) ||
>  			    !(opts->flags & PARSE_OPT_NOARG))
>  				err |= optbug(opts, "should not accept an argument");
> 
> -- 
> 1.9.0.138.g2de3478.dirty
> 
> Hi,
> When I was reading code yesterday, I came across this protential bug.
> parse-options.h says that OPTION_CMDMODE is an option with no arguments and OPTION_NUMBER is special type option.
> 
> According to the information the program says (Should not accept an argument), I think you should take this patch into consideration.
> Thanks.
> 
> He Sun

Please resubmit this change in the proper format (as described by Eric
Sunshine WRT another one of your patches).  Also please remember to
distinguish between information that should go in the commit log
message, which will be stored permanently to the repository and help
future developers understand your change, vs. side notes meant only for
the mailing list.  For example, for the log message, stuff like:

    OPTION_CMDMODE should be used when ... So change the mode to
    OPTION_CMDMODE so that ...

vs. for the mailing list discussion:

    When I was reading code yesterday ...

The former goes above the "---" line and the latter goes directly below it.

BTW, none of my comments should be taken to indicate whether the commit
itself makes sense or not.  I haven't checked that far.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
