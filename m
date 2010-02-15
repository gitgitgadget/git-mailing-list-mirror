From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC PATCH 3/6] filter-branch: invoke post-rewrite hook
Date: Mon, 15 Feb 2010 21:36:05 +0100
Message-ID: <4B79B035.2080604@kdbg.org>
References: <cover.1266164150.git.trast@student.ethz.ch> <0ad4b8c1a5377d697513cd8e49f64419cd8deef4.1266164150.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:36:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh7g2-0004nu-6Q
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 21:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668Ab0BOUgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 15:36:13 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:29919 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754070Ab0BOUgN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 15:36:13 -0500
Received: from [77.119.192.246] (77.119.192.246.wireless.dyn.drei.com [77.119.192.246])
	by bsmtp.bon.at (Postfix) with ESMTP id F11792C400C;
	Mon, 15 Feb 2010 21:36:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <0ad4b8c1a5377d697513cd8e49f64419cd8deef4.1266164150.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140028>

Thomas Rast schrieb:
> +if test -x "$GIT_DIR"/hooks/post-rewrite &&
> +	test -s "$workdir"/../rewritten; then
> +	"$GIT_DIR"/hooks/post-rewrite filter-branch < "$workdir"/../rewritten
> +fi

This sounds extra-strange. As if filter-branch is used 20 times a day. If 
the intent is to carry notes over to new commits, then filter-branch 
should grow a --notes-filter instruction, no? With an easily accessible 
copy-everything mode like --tagname-filter=cat.

-- Hannes
