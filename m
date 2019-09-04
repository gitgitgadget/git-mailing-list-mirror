Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E5CE1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 21:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfIDVnX (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 17:43:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:34169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfIDVnX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 17:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567633401;
        bh=/JUs2G34kQfSm1x5ZSQwvlCQq6+iT5QF0DAfiT+QvGA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QZ4KPwc9kqrJqN8se+I7WLVpVcXSckSAR6FQOPreUjYmiyfQZFw10k2aanPxazH7l
         NO/EnoHzD3BT39vOUHffhqa7VYW5MqEDTQv+FnB/721Zs07DJrTMxQMwnTktEZg2Jo
         t7s8uwxjQTkpZWlmE0dJUgMAGn9fn04xZPyRaJ0o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtEtL-1iHc1b3bMR-012lat; Wed, 04
 Sep 2019 23:43:20 +0200
Date:   Wed, 4 Sep 2019 23:43:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] compat/*.[ch]: remove extern from function declarations
 using spatch
In-Reply-To: <3c08556231576d8dfe496b87ae8cdcb87c00df24.1567595331.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1909042342220.5377@tvgsbejvaqbjf.bet>
References: <cover.1567595331.git.liu.denton@gmail.com> <3c08556231576d8dfe496b87ae8cdcb87c00df24.1567595331.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aS8dJJu1VYpbAgUWMNN9w8hdIwVHwRSEihA6wLATxqw6Y9WrQ8I
 vPwWPsZPY+eeB/jU/RazDnv1uhoQTcPzH9b/D3oKst02IX23NwrqMGJ4Fr6E4lE/p8TcjiT
 Sksfnl6wT+JRIPJixz2JRdQp19XJ1nvYwMM4rzQ6zx90wZ+z9ab/tstk2n60f6gKXHkCllt
 r+Wg+M1gijyqr1uQaaAxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8GPn9Kl9kJo=:Xk21vunY9XdwHjlyGpgRRj
 adK4Zm8LCDUqrkTy8N4JDNp67u3BrH8gpVtHSH/N4XXHlQgv/l/0aI3UwPhDRwi5g85vpBHmw
 QKsVTyCI7DgJPuX5rmpwtaXr0BQlqmD05rPd5OMUQmQ0ISmMk87IHQqO9lBpMksCjO1zYRP4q
 Q8fZOXT9pd2CTy1vfrHY+i8JiGof+QdZ/JWhUjrlOVEHrX1IJdYuS+L+boqQBa7VcudcRB2wO
 8ae5KmyhI/PyZp2lnW4Hnt3DJxD5Y6EQXUxD1NibPVuR+Wkh+xoSH0mm93QF1RHOA5mJjvji4
 OR6KJ/NKG98worul7Y6k95Aa9fI5p2S81zWfQOjvHi/monUp+suHiNWvALqRu7tDUTD18BVvn
 ogoxM9UB/7UDfB0VSGzCO5n6d+GJqtJi9+vbnw6/UhGhQmB31cLSUqMhQX6m2BiDNbOfh5DgC
 DfxIOBBtaaKDt7z0ztGFRKZmIrAF9OYdorI9OYqmrUS8/GRZ3jBb7seyYI9nq7ZdWFVIdRAb5
 CS9MSg7vwcJmvVXCxclDXhCHcPln476a7vnl5prV7O+MLY0sbvrjZ3jsLKx5KghxS3FXDpGi9
 hVdV3aNCcUcoA2XRLd6C5AMDyVeETGe5qZid0YjIIAFwj/bK6CpzWYfX4C05SPxl+WsJJEpFS
 m4pXdv1o/7bzAsKX9goUv9R7iSdIGCEXW8f98hZt2ghUek9hwyXKjqWKoP03Wb3f63jYo7j+l
 aBJTyckrrFRyCzq0LbpmHNUcpCt/2vx42aRHqg38ePqK/iwOHi4hMRelenaGFFtdj3Go3SCap
 WUCzxAvwIGej9zkoGZI2MmgHrC/QihpiVi2ftH38Jny2MoAo9JgksY+n08A8dW0WUB2pLhNug
 zB+sS6OhCtThOAI731nukawS+wX3nr5iCq8kwlmLvTCBs12WYo+xgf3PR4gT8AbGEIJOY7IrP
 3j0On7zMc5/27k7mB9yN13nLKVi46NkxtiTdEpJ1i8d/AyXZy5WyCH6+sJoCuzQhXHjWELAX7
 mqcNq1B6fkf3470XzrLau9PPEquKce6TuJjlCIM3D3vEuzTjuqfIqmzgXTM+YyNIwk97XbJXl
 PoXBhHvKt/yqZ656yfVuIH8mAfn+MdW/ZLXscwbVvHJ7yvwYGoZANmKRz+a3QVcZVmWEzlsfs
 iOyOFPJBVuZabix6oT+7R+O0Sndwv+UBrj/hLRxmoD5dtMZpRgVvE2HK0cmjsy4MHkCVvtiaX
 rHWXVmJ1DD8NCr8Yy
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wed, 4 Sep 2019, Denton Liu wrote:

> In 554544276a (*.[ch]: remove extern from function declarations using
> spatch, 2019-04-29), we removed externs from function declarations using
> spatch but we intentionally excluded files under compat/ since some are
> directly copied from an upstream and we should avoid churning them so
> that manually merging future updates will be simpler.
>
> In the last commit, we determined the files which taken from an upstream
> so we can exclude them and run spatch on the remainder.
>
> This was the Coccinelle patch used:
>
> 	@@
> 	type T;
> 	identifier f;
> 	@@
> 	- extern
> 	  T f(...);
>
> and it was run with:
>
> 	$ git ls-files compat/\*\*.{c,h} |
> 		xargs spatch --sp-file contrib/coccinelle/noextern.cocci --in-place
> 	$ git checkout -- \
> 		compat/regex/ \
> 		compat/inet_ntop.c \
> 		compat/inet_pton.c \
> 		compat/nedmalloc/ \
> 		compat/obstack.{c,h} \
> 		compat/poll/
>
> Coccinelle has some trouble dealing with `__attribute__` and varargs so
> we ran the following to ensure that no remaining changes were left
> behind:
>
> 	$ git ls-files compat/\*\*.{c,h} |
> 		xargs sed -i'' -e 's/^\(\s*\)extern \([^(]*([^*]\)/\1\2/'
> 	$ git checkout -- \
> 		compat/regex/ \
> 		compat/inet_ntop.c \
> 		compat/inet_pton.c \
> 		compat/nedmalloc/ \
> 		compat/obstack.{c,h} \
> 		compat/poll/

I wonder whether we want to make this part of the (slightly misnamed)
"Static Analysis" job in our CI.

>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  compat/mingw.h         | 6 +++---
>  compat/win32/pthread.h | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index a03e40e6e2..9ad204c57c 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -11,7 +11,7 @@ typedef _sigset_t sigset_t;
>  #undef _POSIX_THREAD_SAFE_FUNCTIONS
>  #endif
>
> -extern int mingw_core_config(const char *var, const char *value, void *=
cb);
> +int mingw_core_config(const char *var, const char *value, void *cb);
>  #define platform_core_config mingw_core_config
>
>  /*
> @@ -443,7 +443,7 @@ static inline void convert_slashes(char *path)
>  			*path =3D '/';
>  }
>  #define PATH_SEP ';'
> -extern char *mingw_query_user_email(void);
> +char *mingw_query_user_email(void);
>  #define query_user_email mingw_query_user_email
>  #if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VE=
R < 1800)
>  #define PRIuMAX "I64u"
> @@ -580,4 +580,4 @@ int main(int argc, const char **argv);
>  /*
>   * Used by Pthread API implementation for Windows
>   */
> -extern int err_win_to_posix(DWORD winerr);
> +int err_win_to_posix(DWORD winerr);
> diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
> index c6cb8dd219..f1cfe73de9 100644
> --- a/compat/win32/pthread.h
> +++ b/compat/win32/pthread.h
> @@ -50,7 +50,7 @@ typedef struct {
>  	DWORD tid;
>  } pthread_t;
>
> -extern int pthread_create(pthread_t *thread, const void *unused,
> +int pthread_create(pthread_t *thread, const void *unused,
>  			  void *(*start_routine)(void*), void *arg);
>
>  /*
> @@ -59,10 +59,10 @@ extern int pthread_create(pthread_t *thread, const v=
oid *unused,
>   */
>  #define pthread_join(a, b) win32_pthread_join(&(a), (b))
>
> -extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
> +int win32_pthread_join(pthread_t *thread, void **value_ptr);
>
>  #define pthread_equal(t1, t2) ((t1).tid =3D=3D (t2).tid)
> -extern pthread_t pthread_self(void);
> +pthread_t pthread_self(void);

ACK!

Thanks,
Dscho

>
>  static inline void NORETURN pthread_exit(void *ret)
>  {
> --
> 2.23.0.248.g3a9dd8fb08
>
>
