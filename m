From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-rev-list --merge-order hangs
Date: Wed, 8 Jun 2005 19:02:21 +1000
Message-ID: <2cfc4032050608020215152887@mail.gmail.com>
References: <42A69550.1030105@gorzow.mm.pl>
	 <2cfc4032050608002258e58897@mail.gmail.com>
	 <2cfc403205060800337e1ecca0@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Jun 08 11:01:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfwOP-0001d7-1M
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 10:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVFHJC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 05:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVFHJC0
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 05:02:26 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:6745 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262145AbVFHJCX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 05:02:23 -0400
Received: by rproxy.gmail.com with SMTP id i8so215990rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 02:02:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fqC3fGuj5+eh+irmMJc0DbW+Yo/9ilDwOiFE2kwtpUwo0qYvGrJsivDRefjz4vj4i/6x1XW4fCt0P51tkp42kRO2G643nNXtvKxH7F13cjFSSpuHg/lDQlIccIBWiHo0wzjKxySK7aNCkg+eFvceOHf0nQkAZoQ7ZNz9w8Kbdiw=
Received: by 10.38.104.24 with SMTP id b24mr3572235rnc;
        Wed, 08 Jun 2005 02:02:21 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 8 Jun 2005 02:02:21 -0700 (PDT)
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
In-Reply-To: <2cfc403205060800337e1ecca0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Actually, one case that I may not have considered properly is a commit
near the head that has no parents.

      git-rev-list --parents v2.6.12-rc6-astorm1 ^v2.6.12-rc6

should tell you if this case exists. Ideally such a case should not
occur, but that isn't a logical certainity, so I should handle it
better than I currently do.

Please let me know if this may explain your case. 

Regards,

jon.
