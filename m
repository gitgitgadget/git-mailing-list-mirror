From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: Re: [PATCH] Documentation: pruning recipe for destructive
 filter-branch
Date: Sat, 14 Feb 2009 02:51:15 +0100
Message-ID: <20090214025115.615119bf@perceptron>
References: <1234545279-23153-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 14 02:52:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY9i9-0008FY-15
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 02:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760872AbZBNBv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 20:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764358AbZBNBvY
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 20:51:24 -0500
Received: from zoidberg.org ([88.198.6.61]:57977 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764342AbZBNBvV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 20:51:21 -0500
Received: from perceptron (xdsl-78-34-186-86.netcologne.de [::ffff:78.34.186.86])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sat, 14 Feb 2009 02:51:18 +0100
  id 0042C1BE.49962396.000071F6
In-Reply-To: <1234545279-23153-1-git-send-email-trast@student.ethz.ch>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109796>

Hi,

On Fri, 13 Feb 2009 18:14:39 +0100, Thomas Rast <trast@student.ethz.ch>
wrote:

> Add a section about how to shrink a repository's size after running
> git-filter-branch to remove large blobs from history.

Good idea.

> +* Expire all reflogs with `git reflog expire \--expire=now \--all`.
> +
> +* Repack to remove packed objects with `git repack -ad`.
> +
> +* Prune unpacked unreferenced objects with `git prune \--expire=now`.

Is the --expire=now actually needed for prune? The way I read it
git-prune(1), it defaults to pruning everything anyway.

-Jan
