From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 5/6] gitopt: convert setup_revisions(), and diff_opt_parse()
Date: Tue, 9 May 2006 00:16:49 -0700
Message-ID: <20060509071649.GB4591@hand.yhbt.net>
References: <11471512121152-git-send-email-normalperson@yhbt.net> <11471512123005-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 09 09:16:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdMSj-0008Jn-Gj
	for gcvg-git@gmane.org; Tue, 09 May 2006 09:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWEIHQv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 03:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWEIHQu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 03:16:50 -0400
Received: from hand.yhbt.net ([66.150.188.102]:32223 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751440AbWEIHQu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 03:16:50 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id CB8122DC035; Tue,  9 May 2006 00:16:49 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11471512123005-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19826>

Eric Wong <normalperson@yhbt.net> wrote:
> I've added --raw to diff_opt_parse() for consistency's sake:
> --patch-with-raw would otherwise be inconsistently abbreviated
> to --raw if it wasn't added.

I was looking for this patch, but then I realized it slipped in here.

I've added --unified=<num>/-u<num> context here so I don't have to go
through the awkwardness of setting GIT_DIFF_OPTS in the environment.

-- 
Eric Wong
