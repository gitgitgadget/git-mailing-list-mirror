From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] builtin-branch: improve output when displaying remote
 branches
Date: Fri, 13 Feb 2009 08:37:19 +0100
Message-ID: <4995232F.1090206@viscovery.net>
References: <7vhc30qki2.fsf@gitster.siamese.dyndns.org> <1234503271-78569-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 08:39:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXsdU-0007FO-50
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 08:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118AbZBMHh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 02:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754167AbZBMHh1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 02:37:27 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:19778 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbZBMHh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 02:37:26 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LXsbv-0006pL-LY; Fri, 13 Feb 2009 08:37:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6050769F; Fri, 13 Feb 2009 08:37:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1234503271-78569-1-git-send-email-jaysoffian@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109721>

Jay Soffian schrieb:
> $ git branch -av
>   foo                     -> master
> * master                  51cecb2 initial
>   rather-long-branch-name 51cecb2 initial
>   remotes/frotz/HEAD      -> frotz/master
>   remotes/frotz/master    e1d8130 added file2
>   remotes/origin/HEAD     -> origin/master
>   remotes/origin/WTF      -> refs/heads/master
>   remotes/origin/master   e1d8130 added file2

Just in case there's another iteration of this patch, I'd like to see
example output like this one (or even more of them) in the commit message
(perhaps WTF renamed to something else ;).

Thanks,
-- Hannes
