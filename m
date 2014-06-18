From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Update of unicode_width.h to Unicode Version 7.0
Date: Tue, 17 Jun 2014 17:58:21 -0700
Message-ID: <20140618005820.GR8557@google.com>
References: <53A09D58.4090806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 18 02:58:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx4Cu-0002BQ-TS
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 02:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756275AbaFRA60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2014 20:58:26 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:40876 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbaFRA6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 20:58:24 -0400
Received: by mail-pd0-f169.google.com with SMTP id g10so102673pdj.28
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 17:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Xrhi2pZIbwlX8Wg5ntkCqZLqH0pURZwzvD4hLnmCFHE=;
        b=Vy20NhYQXQl7LMvnUueT4EBWUw1vrw60pp7jsSxzdIJLdGkhNuF6s639mmYX+2Kon1
         Aq2Tw3NG47OOOOm5TG99dDSnnIQTHoccydJsYUOZ+6itfpe31rA9PvvEzVDvEEh7Mpfb
         K6SzzJiqxHavwvK5ArKOLliM+qTL5eSOMsAoqbcOZ752apF/OFPfFhElGHsExJoQPz09
         s0rNcIiN5nMEahde+5UP1Ht6dac1/NViEo4tWpC25WSbkKWlDElvikEPBre25WcEsyhd
         ZR8I/W0PlNTUy1Ivfl92FrOVoqPHHgY5oaIy1O/t1FEzS5GTiZs7/rJPFqm87SaKwwxm
         Iy1A==
X-Received: by 10.68.213.97 with SMTP id nr1mr35905708pbc.52.1403053104071;
        Tue, 17 Jun 2014 17:58:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pr8sm322675pbc.74.2014.06.17.17.58.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 17 Jun 2014 17:58:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53A09D58.4090806@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251963>

Torsten B=F6gershausen wrote:

> Unicode Version 7.0 was released yesterday.
> Run ./update_unicode.sh to update the zero_width table.
> Note: the double_width is unchanged.
>
> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
> ---
>  unicode_width.h | 49 ++++++++++++++++++++++++++++++++++++++++++-----=
--
>  1 file changed, 42 insertions(+), 7 deletions(-)

Thanks for noticing.

This is what I get when I run update_unicode.sh, too (verified
using 'git diff' against the result of applying this patch), so

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
