From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH] t/t91XX-svn: start removing use of "git-" from these
	tests
Date: Mon, 8 Sep 2008 15:46:31 +0530
Message-ID: <20080908101631.GA6948@toroid.org>
References: <20080908190205.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 12:19:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcdqI-0004zs-O5
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 12:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbYIHKQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 06:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbYIHKQe
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 06:16:34 -0400
Received: from fugue.toroid.org ([85.10.196.113]:60586 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbYIHKQe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 06:16:34 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 8814055830B;
	Mon,  8 Sep 2008 12:16:32 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 58312388402; Mon,  8 Sep 2008 15:46:31 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <20080908190205.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95234>

At 2008-09-08 19:02:05 +0900, nanako3@lavabit.com wrote:
>
> This first step replaces literal strings "remotes/git-svn" and
> "git-svn-id" by introducing $remotes_git_svn and $git_svn_id
> constants defined as shell variables.

I'm sorry, but... why? I don't see the point at all. These are not even
commands; and, as someone who was just reading the svn tests, the change
certainly doesn't make them *easier* to follow.

-- ams
