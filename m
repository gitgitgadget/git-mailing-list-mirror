From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 02/26] refs: make repack_without_refs and is_branch
 public
Date: Fri, 16 Oct 2015 08:34:41 +0200
Message-ID: <56209A81.1060706@alum.mit.edu>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com> <1444938410-2345-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 08:35:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmybR-0005nX-6F
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 08:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbbJPGex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 02:34:53 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51545 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751997AbbJPGew (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2015 02:34:52 -0400
X-AuditID: 12074411-f797e6d000007df3-25-56209a84d442
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 14.2A.32243.48A90265; Fri, 16 Oct 2015 02:34:44 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB262D.dip0.t-ipconnect.de [93.219.38.45])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9G6Yfao001759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 16 Oct 2015 02:34:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444938410-2345-3-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqNsySyHMoPc0s8X8TScYLbqudDNZ
	NPReYbb4N6HGgcVjwaZSj4uXlD0WPL/P7vF5k1wASxS3TVJiSVlwZnqevl0Cd8anxzeZCt4K
	VHy9Pp25gXEVbxcjB4eEgInEkWbvLkZOIFNM4sK99WxdjFwcQgKXGSVa3jazQDjnmCRWn9/N
	BFLFK6Atce31IlYQm0VAVeLpzU42EJtNQFdiUU8zWI2oQJDEiuUvGCHqBSVOznzCAmKLCDhI
	XN51lBnEZhbwlXjx5DmYLSwQLNG7+xHU5mZGiamr+sAGcQp4SOzfvZcJokFPYsf1X6wQtrxE
	89bZzBMYBWYh2TELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma6uVmluilppRu
	YoQEs+AOxhkn5Q4xCnAwKvHwMtgphAmxJpYVV+YeYpTkYFIS5T00CSjEl5SfUpmRWJwRX1Sa
	k1p8iFGCg1lJhLcrBijHm5JYWZValA+TkuZgURLn5Vui7ickkJ5YkpqdmlqQWgSTleHgUJLg
	/TgDqFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKvxxcBoBUnxAO1tAWnnLS5I
	zAWKQrSeYlSUEue9AJIQAElklObBjYWlqFeM4kBfCvOWzASq4gGmN7juV0CDmYAG7/kvCzK4
	JBEhJdXA2JBgPFfw5ZbDi8863U4W7posuXD7P3+r+1XbM09Iri6VPKnvya6wqeGh2N5u25cl
	B6z+d2v8ntZ02yEwlmXHqQ8zKvzvxqveEPC2XrOr8O82O2ezqkDLR5lPGFdKT/99 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279728>

On 10/15/2015 09:46 PM, David Turner wrote:
> is_branch was already non-static, but this patch declares it in the
> header.

The commit message no longer reflects the patch.

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  refs.c | 5 +++--
>  refs.h | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index fe71ea0..84abc82 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2816,8 +2816,9 @@ int pack_refs(unsigned int flags)
>  
>  /*
>   * Rewrite the packed-refs file, omitting any refs listed in
> - * 'refnames'. On error, leave packed-refs unchanged, write an error
> - * message to 'err', and return a nonzero value.
> + * 'refnames'. On error, packed-refs will be unchanged, the return
> + * value is nonzero, and a message about the error is written to the
> + * 'err' strbuf.

^^^ ?

It is preferable for docstrings to be written in imperative form, so in
my opinion this is a step backwards...

...literally. Your "new" version comes from an older version of Git; it
was changed in

    79e4d8a9b8 repack_without_refs(): make function private (2015-06-22)

to the imperative form.

Assuming you are using `git-format-patch` to prepare your patches, it is
always a good idea to read over the prepared email files before sending
them to the ML, to check for bloopers like this.

>   *
>   * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
>   */
> diff --git a/refs.h b/refs.h
> index 7367a7f..8408bef 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -237,6 +237,8 @@ int pack_refs(unsigned int flags);
>  int verify_refname_available(const char *newname, struct string_list *extra,
>  			     struct string_list *skip, struct strbuf *err);
>  
> +extern int is_branch(const char *refname);
> +
>  /*
>   * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
>   * REF_NODEREF: act on the ref directly, instead of dereferencing
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
