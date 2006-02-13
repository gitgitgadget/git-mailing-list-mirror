From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 02:22:25 -0800 (PST)
Message-ID: <20060213102225.24897.qmail@web31804.mail.mud.yahoo.com>
References: <20060213095859.GA17115@ferdyx.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Feb 13 11:22:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8aql-0008Bp-9O
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 11:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWBMKW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 05:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWBMKW2
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 05:22:28 -0500
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:17594 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751719AbWBMKW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 05:22:28 -0500
Received: (qmail 24899 invoked by uid 60001); 13 Feb 2006 10:22:25 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Z9kou87s4PSiAHtDUrOpJ1Bdq5dth/y0DRuA6cSfGg91u0aTCztr3EfZuyD73VPwJNPh4w9mHi7S5euvMGfJrqKnfVMOX4HwEQGMOv/5NOPNeXecJ3CWHC/KXvdELE3ambo9qrV4lWa44SqXyOk9qB5axBsqyobZ0DSEwQ3hzsQ=  ;
Received: from [65.74.249.167] by web31804.mail.mud.yahoo.com via HTTP; Mon, 13 Feb 2006 02:22:25 PST
To: "Fernando J. Pereda" <ferdy@ferdyx.org>, git@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060213095859.GA17115@ferdyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16065>

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

I personally like

   git-diff-file
