From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git rebase stops on empty commits
Date: Thu, 23 Jul 2009 07:08:12 +0900
Message-ID: <20090723070812.6117@nanako3.lavabit.com>
References: <33e2b2760907220022rbad30d7x255bcb63c5b8cc2f@mail.gmail.com>
	<loom.20090722T073645-17@post.gmane.org>
	<alpine.DEB.2.00.0907220907550.9220@ds9.cixit.se>
	<loom.20090722T120617-839@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Mark Blakeney <markb@berlios.de>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjzP-0006Nl-EO
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbZGVWIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZGVWIe
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:08:34 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35430 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753024AbZGVWId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:08:33 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 034F211B835;
	Wed, 22 Jul 2009 17:08:34 -0500 (CDT)
Received: from 2862.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 65JUIXEEHHZ2; Wed, 22 Jul 2009 17:08:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=pXLPZwC8fYh5ZmEiDEtXXKL9MUO+efj99Zdk1e9CNmyPfwXR7Hhw5S5oZarcA3klLIs4YxdiiDpwvT8gqsqVCM05XKf5XFU37evYDcxUu+lQzuJqjyeZao1c4le6Rdvf9JPa6R39T2AhxKkPliAzUUOoGIP36Aeno4/awj5WIlc=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <loom.20090722T120617-839@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123796>

Quoting Mark Blakeney <markb@berlios.de>

> Surely something like an option --allow-empty on the rebase -i to skip over
> these no-brainer picks is trivial to implement - and makes sense? As a simple
> user, and knowing the original commits required --allow-empty, it was the first
> option I went looking for on the rebase -i when I encountered this problem.

I think an alternative is to use 'git rebase --skip'. I don't understand why you can't get rid of the commits that don't do anything and serve no purpose once and for all.

In your first message you only said 'for various reasons' and it isn't clear why you need such empty commits. Often people say they want to add a comment about the state of the tree with empty commits, but tags are designed for that purpose. Unlike some other systems a tag can have a message of its own.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
