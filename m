From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Teach git-remote to update existing remotes by fetching from them
Date: Tue, 20 Feb 2007 16:24:59 +0100
Message-ID: <200702201625.00841.jnareb@gmail.com>
References: <E1HIzh2-0001Ph-T2@candygram.thunk.org> <erc846$bk7$1@sea.gmane.org> <20070219201111.GA3407@steel.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 16:23:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJWpq-0007dk-Kx
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 16:23:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbXBTPXM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 10:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbXBTPXL
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 10:23:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:25226 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965048AbXBTPXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 10:23:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so812538uga
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 07:23:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KvRIFwyV6qTNehSVfvEWZWkU1SGBh4EPHj0lcYbAExZTm3bRHR0W1gw3fYnvOTEOy568tLzlfwzDtsRGqTvaYl7fFweUZ8BKp19nW1XTuzNuqtp+tAIc071IDJSh6eZLu/OZjqVl0pJ+tjRVGF388WUgZSmXCaVOCHdLC7ZlxvM=
Received: by 10.67.29.12 with SMTP id g12mr8310619ugj.1171984988331;
        Tue, 20 Feb 2007 07:23:08 -0800 (PST)
Received: from host-81-190-18-211.torun.mm.pl ( [81.190.18.211])
        by mx.google.com with ESMTP id 13sm8705645ugb.2007.02.20.07.23.05;
        Tue, 20 Feb 2007 07:23:07 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070219201111.GA3407@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40240>

Alex Riesen wrote:
> Jakub Narebski, Mon, Feb 19, 2007 14:21:01 +0100:
>>> 
>>> IOW: the fetch fails only if all fetches fail (with default
>>> being "fail = first").
>> 
>> Or just allow fetch remotes to have multiple URLs, and fetch from
>> all/try to fetch starting from first. 
> 
> How do you define which refs to get from which url?

I was thinking about "mirror" situation, so all URL would be the same
repository, and the same refs. On fetch, try to fetch starting from 
first, on push, push to all.

-- 
Jakub Narebski
Poland
