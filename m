From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: submodule add -f errs on un-ignored path
Date: Mon, 9 Jan 2012 16:40:33 +0100
Message-ID: <8739borij2.fsf@thomas.inf.ethz.ch>
References: <jeaip7$meo$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 16:40:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkHL2-0008IE-MD
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 16:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab2AIPki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 10:40:38 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:48588 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755721Ab2AIPkh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 10:40:37 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 9 Jan
 2012 16:40:32 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 9 Jan
 2012 16:40:33 +0100
In-Reply-To: <jeaip7$meo$1@dough.gmane.org> (Neal Kreitzinger's message of
	"Sat, 7 Jan 2012 16:59:50 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188173>

"Neal Kreitzinger" <neal@rsss.com> writes:

> $ git submodule add -f file:///home/me/super/Images.git WebPortal/Images
> Usage: git submodule [--quiet] add [-b branch] [--reference <repository>] [--] repository [<path>]

AFAICT this works since 1.7.2 (d27b876 to be precise).  Before that the
-f option didn't exist, and wasn't in the docs either.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
