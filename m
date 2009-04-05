From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] revision.h: add includes of "diff.h" and "commit.h"
Date: Sun, 05 Apr 2009 16:28:41 +0900
Message-ID: <20090405162841.6117@nanako3.lavabit.com>
References: <20090404214554.75ada117.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 09:34:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqMs4-0005P6-88
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 09:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235AbZDEHct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 03:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757074AbZDEHct
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 03:32:49 -0400
Received: from karen.lavabit.com ([72.249.41.33]:33414 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756063AbZDEHcs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 03:32:48 -0400
Received: from h.earth.lavabit.com (h.earth.lavabit.com [192.168.111.17])
	by karen.lavabit.com (Postfix) with ESMTP id BDC6811B89D;
	Sun,  5 Apr 2009 02:32:46 -0500 (CDT)
Received: from 9524.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id BPRUQPL2JHD2; Sun, 05 Apr 2009 02:32:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=UNxFRvq+HTeNQsey1dPW0q6TnI3ku75lsYxtF+G9gWY6B/5AOUZ8rj5u0F/Gii+dgFezBYWrTktZyIxGWxdqtvYfJnAlIj9zWhNd+h47L1IakJcHXeVnZyQS5PEi4t35h//kzUuO5b3D9WUURgEQsG3tGuvuJZOFvFDdIAcRKhw=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090404214554.75ada117.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115638>

Quoting Christian Couder <chriscool@tuxfamily.org>:

> Because they are needed by some features included in
> "revision.h".
>
> This makes the following just work:
>
>         $ cat >1.c <<\EOF
>         #include "cache.h"
>         #include "revision.h"
>         EOF
>         $ cc -Wall -DSHA1_HEADER='<openssl/sha.h>' -c 1.c

I'm sorry if this is obvious to experienced people, but I don't understand what benefit there is to make such an empty program compilable.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
