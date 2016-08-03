Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62212021F
	for <e@80x24.org>; Wed,  3 Aug 2016 00:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbcHCAuy (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 20:50:54 -0400
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:44096
	"EHLO s-opensource.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735AbcHCAuw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 20:50:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by s-opensource.com (Postfix) with ESMTP id 450A3A0E78;
	Wed,  3 Aug 2016 00:50:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osg.samsung.com
Received: from s-opensource.com ([127.0.0.1])
	by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G0kZYhTDeCve; Wed,  3 Aug 2016 00:50:13 +0000 (UTC)
Received: from recife.lan (unknown [187.113.3.185])
	by s-opensource.com (Postfix) with ESMTPSA id 379ABA0E61;
	Wed,  3 Aug 2016 00:50:12 +0000 (UTC)
Date:	Tue, 2 Aug 2016 21:50:06 -0300
From:	Mauro Carvalho Chehab <mchehab@s-opensource.com>
To:	Florian Mickler <florian@mickler.org>
Cc:	Joe Perches <joe@perches.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>
Subject: Re: get_maintainer.pl and .mailmap entries with more than 2
 addresses
Message-ID: <20160802215006.39462d7b@recife.lan>
In-Reply-To: <6A56763C-D795-4943-AFE9-8A53ECD61AF6@mickler.org>
References: <1470155781.3998.181.camel@perches.com>
	<6A56763C-D795-4943-AFE9-8A53ECD61AF6@mickler.org>
Organization: Samsung
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Em Wed, 03 Aug 2016 00:17:10 +0200
Florian Mickler <florian@mickler.org> escreveu:

> cc'd mchehab@s-opensource.com  (Mauro, is your kernel.org address up?)

Yes, my kernel.org address is up. Better to keep it as the canonical address,
as this is unlikely to change as it is not associated to an e-mail provider.

> 
>  Am Tue, 02 Aug 2016 09:36:21 -0700
> schrieb Joe Perches <joe@perches.com>:
> 
> > Hello Florian.
> > 
> > There is at least an oddity with get_maintainer handling of a
> > .mailmap entry form.
> > 
> > For instance:
> > 
> > Mauro's .mailmap entry is:
> > Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com>
> > <mchehab@infradead.org> <mchehab@redhat.com> <m.chehab@samsung.com>
> > <mchehab@osg.samsung.com> <mchehab@s-opensource.com>
> > 
> > Is this a valid form?
> > 
> > get_maintainer output for Mauro is:
> > 
> > $ ./scripts/get_maintainer.pl drivers/media/ -f
> > Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com>
> > <mchehab@infradead.org> <mchehab@redhat.com> <m.chehab@samsung.com>
> > <mchehab@osg.samsung.com> (maintainer:MEDIA INPUT INFRASTRUCTURE
> > (V4L/DVB))
> > 
> > I believe the Mauro's and Shuah's .mailmap entries are improper and
> > should be changed, but I'm not completely aware of git .mailmap
> > handling and the documentation seems weakly specified.
> >   
> 
> Hmm.. looking at Mauros last .mailmap commit it seems like your patch is
> ok for Mauro. 
> 
> Although <mywing81@gmail.com> and <mchehab@brturbo.com.br> are probably
> missing? (@Mauro) 

The mchehab@brturbo.com.br is indeed an old email that I used on my
first submissions.

I don't know a mywing81@gmail.com address... that looks really weird
on my eyes...

Hmm...

$ git log --author "mywing81@gmail.com"
commit fe8b671306c78a963934cb5d6e354178390b8c87
Author: Mauro Carvalho Chehab <mywing81@gmail.com>
Date:   Thu Sep 30 14:46:47 2010 -0300

    [media] saa7134: port Asus P7131 Hybrid to use the new rc-core
    
    The rc map table were corrected thanks to Giorgio input and tests.
    
    Reported-by: Giorgio Vazzana <mywing81@gmail.com>
    Tested-by: Giorgio Vazzana <mywing81@gmail.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>

I don't remember the dirty details about such patch anymore... too
many years ago. From the custody chain, I _suspect_ that Giorgio
proposed a patch to be applied against the saa7134 driver, but the 
remote controller map table was moved to a separate file about 7
months before such patch by those changesets:

6686fa6917ca V4L/DVB: Break Remote Controller keymaps into modules
77b7422d48cd V4L/DVB: ir-common: move IR tables from ir-keymaps.c to a separate file

I likely rewrote his patch against the new driver, but somehow
I mangled with the author name/email. In any case, mywing81@gmail.com
should not be associated with me.
 
> <snip console research ... >
> $ git shortlog | grep "^Mauro C"
> Mauro Carvalho Chehab (4404):
> $ git log | grep "^Author:.*Mauro Carvalho Chehab" | sort | uniq -c
>       2 Author: Mauro Carvalho Chehab <maurochehab@gmail.com>
>     146 Author: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
>     645 Author: Mauro Carvalho Chehab <mchehab@infradead.org>
>     794 Author: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
>    2015 Author: Mauro Carvalho Chehab <mchehab@redhat.com>
>     448 Author: Mauro Carvalho Chehab <m.chehab@samsung.com>
>     353 Author: Mauro Carvalho Chehab <mchehab@s-opensource.com>

All above are my e-mails. Let's point them all to mchehab@kernel.org.

>       1 Author: Mauro Carvalho Chehab <mywing81@gmail.com>

This one is mangled and doesn't belong to me. So, it shouldn't be
at the .mailmap file.

> </snip>
> 
> 
> Anyway, from a technical viewpoint your patches seem to fix
> the .mailmap entry as the author intended. (See Junio's Email for the
> documantation part) 
> But I would wait for the ack from Mauro and Shuah. 

With the above changes,

Acked-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>


Thanks,
Mauro
