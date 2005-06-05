From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] git-rev-list --merge-order resynched with Linus' head
Date: Sun, 5 Jun 2005 17:33:59 +1000
Message-ID: <2cfc4032050605003345e624da@mail.gmail.com>
References: <20050605072336.14283.qmail@blackcubes.dyndns.org>
	 <2cfc403205060500323de294dc@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Jun 05 09:31:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Depae-00079m-91
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 09:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVFEHeA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 03:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVFEHeA
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 03:34:00 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:319 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261505AbVFEHd7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 03:33:59 -0400
Received: by rproxy.gmail.com with SMTP id i8so1491177rne
        for <git@vger.kernel.org>; Sun, 05 Jun 2005 00:33:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pfhkm1o3wnKmzH2645sMvPZ06DJK2OpT5Mja8d0j8u9UKQ1XS6zE7/UttJYGF3MNYJDJW7EgUzT6FhM0JzPaAjQhLmQdiL6ISsNvsp9TcRAqQC+1EvvAN9yQ3zGw6XS69sYuRUKwj8vd+RAxxy3BDdFh9RuiIKRbHmIU7nMdFmQ=
Received: by 10.38.104.33 with SMTP id b33mr1167734rnc;
        Sun, 05 Jun 2005 00:33:59 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Sun, 5 Jun 2005 00:33:59 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc403205060500323de294dc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This latest revision of my merge-order patch adds support for
git-rev-list arguments of the form:
 
     git-rev-list --merge-order a b c ^x ^y ^z
 
 I believe the output is functionally equivalent to the existing
algorithm, though sorted differently. Please let me know if you find a
case where this is not so.
 
 jon.
