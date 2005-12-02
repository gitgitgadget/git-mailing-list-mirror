From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: git pull aborts in 50% of cases
Date: Fri, 2 Dec 2005 22:04:12 +0300
Message-ID: <20051202190412.GA10757@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 02 19:52:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiFyc-0003Tq-9x
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 19:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVLBStn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 13:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbVLBStn
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 13:49:43 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:62376 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750944AbVLBStm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 13:49:42 -0500
Received: by nproxy.gmail.com with SMTP id o25so215117nfa
        for <git@vger.kernel.org>; Fri, 02 Dec 2005 10:49:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=hv0utvlsiuGxt3vDQUvvQ9MGk1B1JTJ7M0GZiQqzIHQA7eIvr3jNBpDbTT+DKom7XbYORlKwwZ5YjKNTdeIwta/xYxEExgJ1hOfDSRj3qYan1+aUeW4uButscsgCygY7uFn7KmAU6/ECev17DFBBB0gQxfcYU3cJdAXYvHeaPhs=
Received: by 10.48.220.12 with SMTP id s12mr67972nfg;
        Fri, 02 Dec 2005 10:49:39 -0800 (PST)
Received: from gmail.com ( [217.10.38.130])
        by mx.gmail.com with ESMTP id k9sm893329nfc.2005.12.02.10.49.20;
        Fri, 02 Dec 2005 10:49:38 -0800 (PST)
Received: by gmail.com (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	adobriyan@gmail.com; Fri,  2 Dec 2005 22:04:25 +0300 (MSK)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13120>

$ git pull
Already up-to-date.
$ git pull
Already up-to-date.
$ git pull
Already up-to-date.
$ git pull
fatal: unexpected EOF
Fetch failure: git://git.kernel.org/pub/scm/git/git.git
$ git pull
fatal: unexpected EOF
Fetch failure: git://git.kernel.org/pub/scm/git/git.git
$ git pull
Already up-to-date.
$ git pull
fatal: unexpected EOF
Fetch failure: git://git.kernel.org/pub/scm/git/git.git
$ git pull
fatal: unexpected EOF
Fetch failure: git://git.kernel.org/pub/scm/git/git.git

Ditto for "git fetch --tags".

Can somebody explain what's going on?
