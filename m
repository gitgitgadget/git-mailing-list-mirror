From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: How to extract files out of a "git bundle", no matter what?
Date: Fri, 19 Dec 2008 14:57:35 -0500
Message-ID: <494BFCAF.9060703@verizon.net>
References: <87iqpgc6bn.fsf@jidanni.org> <20081219193256.GU32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 20:59:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDlUv-0000pW-3Q
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 20:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbYLST5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 14:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbYLST5i
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 14:57:38 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:63623 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYLST5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 14:57:38 -0500
Received: from [127.0.0.1] ([71.126.132.240]) by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KC500BWF3FZQ260@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 19 Dec 2008 13:57:37 -0600 (CST)
In-reply-to: <20081219193256.GU32487@spearce.org>
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103577>

Shawn O. Pearce wrote:
>
> If the bundle requires 0 refs (like above) then you can init a
> new repository and should be able to fetch from it:
>
> 	git init
> 	git pull bundle.bdl master
>
>   

With relatively recent git (not sure the version), you can just do

    git clone bundle.bdl

Mark
