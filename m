From: Adam Monsen <haircut@gmail.com>
Subject: Re: ok to delete =?utf-8?b?dG1wX3BhY2s=?= file(s)? also, backing up a git repository
Date: Thu, 20 May 2010 02:55:56 +0000 (UTC)
Message-ID: <loom.20100520T044929-726@post.gmane.org>
References: <loom.20100520T010426-277@post.gmane.org> <alpine.LFD.2.00.1005191935400.12758@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 04:56:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEvvj-0000Eo-HG
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 04:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285Ab0ETC4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 22:56:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:50878 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181Ab0ETC4G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 22:56:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OEvvY-0000C7-O5
	for git@vger.kernel.org; Thu, 20 May 2010 04:56:05 +0200
Received: from c-67-183-136-182.hsd1.wa.comcast.net ([67.183.136.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 May 2010 04:56:04 +0200
Received: from haircut by c-67-183-136-182.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 May 2010 04:56:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.183.136.182 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3 ( .NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147357>

Nicolas Pitre writes:
> If you want your rsync backup to be fine, you need to follow some 
> ordering.

Ah, good to know! I don't want to complicate my backup job too much, so
I'll probably switch to a job that does the following for each repository,
daily (or so):

1) "git fetch": update bare clone
2) rsync backup "hooks/", "config", and "description".
I think that's all I've customized that I'd miss in a catastrophic failure.

Thanks for the tips.
