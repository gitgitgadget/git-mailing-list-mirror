From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v1 1/2] Remove 'git archimport'
Date: Fri, 9 May 2014 05:50:24 +0000
Message-ID: <20140509055024.GB30674@dcvr.yhbt.net>
References: <1399599203-13991-1-git-send-email-felipe.contreras@gmail.com>
 <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin@laptop.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 07:50:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WidhY-0001h3-Kx
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 07:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbaEIFuZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 01:50:25 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35881 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbaEIFuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 01:50:25 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A649A20945;
	Fri,  9 May 2014 05:50:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1399599203-13991-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248515>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> No updates since 2010, and no tests.

Who benefits from this removal?  Is this causing a maintenance
burden for Junio?

> Plus, foreign SCM tools should live out-of-tree anyway.

Even if so, there ought to be a transitionary period in case there are
any users.  We would need to warn potential users of its impending
removal in the documentation and at runtime.
