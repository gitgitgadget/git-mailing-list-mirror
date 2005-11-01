From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 21:22:44 +0000
Message-ID: <b0943d9e0511011322q56812522v@mail.gmail.com>
References: <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
	 <7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
	 <20051031213616.GO11488@ca-server1.us.oracle.com>
	 <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
	 <20051031224246.GP11488@ca-server1.us.oracle.com>
	 <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz>
	 <20051101141149.GA26847@watt.suse.com>
	 <b0943d9e0511010929u22b33e4el@mail.gmail.com>
	 <20051101175905.GC26847@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 22:26:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX3ai-0006iA-Ga
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 22:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVKAVWp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 16:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVKAVWp
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 16:22:45 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:28917 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751191AbVKAVWo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 16:22:44 -0500
Received: by xproxy.gmail.com with SMTP id i30so1444770wxd
        for <git@vger.kernel.org>; Tue, 01 Nov 2005 13:22:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AJ/XqGD+SGFG9HMlypphBwu6+9s+q4NGTLvZsIqhUF67w6DT2Z6FhhYBJXxeB640YnFr7qMfu7MXGei/4g7k1Jl++/xZJ1cI1dVDqhq2Fm3km9j7hU5uRDA8lwO0b94TnFpHmvxzHpKnDt0pE8A75aPhWi9ICaJVCgQjbKTMsSI=
Received: by 10.70.53.17 with SMTP id b17mr2797577wxa;
        Tue, 01 Nov 2005 13:22:44 -0800 (PST)
Received: by 10.70.31.3 with HTTP; Tue, 1 Nov 2005 13:22:44 -0800 (PST)
To: Chris Mason <mason@suse.com>
In-Reply-To: <20051101175905.GC26847@watt.suse.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10956>

On 01/11/05, Chris Mason <mason@suse.com> wrote:
> The three way merge is still possible even if someone hand edits the
> patch.  For a three way merge, you just need to know the parent revision
> of the change you want to merge.  parent can mean the revision in the
> repository that precedes this patch (mq stores this information, just
> not in the patch), or it can mean any revision where the patch applies
> cleanly.

Yes, but what I meant is that someone may modify the patch in a way
that it is no longer appliable to its parent or to any other revision
in the tree. A this point, a three-way merge is no longer possible
(but, well, if someone modifies the patches this way should be able to
cope with the consequences).

> Both approaches (mq vs stgit) have advantages...you can get roughly the same
> functionality either way.

Yes, you are right. The big difference is the underlying tool (hg or git).

--
Catalin
