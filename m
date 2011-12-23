From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: I can never finish a push
Date: Fri, 23 Dec 2011 15:39:10 +0100
Message-ID: <4EF4928E.4090306@viscovery.net>
References: <4EF47DF3.9080809@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin L Resnick <mresnick@bbn.com>
X-From: git-owner@vger.kernel.org Fri Dec 23 15:39:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re6HJ-0000a0-1v
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 15:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788Ab1LWOjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 09:39:16 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19993 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab1LWOjP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 09:39:15 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Re6H9-0007dn-Ju; Fri, 23 Dec 2011 15:39:11 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 492721660F;
	Fri, 23 Dec 2011 15:39:11 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EF47DF3.9080809@bbn.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187630>

Am 12/23/2011 14:11, schrieb Martin L Resnick:
> I'm working remotely over a VERY slow line.
> 
> When I do a push it starts out fine
> but after the 15 seconds it takes to push
> it fails with non-fast-forward merge.
> 
> So I pull (no merge needed, its fast-forward)
> and try push again. Fails again.
> 
> I can keep this up for hours on end;
> pushing, pulling, pushing, pulling.

Your statements can only make sense if the pushed branch generates a
"non-fast-forward" is not the same branch that you pull. Show a transcript
of your commands, and in particular also tell your setting of push.default.

-- Hannes
