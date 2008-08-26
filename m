From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK,GIT-GUI,DOCS) 2/7] gitk: Support calling git gui blame from gitk.
Date: Tue, 26 Aug 2008 20:27:39 +1000
Message-ID: <18611.55963.306938.896762@cargo.ozlabs.ibm.com>
References: <200808231225.12596.angavrilov@gmail.com>
	<200808231227.45013.angavrilov@gmail.com>
	<200808231229.09191.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 13:17:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXwXq-0001g2-G2
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 13:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356AbYHZLP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 07:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757504AbYHZLP7
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 07:15:59 -0400
Received: from ozlabs.org ([203.10.76.45]:47036 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757125AbYHZLP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 07:15:58 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 307E4DDF03; Tue, 26 Aug 2008 21:15:56 +1000 (EST)
In-Reply-To: <200808231229.09191.angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93735>

Alexander Gavrilov writes:

> Add a new item to the file list popup menu, that
> calls git gui blame for the selected file, starting
> with the first parent of the current commit.

Also applied, also with some edits to the description.

> +    $flist_menu add command -label [mc "Blame parent commit"] \
> +        -command {external_blame 1}

Why the parent commit rather than the current commit?

Paul.
