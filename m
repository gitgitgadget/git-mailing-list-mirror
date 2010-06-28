From: Eric Raible <raible@gmail.com>
Subject: Re: notify alternative to auto gc?
Date: Mon, 28 Jun 2010 18:58:59 +0000 (UTC)
Message-ID: <loom.20100628T205729-213@post.gmane.org>
References: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com> <AANLkTikjbu_q6QToVUeNAAL0Fls9eQ5BZkzZ1-8L93zh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 28 20:59:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTJY8-0008S9-Sj
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 20:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab0F1S7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 14:59:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:56830 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546Ab0F1S7N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 14:59:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OTJXw-0008M6-A4
	for git@vger.kernel.org; Mon, 28 Jun 2010 20:59:08 +0200
Received: from mail.nextest.com ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 20:59:08 +0200
Received: from raible by mail.nextest.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 20:59:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.70 Safari/533.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149849>

Chris Packham <judge.packham <at> gmail.com> writes:

> So a hook like
> 
>   #! /bin/sh
>   echo "repository needs git gc"
>   exit 1
> 
> Should cause the auto gc to be skipped.

Except wouldn't you also need a mechanism
to allow an explicit gc to actually proceed?
