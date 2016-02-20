From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v5 23/27] svn: learn ref-storage argument
Date: Sat, 20 Feb 2016 23:55:14 +0000
Message-ID: <20160220235514.GA2311@dcvr.yhbt.net>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
 <1455772670-21142-24-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 00:55:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXHNW-0005mp-C9
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 00:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbcBTXzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 18:55:17 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:44745 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885AbcBTXzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 18:55:16 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C237F20453;
	Sat, 20 Feb 2016 23:55:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1455772670-21142-24-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286793>

David Turner <dturner@twopensource.com> wrote:
> +++ b/git-svn.perl

> +		if (defined $_ref_storage) {
> +		    push @init_db, "--ref-storage=" . $_ref_storage;
> +		}

Minor nit: git-svn uses tabs for indentation.
Otherwise, if we go this route, consider it:

Signed-off-by: Eric Wong <normalperson@yhbt.net>

Thanks.

I would favor Shawn's RefTree or similar to reuse existing
code + commands and avoid the external dependency, though.
