From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] Really *do* nothing in while loop
Date: Sun, 8 May 2005 13:18:40 +0200
Message-ID: <20050508111840.GB12436@cip.informatik.uni-erlangen.de>
References: <20050508093440.GA9873@cip.informatik.uni-erlangen.de> <427DE086.40307@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 08 13:12:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUjhR-0006RA-2h
	for gcvg-git@gmane.org; Sun, 08 May 2005 13:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVEHLSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 07:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVEHLSp
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 07:18:45 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:54459 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262838AbVEHLSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 07:18:42 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j48BIfS8019734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 8 May 2005 11:18:41 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j48BIf2l019733;
	Sun, 8 May 2005 13:18:41 +0200 (CEST)
To: LKML <linux-kernel@vger.kernel.org>, GIT <git@vger.kernel.org>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <427DE086.40307@tls.msk.ru>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> >-		/* nothing */
> >+		/* nothing */;

> Well, the lack of semicolon is wrong really (and funny).

yes, it is but harmless in this envrionment.

> But is the whole while loop needed at all?  deflate()
> consumes as much input as it can, producing as much output
> as it can.  So without the loop, and without updating the
> buffer pointers ({next,avail}_{in,out}) it will do just
> fine without the loop, and will return something != Z_OK
> on next iteration.  If this is to mean to flush output,
> it should be deflate(&stream, Z_FLUSH) or something.

I have no idea.

> P.S.  What's git@vger.kernel.org for ?

It is the list which handles GIT related discussions. Frontend/backend
and isn't kernel related.

	Thomas
