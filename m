From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: version 0.91 of gitk out now
Date: Sun, 15 May 2005 17:40:45 +0200
Message-ID: <1116171645.15470.12.camel@dhcp-188.off.vrfy.org>
References: <17031.19069.345408.888580@cargo.ozlabs.ibm.com>
	 <200505151045.23198.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 17:41:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXLEd-0000NE-GG
	for gcvg-git@gmane.org; Sun, 15 May 2005 17:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVEOPk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 11:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVEOPk6
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 11:40:58 -0400
Received: from soundwarez.org ([217.160.171.123]:25302 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261664AbVEOPkv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 11:40:51 -0400
Received: from dhcp-188.off.vrfy.org (d052217.adsl.hansenet.de [80.171.52.217])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 66B352C52;
	Sun, 15 May 2005 17:40:49 +0200 (CEST)
To: Gene Heskett <gene.heskett@verizon.net>
In-Reply-To: <200505151045.23198.gene.heskett@verizon.net>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-05-15 at 10:45 -0400, Gene Heskett wrote:
> On Sunday 15 May 2005 09:11, Paul Mackerras wrote:
> >I have just put version 0.91 of gitk on ozlabs.org at:
> >
> > http://ozlabs.org/~paulus/gitk-0.91
> >
> >(that's the actual script, just wget it and run it).
> >
> Been lurking here, waiting for an announcement of a snapshot of this 
> new gismo.  I wgot it, and chmodded it to 0766, but got this when its

Funny mode mask! :)

> run:
> [root@coyote git]# ./gitk-0.91
> Error in startup script: can not find channel named "stder"
>     while executing
> "puts stder "Error executing git-rev-tree: $err""
>     invoked from within
> "if [catch {set commfd [open "|git-rev-tree $rargs" r]} err] {
>         puts stder "Error executing git-rev-tree: $err"

Yes, this should be stderr. But that's not your problem. :)

>         exit 1
>     }"
>     (procedure "getcommits" line 8)
>     invoked from within
> "getcommits $revtreeargs"
>     (file "./gitk-0.91" line 993)
> 
> Typu?

You miss the right git binaries. Is git-rev-tree in your $PATH? Do you
have the "new" git binaries starting with git-*?

Kay

