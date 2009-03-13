From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: newb: Given a commit id, find which branches have it as an ancestor
Date: Fri, 13 Mar 2009 08:14:45 +0100
Message-ID: <49BA07E5.2080701@viscovery.net>
References: <63BEA5E623E09F4D92233FB12A9F794302E0F9B2@emailmn.mqsoftware.com> <63BEA5E623E09F4D92233FB12A9F794302E0F9BA@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 08:16:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li1d0-0003jS-LE
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 08:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbZCMHO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 03:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756148AbZCMHOz
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 03:14:55 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:21751 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081AbZCMHOy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 03:14:54 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Li1bS-0003aA-3K; Fri, 13 Mar 2009 08:14:46 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D49406EF; Fri, 13 Mar 2009 08:14:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302E0F9BA@emailmn.mqsoftware.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113149>

Kelly F. Hickel schrieb:
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
>> Behalf Of Johannes Sixt
>> Sent: Thursday, March 12, 2009 10:38 AM
>> To: Kelly F. Hickel
> 
>> $ git branch -a --contains the-sha1
>>
>> -- Hannes
>>
> 
> Thanks, that looks like a really useful command.
> 
> Unfortunately, in this case it didn't print anything out (neither did
> "git branch -r -a sha1").
> 
> What I'm beginning to suspect is that all the commits that should have
> gone to master went to some unnamed branch.
> Is that reasonable/possible/likely?  This commit has a full ancestry,
> but doesn't appear to be on any branch.
> 
> In the above question there's an assumption that if a branch exists
> without a name, then git branch -a --contains wouldn't print anything
> out, is that correct?

Correct.

Your best bet is perhaps that you create a branch at the commit

  $ git branch tmp-branch your_sha1

so that the commits are not lost, then you cherry-pick them to master.

-- Hannes
