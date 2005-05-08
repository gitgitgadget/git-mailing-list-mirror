From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: cg-log patches
Date: Sun, 8 May 2005 14:26:49 -0400 (EDT)
Message-ID: <1856.10.10.10.24.1115576809.squirrel@linux1>
References: <1742.10.10.10.24.1115573750.squirrel@linux1>
    <1115574136.9031.147.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Petr Baudis" <pasky@ucw.cz>,
	"GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 20:20:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUqNV-00047j-7d
	for gcvg-git@gmane.org; Sun, 08 May 2005 20:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbVEHS0v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 14:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbVEHS0v
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 14:26:51 -0400
Received: from simmts6.bellnexxia.net ([206.47.199.164]:46056 "EHLO
	simmts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262918AbVEHS0u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 14:26:50 -0400
Received: from linux1 ([69.156.111.46]) by simmts6-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050508182649.IXPR1834.simmts6-srv.bellnexxia.net@linux1>;
          Sun, 8 May 2005 14:26:49 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j48IQmha027136;
	Sun, 8 May 2005 14:26:49 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 8 May 2005 14:26:49 -0400 (EDT)
In-Reply-To: <1115574136.9031.147.camel@pegasus>
To: "Marcel Holtmann" <marcel@holtmann.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 8, 2005 1:42 pm, Marcel Holtmann said:

> why don't you use diffstat for it? I think that it is more handy then
> the list of modified files.

Hi Marcel,

Is a good idea, but would be a fair bit harder to generate unfortunately. 
Right now the blobs themselves don't have to be opened and inspected, just
the commit trees.   Actually, i'm not sure exactly how you'd even go about
generating a correct diffstat for commits that have multiple parents.

Sean


