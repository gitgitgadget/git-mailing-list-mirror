From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH V2 2/3] pretty.c: rename strbuf_wrap() function
Date: Tue, 7 Jun 2016 11:04:13 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606071103190.28610@virtualbox>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr> <20160606151340.22424-3-william.duclot@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	peff@peff.net, mh@glandium.org, gitster@pobox.com,
	Simon Rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: William Duclot <william.duclot@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 07 11:04:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bACwJ-00016d-LX
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 11:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbcFGJEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 05:04:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:57069 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932184AbcFGJEg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 05:04:36 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ls8Qd-1bbNpY2Dz5-013zBL; Tue, 07 Jun 2016 11:04:15
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160606151340.22424-3-william.duclot@ensimag.grenoble-inp.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:2ylvFtP5nNTg194vhr1FobZUV0CIGlxmECd9lZaKJ4WEHh3ZJYD
 iCaAnuHQi5c/cgrqqEQffBXTdkuKGhz8qyu+7LhAZHhzu+VLsuoiQOLr5nlVx3Dc9iCs9kQ
 uymQrbBHJQJ+rw01GjB04fxjt+cr6fqqkG16+p2xMGtveHgxGrQHoSPGKds7325lJJ3DYhx
 suVo+rRwTYbYTYcD6RmhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wtlywM4L4YY=:G9iivDaG3X155L+gmYSTPy
 sHVCo7IPiFuLiwkZKGmHv6dBfmUbtQnSIOfKgd6wFNFMp29VmBvMwBtRMczcqKJ87Jxp9THBd
 aRiDtF8/oMcbCnQFUi0LQlUqy9UgoYECtJADJfwZaDx1P/2VAV50ArP7ienRxZUlzf7HjWHdJ
 Jr9NblkM0Oxrql3C2y4j6l6JcnWPfAgsvFvUolq1RZkTwUbqnr4ywc5x4XjJVuB46ELXMLedf
 s6iBnSTVIaAORkBpha4Z7+FOvY4M57o4cDSU2hVrGIdwMbLZ+jN78ZRLOC2BuO7x3r6CAwF62
 29ut0TMY5WIx3hPhz3GFOE0HsojaeJXnWW4xG1ppbkBG8tJ9jCU2MIxTdMJouxI923wqMHB04
 JrBOea7jrzix4zfnV1ac/S8GgYZdMqmX8LzUaIfUAALnpZB5ShpZdYXPApfOETPIDbMIO9uuW
 sgWeHYqKnkTXXokuQA+/Fz5mMjCaIu4TnBYys+ZYjlse2AdOQO1V0ajBByHFCx+BlAudpWxTr
 yxCd5BrLxQs5PgWBxIM/7t/GAzT4e2yHuaK2JKFwPQzMqDp3Sht3fuKA7Ipeo68j5YOFUKyg9
 rFS6Pdqej2kEdYiXHP8yIZz3c/LyZ9njVhjg//jzNGurjYwcKzLTjJv+dcrhh5Yn8AGeXI6PM
 UosyFYDHuo4WzmJovuVZfdsqPt3/38mcPW29QdkPCSuBzPuU9plkHIn901G/73/xvdeQ3VXWV
 Spc2OBVVfTM24ZiaokxneTn645vb05Ok3Ko+TicUbVxyiPgh7zPKtNLZb8CpUPpmQdj4XySz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296620>

Hi William,

On Mon, 6 Jun 2016, William Duclot wrote:

> diff --git a/pretty.c b/pretty.c
> index 87c4497..2b9e89a 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -904,8 +904,8 @@ static void parse_commit_message(struct format_commit_context *c)
>  	c->commit_message_parsed = 1;
>  }
>  
> -static void strbuf_wrap(struct strbuf *sb, size_t pos,
> -			size_t width, size_t indent1, size_t indent2)
> +static void strbuf_wrap_message(struct strbuf *sb, size_t pos,
> +				size_t width, size_t indent1, size_t indent2)

A better name might be strbuf_wrap_at_column().

Ciao,
Johannes
