From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 02:23:24 -0800 (PST)
Message-ID: <20060213102324.83478.qmail@web31809.mail.mud.yahoo.com>
References: <20060213095859.GA17115@ferdyx.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Feb 13 11:23:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8arg-0008Ow-Kq
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 11:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbWBMKX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 05:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWBMKX0
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 05:23:26 -0500
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:5491 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751752AbWBMKXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 05:23:25 -0500
Received: (qmail 83480 invoked by uid 60001); 13 Feb 2006 10:23:24 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Ie3hArD9IUUhiotngA8roiQsW6MiXMNa7Z7DYYYyryTT47uWMMzIwHZzLPwYLaIxU/71WsfpZgpmep/AcMVolO9RRspBVLC/GvQObGCtyBP6hyRyAs+ImGWnxEzSfLX//GFZKGzlCL3GpEpPXz4yXd5vv1/zI2fMZ/HNUGvSDaQ=  ;
Received: from [65.74.249.167] by web31809.mail.mud.yahoo.com via HTTP; Mon, 13 Feb 2006 02:23:24 PST
To: "Fernando J. Pereda" <ferdy@ferdyx.org>, git@vger.kernel.org
In-Reply-To: <20060213095859.GA17115@ferdyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16066>

--- "Fernando J. Pereda" <ferdy@ferdyx.org> wrote:

> On Mon, Feb 13, 2006 at 01:51:46AM -0800, Andrew Morton wrote:
> | Assuming I find the bad commit, how do I extract it as a patch?
> | 
> | I tried
> | 
> | git-format-patch -o ~/a 386093ef9a6c88576d8b418bf1c8616d5e410a20 git-netdev-all
> | 
> | and that chewed 10 minutes CPU time and produced no output, so I killed it.
> 
> This gives you the whole info about the commit, including a patch:
> 
> git cat-file commit 386093ef9a6c88576d8b418bf1c8616d5e410a20

I meant to say:

   git-diff-tree --pretty -p <commit_id>

Luben
