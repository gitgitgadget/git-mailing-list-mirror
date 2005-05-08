From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Make errors
Date: Sun, 8 May 2005 21:43:26 +0200
Message-ID: <20050508194326.GD6347@cip.informatik.uni-erlangen.de>
References: <1115580904.5536.28.camel@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 08 21:42:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUreX-00043H-3o
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVEHTpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbVEHTp3
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:45:29 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:48022 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262836AbVEHTn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 15:43:28 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j48JhRS8023822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 8 May 2005 19:43:27 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j48JhQ2L023821
	for git@vger.kernel.org; Sun, 8 May 2005 21:43:26 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1115580904.5536.28.camel@linux.site>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello John,

> http-pull.c:10:23: curl/curl.h: No such file or directory
> http-pull.c:11:23: curl/easy.h: No such file or directory
> http-pull.c:13: error: parse error before '*' token

Install curl + curl development package. Your compiler complains that it
can't find the header files for libcurl.

	Thomas
