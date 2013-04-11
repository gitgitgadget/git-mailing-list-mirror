From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Various typofixes
Date: Thu, 11 Apr 2013 17:43:03 -0400
Message-ID: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
References: <4cb23e38819d620f53be032d0765fbe374ddb717.1365712583.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 23:43:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQPGy-0007hw-NP
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 23:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109Ab3DKVnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 17:43:07 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:50806 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab3DKVnF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 17:43:05 -0400
Received: by mail-lb0-f173.google.com with SMTP id w20so2035282lbh.4
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 14:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=atGmJS5KEjotGVzICl7b7mHY1qAqLRVG67Fln3GbKqg=;
        b=zQ1WxKGfhG5KVJ7qNFHajRfD61xwB+CHdFjK+J34VrN99bC3auopxMy/7x6jMjQ7BX
         Bo46h9zJRfyKEArd4pK/EWAUFhmSLIoJctF2YWhBAC7AWyy6S5eB0d0mT7ijrPwP8Rp2
         2xBhSh+Z3xNhN9CgQirFACRQjx9BUcwTi/o351hkUloPtu1m23hutYD4RzXJkJi00+gV
         hG4EaS1JMzRiIajrWp2+Xvb1UYaqOMXO8VD5VzKopJvGY6JhTVuSz3dpCR+Ofx/QzMgs
         HvbWTufrePtNTUQ0z4fg6x0/TQwnImHigXX/E/A6MB0x3QZHnkXdwq76cdV7PF3/LtZ8
         Kr2A==
X-Received: by 10.112.132.40 with SMTP id or8mr4134331lbb.119.1365716583452;
 Thu, 11 Apr 2013 14:43:03 -0700 (PDT)
Received: by 10.114.174.104 with HTTP; Thu, 11 Apr 2013 14:43:03 -0700 (PDT)
In-Reply-To: <4cb23e38819d620f53be032d0765fbe374ddb717.1365712583.git.stefano.lattarini@gmail.com>
X-Google-Sender-Auth: ttE9vnUHGWNyVR_EEwL_UydpMrI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220934>

On Thu, Apr 11, 2013 at 4:55 PM, Stefano Lattarini
<stefano.lattarini@gmail.com> wrote:
> Mostly suggested by codespell <https://github.com/lucasdemarchi/codespell>
>
> Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
> ---
> diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
> index 8c96ed9..aab8153 100644
> --- a/compat/regex/regcomp.c
> +++ b/compat/regex/regcomp.c
> @@ -2095,7 +2095,7 @@ peek_token_bracket (re_token_t *token, re_string_t *input, reg_syntax_t syntax)
>
>  /* Entry point of the parser.
>     Parse the regular expression REGEXP and return the structure tree.
> -   If an error is occured, ERR is set by error code, and return NULL.
> +   If an error is occurred, ERR is set by error code, and return NULL.

Not new in this patch, but the grammar "error is occurred" is rather
poor. Since this is a cleanup patch, perhaps it makes sense to adjust
the grammar as well.

>     This function build the following tree, from regular expression <reg_exp>:
>            CAT
>            / \
> @@ -3715,7 +3715,7 @@ build_charclass_op (re_dfa_t *dfa, RE_TRANSLATE_TYPE trans,
>  /* This is intended for the expressions like "a{1,3}".
>     Fetch a number from `input', and return the number.
>     Return -1, if the number field is empty like "{,1}".
> -   Return -2, If an error is occured.  */
> +   Return -2, If an error is occurred.  */

Also not new with the patch: s/If/if/

Ditto regarding grammar.

> diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
> index 193854c..237642c 100644
> --- a/compat/regex/regex_internal.c
> +++ b/compat/regex/regex_internal.c
> @@ -1284,7 +1284,7 @@ re_node_set_merge (re_node_set *dest, const re_node_set *src)
>
>  /* Insert the new element ELEM to the re_node_set* SET.
>     SET should not already have ELEM.
> -   return -1 if an error is occured, return 1 otherwise.  */
> +   return -1 if an error is occurred, return 1 otherwise.  */

Ditto: grammar

>
>  static int
>  internal_function
> @@ -1341,7 +1341,7 @@ re_node_set_insert (re_node_set *set, int elem)
>
>  /* Insert the new element ELEM to the re_node_set* SET.
>     SET should not already have any element greater than or equal to ELEM.
> -   Return -1 if an error is occured, return 1 otherwise.  */
> +   Return -1 if an error is occurred, return 1 otherwise.  */

Grammar.

>  static int
>  internal_function
> @@ -1416,7 +1416,7 @@ re_node_set_remove_at (re_node_set *set, int idx)
>
>
>  /* Add the token TOKEN to dfa->nodes, and return the index of the token.
> -   Or return -1, if an error will be occured.  */
> +   Or return -1, if an error will be occurred.  */

Grammar.

> diff --git a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
> index b6405ce..e764ddc 100755
> --- a/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
> +++ b/contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh
> -test_expect_failure 'test of correct formating for file name begining with special character' '
> +test_expect_failure 'test of correct formating for file name beginning with special character' '

Missed by codespell: s/formating/formatting/

>         wiki_reset &&
>         git clone mediawiki::'"$WIKI_URL"' mw_dir_13 &&
>         (
> @@ -215,7 +215,7 @@ test_expect_failure 'test of correct formating for file name begining with speci

Ditto: s/formating/formatting/

>                 echo "my new file {char_1" >\{char_1.mw &&
>                 echo "my new file [char_2" >\[char_2.mw &&
>                 git add . &&
> -               git commit -am "commiting some exotic file name..." &&
> +               git commit -am "committing some exotic file name..." &&
>                 git push &&
>                 git pull
>         ) &&
> @@ -234,7 +234,7 @@ test_expect_success 'test of correct formating for file name from git to mw' '

s/formating/formatting/

>                 echo "my new file char{_1" >Char\{_1.mw &&
>                 echo "my new file char[_2" >Char\[_2.mw &&
>                 git add . &&
> -               git commit -m "commiting some exotic file name..." &&
> +               git commit -m "committing some exotic file name..." &&
>                 git push
>         ) &&
>         wiki_getallpage ref_page_14 &&
