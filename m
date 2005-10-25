From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: How to clone faster via ssh ?
Date: Tue, 25 Oct 2005 14:54:35 +0700
Organization: AcademSoft Ltd.
Message-ID: <200510251454.35202.lan@ac-sw.com>
References: <200510251449.15302.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 25 09:56:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUJdq-0000I1-94
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 09:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbVJYHyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 03:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbVJYHyj
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 03:54:39 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:30086 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S932077AbVJYHyi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 03:54:38 -0400
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id 92E20BD35
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 14:54:37 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 804F68C3CF; Tue, 25 Oct 2005 14:54:37 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 93990F4F4
	for <git@vger.kernel.org>; Tue, 25 Oct 2005 14:54:35 +0700 (NOVST)
To: git@vger.kernel.org
User-Agent: KMail/1.6.2
In-Reply-To: <200510251449.15302.lan@ac-sw.com>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 2.64 (2004-01-11) on lan.ac-sw.lcl
X-Spam-Level: 
X-Spam-Status: No, hits=-4.8 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=2.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10572>

Forgot to tell:
clone via ssh was made using this command:
time git-clone -n ssh://lan@lan/home/lan/tmp/git/billing/repo r3
> When I do cloning via ssh it takes more than 10 minutes and horde of
> unpacked objects:
> Packing 204607 objects
> Unpacking 204607 objects
>  100% (204607/204607) done
>
> real    13m41.510s
> user    1m52.655s
> sys     1m5.057s
