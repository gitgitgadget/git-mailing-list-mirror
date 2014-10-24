From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: clear global SVN pool between get_log
 invocations
Date: Fri, 24 Oct 2014 22:50:12 +0000
Message-ID: <20141024225012.GA31716@dcvr.yhbt.net>
References: <20141021033912.GA27462@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 25 00:50:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xhngb-0002Wn-Ub
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 00:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbaJXWuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 18:50:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36086 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085AbaJXWuO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 18:50:14 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F03E81FB0B;
	Fri, 24 Oct 2014 22:50:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20141021033912.GA27462@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <normalperson@yhbt.net> wrote:
> +				SVN::Core->gpool->clear;

Unfortunately, SVN::Core->gpool is not available in older SVN,
but I'm cooking a better patch which saves even more memory.
