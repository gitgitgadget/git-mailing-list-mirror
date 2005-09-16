From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add uninstall target to Makefile
Date: Fri, 16 Sep 2005 16:05:39 -0700
Message-ID: <7vu0gkfwak.fsf@assigned-by-dhcp.cox.net>
References: <20050916125814.GA8084@igloo.ds.co.ug>
	<7vfys5ndor.fsf@assigned-by-dhcp.cox.net>
	<20050916175402.GC22825@tuxdriver.com>
	<20050916180810.GK8041@shell0.pdx.osdl.net>
	<20050916191953.GD22825@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Atukunda <matlads@dsmagic.com>,
	Chris Wright <chrisw@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 01:07:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGPH9-0003Nz-N5
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 01:05:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVIPXFm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 19:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVIPXFm
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 19:05:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56811 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750762AbVIPXFl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 19:05:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916230541.QXNR3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 19:05:41 -0400
To: "John W. Linville" <linville@tuxdriver.com>
In-Reply-To: <20050916191953.GD22825@tuxdriver.com> (John W. Linville's
	message of "Fri, 16 Sep 2005 15:19:55 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8742>

"John W. Linville" <linville@tuxdriver.com> writes:

> On Fri, Sep 16, 2005 at 11:08:10AM -0700, Chris Wright wrote:
>
>> Of course package manager will do better at this, but it is useful to be
>> able to uninstall.  However, I don't think Martin's external script with
>> all the filenames hardcoded is the right approach.  There are $(PROG)
>> and $(SCRIPTS) which already know all these filenames.
>
> I would agree with that.  Definitely better to use the same Makefile
> vars used for install to do the uninstall.

True.  That is something I could live with.
