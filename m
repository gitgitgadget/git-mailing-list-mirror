From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [DOC] more explanation about --git-dir and --work-tree options
Date: Wed, 30 Apr 2008 06:30:04 +0900
Message-ID: <200804292130.m3TLUcxl026222@mi0.bluebottle.com>
References: <48162EF0.6050705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:31:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxQ7-0007yp-D6
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbYD2Vaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbYD2Vaj
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:30:39 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:56892 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbYD2Vai (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:30:38 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m3TLUcxl026222
	for <git@vger.kernel.org>; Tue, 29 Apr 2008 14:30:38 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=tw840Fl7Slxj7ttGTnr75twCirCjHbgbiafqdgH8JvQ2WoN4No6GSZRC8tl5SMen8
	1Q073BiUauOoTNUN065Q4RRCt6AvclfwIGbpKtVhvQeAeSANQEwRfoK98mjjBvO
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m3TLUQs9007661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 29 Apr 2008 14:30:35 -0700
In-reply-to: <48162EF0.6050705@gmail.com>
X-Trusted-Delivery: <05d24ccea8407ed29c10a2f334c94309>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80740>

Quoting Liu Yubao <yubao.liu@gmail.com>:

> I find these two options bring me surprise:
>
>    git init $HOME
>    git add ~/.vimrc ~/.gvimrc ~/.vim
>    cd $HOME/work/xxx
>    ....do some work, then change ~/.vimrc without changing
>        working directory
>    git --git-dir $HOME/.git status
>
> I use --git-dir because I have another .git in $HOME/work/xxx, the
> last command surprises me much, it tells me .vim* are all deleted!

The behavior at the end user level was outlined earlier in the message http://marc.info/?l=git&m=120390208721287&w=2

A later message http://marc.info/?l=git&m=120445414611494&w=2 proposed an implementation change and described how the various pieces appear to programmers but it was lost when the code was scrapped.

I think it is a good idea to add a documentation like this to at least describe the behavior visible by the end users.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Finally - A spam blocker that actually works.
http://www.bluebottle.com/tag/4
