From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: How do I...
Date: Fri, 6 May 2005 11:59:04 +0200
Message-ID: <20050506095904.GC11506@cip.informatik.uni-erlangen.de>
References: <427B3DB3.4000507@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 06 11:53:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTzVb-0007OS-3Q
	for gcvg-git@gmane.org; Fri, 06 May 2005 11:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVEFJ7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 05:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVEFJ7J
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 05:59:09 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:58552 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261194AbVEFJ7G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 05:59:06 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j469x4S8022190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 6 May 2005 09:59:05 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j469x40S022189
	for git@vger.kernel.org; Fri, 6 May 2005 11:59:04 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <427B3DB3.4000507@tuxrocks.com>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

hello,

> How can I git a list of commits that have modified a particular file?

You have to parse the git-rev-list and look at every single commit. But
I think cogito as well as jit have a command to obtain that.

> How can I output a list of the filename(s) modified by a particular
> commit? (for example)

A commit is only a pointer to a tree, so you can't. But you can see what
files have changed between a parent (note: there are up to 16) and the
dir which is associated with the commit:

git-diff-tree <child> <parent>

So calling git-diff-tree for every parent should do what you want.

	Thomas
