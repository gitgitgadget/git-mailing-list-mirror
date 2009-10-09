From: Matt Kraai <mkraai@beckman.com>
Subject: Re: [PATCH 1/8] imap-send: remove useless uid code
Date: Fri, 9 Oct 2009 15:46:50 +0000 (UTC)
Message-ID: <loom.20091009T174542-570@post.gmane.org>
References: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 17:56:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwHpY-0006pN-7b
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 17:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933693AbZJIPsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 11:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933518AbZJIPsO
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 11:48:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:59245 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932868AbZJIPsM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 11:48:12 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MwHgj-0001wL-1W
	for git@vger.kernel.org; Fri, 09 Oct 2009 17:47:33 +0200
Received: from 134.217.96.252 ([134.217.96.252])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 17:47:25 +0200
Received: from mkraai by 134.217.96.252 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 17:47:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 134.217.96.252 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.3) Gecko/20090824 Firefox/3.5.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129820>

Erik Faye-Lund <kusmabite <at> googlemail.com> writes:
> Presumably this is used in isync to be able to synchronize
> mailstores multiple times without duplication. But for
> imap-send, it the values are useless; we never do anything
> with them and simply forget them at the end of the program.

On the third line of this paragraph, "it" should be removed.
