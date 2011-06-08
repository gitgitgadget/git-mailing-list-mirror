From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 08 Jun 2011 12:32:19 +0200
Message-ID: <4DEF4FB3.1020400@viscovery.net>
References: <20110608093648.GA19038@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jun 08 12:32:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUG3r-0000Xv-U9
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 12:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755025Ab1FHKc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 06:32:27 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33026 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab1FHKc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 06:32:26 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QUG3g-0006ar-A6; Wed, 08 Jun 2011 12:32:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id F3B5F1660F;
	Wed,  8 Jun 2011 12:32:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110608093648.GA19038@elte.hu>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175349>

Am 6/8/2011 11:36, schrieb Ingo Molnar:
> So for example when was 189d3c4a94 merged upstream?
> 
> The proper Git answer would be:
> 
>   $ git describe --contains 189d3c4a94
>   next-20080501~97
> 
> But the next-20080501 tag is useless, and i don't have linux-next as 
> HEAD, it's only a remote.
> ...
> But ... it would be much nicer if i could make 'git describe 
> --contains' work better.

$ git describe --contains --match 'v2.*' 189d3c4a94

-- Hannes
