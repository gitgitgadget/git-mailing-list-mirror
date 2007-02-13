From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit "unknown user details" bug?
Date: Tue, 13 Feb 2007 22:31:41 +0000
Message-ID: <b0943d9e0702131431q2d5ab9bay9d7d0f0d1cd2af02@mail.gmail.com>
References: <200702130434.l1D4YmrA010122@freya.yggdrasil.com>
	 <b0943d9e0702130240x1822f882t4f0d1780647d98ad@mail.gmail.com>
	 <20070213183214.GU5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Adam J. Richter" <adam@yggdrasil.com>, git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 23:31:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH6Bh-0001oR-9l
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 23:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbXBMWbn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 17:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbXBMWbn
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 17:31:43 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:60804 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbXBMWbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 17:31:42 -0500
Received: by wr-out-0506.google.com with SMTP id i31so281367wra
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 14:31:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ltkOcLkUffpvsyn5kXzOaEFiTqtHri1LnJz34K7ZSNFgf91wSprLAt/y76m7FaTKJ3rW7tKijciqsaflTnDKLpwsyx1g0qz2YYnTKq/YAEP9NVnFQVIBd66iaR9HiPNEml7QnmV1O7H+B8/eAGz3DIAADX0YSRA7I8cOzx5Spzc=
Received: by 10.114.201.1 with SMTP id y1mr7234499waf.1171405901459;
        Tue, 13 Feb 2007 14:31:41 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Tue, 13 Feb 2007 14:31:41 -0800 (PST)
In-Reply-To: <20070213183214.GU5362@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39592>

On 13/02/07, Yann Dirson <ydirson@altern.org> wrote:
> BTW, I wondered why we need to store author and committer info in the
> patch dir.  Shouldn't the info from the Git commit be authoritative ?

The initial idea was to store them only if the user requested on the
command line. I later added the configuration file and they were
always set.

I pushed a patch that allows stgit to work with the git defaults if
there is no configuration available. Let me know if you find it OK so
we can close the bug.

BTW, we should get a 0.12.1 release out with some bug-fixes.

-- 
Catalin
