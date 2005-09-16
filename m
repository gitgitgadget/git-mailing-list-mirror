From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: Add uninstall target to Makefile
Date: Fri, 16 Sep 2005 15:19:55 -0400
Message-ID: <20050916191953.GD22825@tuxdriver.com>
References: <20050916125814.GA8084@igloo.ds.co.ug> <7vfys5ndor.fsf@assigned-by-dhcp.cox.net> <20050916175402.GC22825@tuxdriver.com> <20050916180810.GK8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Atukunda <matlads@dsmagic.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 21:26:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGLoi-000203-9X
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 21:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVIPTYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 15:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVIPTYJ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 15:24:09 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:65285 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751241AbVIPTYI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 15:24:08 -0400
Received: from bilbo.tuxdriver.com (azure.tuxdriver.com [24.172.12.5])
	by ra.tuxdriver.com (8.13.3/8.13.3) with ESMTP id j8GJJuwV024014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 16 Sep 2005 15:19:56 -0400
Received: from bilbo.tuxdriver.com (localhost.localdomain [127.0.0.1])
	by bilbo.tuxdriver.com (8.13.1/8.13.1) with ESMTP id j8GJJu1Q006263;
	Fri, 16 Sep 2005 15:19:56 -0400
Received: (from linville@localhost)
	by bilbo.tuxdriver.com (8.13.1/8.13.1/Submit) id j8GJJtTq006262;
	Fri, 16 Sep 2005 15:19:55 -0400
To: Chris Wright <chrisw@osdl.org>
Mail-Followup-To: Chris Wright <chrisw@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Martin Atukunda <matlads@dsmagic.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050916180810.GK8041@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4-gr0
X-Spam-Checker-Version: SpamAssassin 3.0.4-gr0 (2005-06-05) on 
	ra.tuxdriver.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8709>

On Fri, Sep 16, 2005 at 11:08:10AM -0700, Chris Wright wrote:

> Of course package manager will do better at this, but it is useful to be
> able to uninstall.  However, I don't think Martin's external script with
> all the filenames hardcoded is the right approach.  There are $(PROG)
> and $(SCRIPTS) which already know all these filenames.

I would agree with that.  Definitely better to use the same Makefile
vars used for install to do the uninstall.

John
-- 
John W. Linville
linville@tuxdriver.com
