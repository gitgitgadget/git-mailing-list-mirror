From: Kris Shannon <kris.shannon.kernel@gmail.com>
Subject: RT[3/3]: Reverse lookup of SHA1 references
Date: Thu, 28 Apr 2005 23:54:35 +1000
Message-ID: <5d4799ae05042806544683b4c9@mail.gmail.com>
References: <5d4799ae0504280559109cd00e@mail.gmail.com>
Reply-To: Kris Shannon <kris.shannon.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Apr 28 15:50:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR9OG-0006kY-1s
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 15:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVD1Nym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 09:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVD1Nym
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 09:54:42 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:18075 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262138AbVD1Nyg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 09:54:36 -0400
Received: by zproxy.gmail.com with SMTP id 13so474296nzp
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 06:54:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PC6LQJx7arDyXlXVOFwZNoNeC4CtKF8M146r+hW0gXPC4L14S7FbGGbNT9nJ275fuQIAY2QZczrwNt7DVAR/XgdGOZHv7fOve4GdQKuOgBRE3TfSJ9nYSnddPSkiVc48+aoTnzNVMMfF/Aml7yq9u4j9I3oIIjAnGaNmRMh65Sg=
Received: by 10.36.58.12 with SMTP id g12mr97865nza;
        Thu, 28 Apr 2005 06:54:35 -0700 (PDT)
Received: by 10.36.4.16 with HTTP; Thu, 28 Apr 2005 06:54:35 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>
In-Reply-To: <5d4799ae0504280559109cd00e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

There are a number of places where you want to find all the objects
which reference this particular object. AIUI this is not currently an easy
task. Some thought should be put into how to make these reverse
lookups fast.

The other two random thoughts would benefit greatly from a relationship
cache.

Umm.... I was going to write some more,  but I've gotta go :(

More thoughts later...

-- 
Kris Shannon <kris.shannon.kernel@gmail.com>
