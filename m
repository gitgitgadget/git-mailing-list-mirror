From: "Joshua T. Corbin" <jcorbin@wunjo.org>
Subject: Re: [PATCH] cogito recursive cg-add and cg-rm
Date: Tue, 26 Apr 2005 09:21:36 -0400
Message-ID: <200504260921.36736.jcorbin@wunjo.org>
References: <200504260027.03451.jcorbin@wunjo.org> <20050426123901.GF18971@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 26 15:19:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQPxO-0008Fm-3n
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 15:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261511AbVDZNXg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 09:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVDZNXe
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 09:23:34 -0400
Received: from node1.wunjo.org ([64.62.190.230]:2229 "EHLO node1.wunjo.org")
	by vger.kernel.org with ESMTP id S261511AbVDZNX0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 09:23:26 -0400
Received: by node1.wunjo.org (Postfix, from userid 65534)
	id 5F6AF42EFF; Tue, 26 Apr 2005 09:23:23 -0400 (EDT)
Received: from [192.168.1.100] (24.238.44.109.res-cmts.tv13.ptd.net [24.238.44.109])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by node1.wunjo.org (Postfix) with ESMTP id 5356E42B74
	for <git@vger.kernel.org>; Tue, 26 Apr 2005 09:23:21 -0400 (EDT)
To: git@vger.kernel.org
User-Agent: KMail/1.8
In-Reply-To: <20050426123901.GF18971@pasky.ji.cz>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on node1
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=5.0 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 26 April 2005 08:39, Petr Baudis wrote:
> Dear diary, on Tue, Apr 26, 2005 at 06:27:02AM CEST, I got a letter
> where "Joshua T. Corbin" <jcorbin@wunjo.org> told me that...
>
> > This patch adds recursive addition and removal to cg-add and cg-rm,
> > recursion can be disabled with the -n switch.
> >
> > Signed-off-by: Joshua T. Corbin <jcorbin@wunjo.org>
>
> I'd actually prefer -r to explicitly turn the recursion on. That is more
> consistent with the rest of the UNIX world and I really don't feel
> comfortable with cg-rm recursing by default. ;-)
Hmm, I guess for it to work the way I was inteding would take a little more 
work; it should bail if any of the files are not in the repository or are 
locally modified.

> Also please use tabs for indentation.
Will do

-- 
Regards,
Joshua T. Corbin <jcorbin@wunjo.org>
