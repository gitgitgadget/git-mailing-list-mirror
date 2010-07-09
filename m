From: Anirban Mitra <anirban.m@directi.com>
Subject: Re: Git stash bug
Date: Fri, 09 Jul 2010 17:45:16 +0530
Message-ID: <4C3712D4.8020909@directi.com>
References: <4C36B520.70105@directi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 14:31:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXCjx-0001Me-32
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 14:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755983Ab0GIMbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 08:31:31 -0400
Received: from smtp.directi.com ([122.182.1.139]:47623 "EHLO smtp.directi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755733Ab0GIMba (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 08:31:30 -0400
Received: from smtp.directi.com (localhost.localdomain [127.0.0.1])
	by smtp.directi.com (Postfix) with ESMTP id 2D58646D8536
	for <git@vger.kernel.org>; Fri,  9 Jul 2010 18:00:45 +0530 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=directi.com; h=
	message-id:date:from:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=coopa;
	 bh=p00iSciRQGizPGeZK51ZwXAvuaYQLYerA2pTiIsIeMA=; b=OCzyDgM+2aAO
	phVdLu+82R+X9R7FF0kcNlyt/CEeEeFVCG1PkUjP4wrj5Cn2qdg4cQRg0woGP5U6
	mvBbIlwl8YLEdfLkdqpCHu/hdWfSqY/cWAmf93xPgqgLBPfzNxaROiV4DvLJQOoi
	r8+hUm7HRMehfX0dsX+sMIg4PZI7pQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=directi.com; h=message-id
	:date:from:mime-version:to:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=coopa; b=fdVqx
	rSD4ZX5vcsOICOAXiO3SCUkY5c1un+x52wZSEw07Z2HyF832cPHI+Amu1+pN2mVT
	QoCQwHVlvkbtOK05izkhatUazN15/3wzcihGxcJEo6r+KWICMvn/LvYBOgjOOoWr
	X5Xqki7hUQjYZZWP4aNR5MS42mfau8nO/RWf5A=
Received: from [172.16.147.16] (unknown [172.16.147.16])
	by smtp.directi.com (Postfix) with ESMTPA id 834331A0D6D4
	for <git@vger.kernel.org>; Fri,  9 Jul 2010 17:45:16 +0530 (IST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10pre) Gecko/20100410 Shredder/3.0.5pre
In-Reply-To: <4C36B520.70105@directi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150656>

Hi,

Sorry for the last msg. It seems the behavior happened in a different 
situation then what I described which now I can't reproduce.

-- Anirban

On Friday 09 July 2010 11:05 AM, Anirban Mitra wrote:
> Hi,
>
> I ran into a git stash bug. I added a new project config file used by 
> the IDE in a commit and later reverted the commit. But the same file 
> again created by the IDE and now when I use git stash that file 
> changes are also stashed. When I try stash pop, it complains that the 
> file will be overwritten and aborts.
>
> I did not expect this because I have reverted the commit adding the 
> file. Is it intended behaviour? Am I missing something or is this a 
> known bug and will be fixed in later releases? I am using Git version 
> 1.7.0.4.
>
> -- Anirban
