From: "Eugine Kosenko" <eugine.kosenko@gmail.com>
Subject: Re: Repo cleanup problem
Date: Fri, 11 May 2007 12:32:13 +0300
Message-ID: <9909dee80705110232m5ef56517i542728ef8657971e@mail.gmail.com>
References: <9909dee80705110103h5b848490m296c001beecfa1f1@mail.gmail.com>
	 <vpqveezhjb0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 11:32:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmRU4-0008Ao-Qw
	for gcvg-git@gmane.org; Fri, 11 May 2007 11:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbXEKJcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 05:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbXEKJcP
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 05:32:15 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:43042 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbXEKJcO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 05:32:14 -0400
Received: by nz-out-0506.google.com with SMTP id o1so926969nzf
        for <git@vger.kernel.org>; Fri, 11 May 2007 02:32:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jc3pGX0SMqndSyhrGRskO6ns6nOZYf6u+V4gIxBtDvX1HTE1OmuasZUMw9EiXRckV/3aF1ohm3fO8IEakntqtQMYv3flUPoqSDvJt9smClZfYNR/tDHvidKXXARPPQ/xBrzPgIHuIquCTKG35Al158lki4ERq+xiFe0wLMOFSbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OUV3059nWmmsOi6IlX401XKOLW20KmLZdGUZMml/AgYcNIqKMNKB41X+sN3K6QwIl91wOJarNhF1MGXOkeibRS8lBc3A9Keu4O3xR5UP0GHq4K+5LXH/aykl94X8+peMA7MD4ARSHMBPTmyXK1S5YgMEDszRflvdASWRTOSl/5E=
Received: by 10.114.25.3 with SMTP id 3mr944428way.1178875933488;
        Fri, 11 May 2007 02:32:13 -0700 (PDT)
Received: by 10.114.210.5 with HTTP; Fri, 11 May 2007 02:32:13 -0700 (PDT)
In-Reply-To: <vpqveezhjb0.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46948>

2007/5/11, Matthieu Moy <Matthieu.Moy@imag.fr>:
> Branch before the garbage commit. Then, you can use git-rebase to
> replay the correct history on top of your new branch. Note that
> git-rebase will break merging if you already used merge: it does not
> "move" your old commits to your new branch, it instead creates new
> commits with the same changes at the old ones, in the new branch.
>
> That's probably what you've done already.

Almost that. Unfortunately, this simple way causes unexpected
conflicts, so I need also to do sometimes 'git-checkout <tag> .' and
recommit the changes to force the process.
