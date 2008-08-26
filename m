From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK,GIT-GUI,DOCS) 1/7] gitk: Allow overriding the default commit.
Date: Tue, 26 Aug 2008 20:13:16 +1000
Message-ID: <18611.55100.873867.377208@cargo.ozlabs.ibm.com>
References: <200808231225.12596.angavrilov@gmail.com>
	<200808231227.45013.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 13:17:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXwXr-0001g2-5x
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 13:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbYHZLQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 07:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757597AbYHZLQA
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 07:16:00 -0400
Received: from ozlabs.org ([203.10.76.45]:47033 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757075AbYHZLP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 07:15:58 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 2CB5DDDF05; Tue, 26 Aug 2008 21:15:57 +1000 (EST)
In-Reply-To: <200808231227.45013.angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93734>

Alexander Gavrilov writes:

> Other GUI tools may occasionally need to start
> gitk and make it automatically select a certain
> commit. This patch supports doing it using a new
> command-line option.

Thanks, applied, with some edits to the description.

Could you have used the existing pending_select for this?  Was there a
reason not to use it?

Paul.
