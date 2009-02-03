From: david@lang.hm
Subject: Re: how to diff versions of a file
Date: Mon, 2 Feb 2009 22:08:44 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0902022206060.28633@asgard.lang.hm>
References: <1c5969370902022100h7c03bbb6h2d9f443f877d89ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Matt Graham <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 06:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUDUA-00046A-4T
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 06:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbZBCFEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 00:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbZBCFEo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 00:04:44 -0500
Received: from mail.lang.hm ([64.81.33.126]:40390 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959AbZBCFEo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 00:04:44 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n1354VO0010003;
	Mon, 2 Feb 2009 21:04:31 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <1c5969370902022100h7c03bbb6h2d9f443f877d89ec@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108147>

On Tue, 3 Feb 2009, Matt Graham wrote:

> Hi,
> I'm curious if there's a way to diff between 2 arbitrary versions of a file.
>
> For example, how can I see the diff between tree.c on HEAD and from 3
> edits (of tree.c) ago?
>
> I can do git log and then manually use commit names to do the diff,
> but I'm hoping there's a single command that will let me do that.

I don't think it's trivial

If you just wanted three commits ago you could do

git diff HEAD..HEAD^^^ tree.c

but three changes to tree.c ago I think you need to do multiple iterations 
of git blame to find out what commit was three edits ago.

after you have the commit for three edits ago you do
git diff HEAD..COMMITID tree.c

David Lang
