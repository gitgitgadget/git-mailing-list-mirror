From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH] compat/regex: fix typos in comments.
Date: Sun, 06 May 2012 17:07:21 +0200
Message-ID: <4FA693A9.20101@in.waw.pl>
References: <1336308300-4858-1-git-send-email-semtlenori@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: "Yi, EungJun" <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 17:07:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR33l-0008DB-IB
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 17:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048Ab2EFPHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 11:07:37 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35974 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672Ab2EFPHg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 11:07:36 -0400
Received: from ip-78-30-123-101.free.aero2.net.pl ([78.30.123.101])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SR33e-0004oC-Hw; Sun, 06 May 2012 17:07:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <1336308300-4858-1-git-send-email-semtlenori@gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197194>

On 05/06/2012 02:45 PM, Yi, EungJun wrote:
> From: "Yi, EungJun" <semtlenori@gmail.com>
> 
> occured => occurred
> 
> Signed-off-by: Yi, EungJun <semtlenori@gmail.com>
> ---
>  compat/regex/regcomp.c        |    4 ++--
>  compat/regex/regex_internal.c |    6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
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

Hi,
you might want to fix the grammatical errors instead:
"If an error occurs, ERR is set to the error code, and NULL is
returned.", or something like that, I haven't actually read the code.

Best,
Zbyszek

>     This function build the following tree, from regular expression <reg_exp>:
>  	   CAT
>  	   / \
> @@ -3715,7 +3715,7 @@ build_charclass_op (re_dfa_t *dfa, RE_TRANSLATE_TYPE trans,
>  /* This is intended for the expressions like "a{1,3}".
>     Fetch a number from `input', and return the number.
>     Return -1, if the number field is empty like "{,1}".
> -   Return -2, If an error is occured.  */
> +   Return -2, If an error is occurred.  */
>  
>  static int
>  fetch_number (re_string_t *input, re_token_t *token, reg_syntax_t syntax)
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
>  
>  static int
>  internal_function
> @@ -1341,7 +1341,7 @@ re_node_set_insert (re_node_set *set, int elem)
>  
>  /* Insert the new element ELEM to the re_node_set* SET.
>     SET should not already have any element greater than or equal to ELEM.
> -   Return -1 if an error is occured, return 1 otherwise.  */
> +   Return -1 if an error is occurred, return 1 otherwise.  */
>  
>  static int
>  internal_function
> @@ -1416,7 +1416,7 @@ re_node_set_remove_at (re_node_set *set, int idx)
>  
>  
>  /* Add the token TOKEN to dfa->nodes, and return the index of the token.
> -   Or return -1, if an error will be occured.  */
> +   Or return -1, if an error will be occurred.  */
>  
>  static int
>  internal_function
