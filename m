From: Nahor <nahor.j+gmane@gmail.com>
Subject: Re: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Tue, 23 Oct 2012 15:02:06 -0700
Message-ID: <508713DE.7040801@gmail.com>
References: <61a31f6bc61d4df322a097e32ba472390c583a81.1350923683.git.wking@tremily.us> <5086ED06.5020406@gmail.com> <5086FFDC.2050700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: wking@tremily.us
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 24 00:02:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQmYT-00032p-BX
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 00:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706Ab2JWWCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 18:02:20 -0400
Received: from plane.gmane.org ([80.91.229.3]:44099 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755673Ab2JWWCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 18:02:18 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TQmYI-0002ux-LX
	for git@vger.kernel.org; Wed, 24 Oct 2012 00:02:22 +0200
Received: from 173-167-111-189-sfba.hfc.comcastbusiness.net ([173.167.111.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 00:02:22 +0200
Received: from nahor.j+gmane by 173-167-111-189-sfba.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 00:02:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 173-167-111-189-sfba.hfc.comcastbusiness.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <5086FFDC.2050700@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208259>

On 2012-10-23 13:36, Jens Lehmann wrote:
> Am 23.10.2012 21:16, schrieb Nahor:
>> Last issue, the branch that exists in your local repository may not
 >> exist in someone else's repository, either because the branch is
 >> purely local, or because it has a different name on the remote repo.
>
> You'll always face this kind of problems with commits too when using
> submodules, so I don't see that as a problem here.

Commits can't change or disappear during "normal" git operation (i.e. 
without using "git push -f" or "git branch -D").
A commit also has the same id in all the clones repository so there is 
no issue of a different name between the local and the remote repositories.
