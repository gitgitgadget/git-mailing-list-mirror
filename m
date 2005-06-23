From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git testsuite failures
Date: Thu, 23 Jun 2005 10:54:01 +1000
Message-ID: <2cfc403205062217546434c869@mail.gmail.com>
References: <20050622.121835.78708158.davem@davemloft.net>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 02:47:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlFsm-0007So-Hw
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 02:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVFWAyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 20:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVFWAyE
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 20:54:04 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:3768 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261331AbVFWAyB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2005 20:54:01 -0400
Received: by rproxy.gmail.com with SMTP id i8so173457rne
        for <git@vger.kernel.org>; Wed, 22 Jun 2005 17:54:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PG/+SV9e3yJi+S1ciz+0l4lJ0QdFBukCrVkwzuCBGgT56Ekjf8rG/oh9byMlJHNhijfKEX93RQlDYQHwzTyU8WxSGOJmwhw1HkRXBsTT5iCdyboWPwND+GnWqG1O6qKD19id7WnDzMiVgbHj9YPW9LsXvbA2IQbvgWH+n+ndL0I=
Received: by 10.38.150.60 with SMTP id x60mr502306rnd;
        Wed, 22 Jun 2005 17:54:01 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Wed, 22 Jun 2005 17:54:01 -0700 (PDT)
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050622.121835.78708158.davem@davemloft.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I posted a fix for this yesterday. The break was caused by a change in
behaviour of parse_commit that the --merge-order stuff was dependent
on. Now that parse_commit is sane, the --merge-order stuff needs to be
made sane too.

The fix was in this patch.

[PATCH 1/1] Fix --merge-order unit test breaks introduced by
6c88be169881c9223532796bd225e79afaa115e1

jon.
