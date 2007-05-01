From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: svn:externals using git submodules
Date: Tue, 1 May 2007 20:48:01 +0100
Message-ID: <200705012048.04817.andyparkins@gmail.com>
References: <200705011121.17172.andyparkins@gmail.com> <200705011936.14345.andyparkins@gmail.com> <20070501191703.GA25287@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Chris Shoemaker <c.shoemaker@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 21:48:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiyKl-000878-0t
	for gcvg-git@gmane.org; Tue, 01 May 2007 21:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbXEATsT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 15:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbXEATsT
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 15:48:19 -0400
Received: from nz-out-0506.google.com ([64.233.162.230]:49909 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbXEATsS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 15:48:18 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2321827nzf
        for <git@vger.kernel.org>; Tue, 01 May 2007 12:48:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WC2k3NsQNHaACvBowSOeyBBj8dpgeKAeXp0w7eysJgeuOF5PrWlAeHGytAVJ+MvuKCacAlGD4dfCe2VE/UsoOAzeQ3WbPhM2ZDeZ0b6VQaHlDjM895n0hJzSsvuHyBod4IZIajJP+ldhAPI7YmVSgqsLu9aZ4UJ6a8+zCr2l6hM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tb2+2WUbOkD8rapN/LLawinLZTdkvjY48UHefuIfLyraFn4lRLW4bdNREDmlRCT8wSgQ8Clb9QOCkusYOQADEpPVCuVx8yP2Tbodba+1bqi4od6TsatV++8Vdd50Md2adk8pbu0o4pqTlhAwzCBIpxcZPgcz/UMroSVSg7dRWQE=
Received: by 10.65.113.17 with SMTP id q17mr2448057qbm.1178048897460;
        Tue, 01 May 2007 12:48:17 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id y7sm1393293ugc.2007.05.01.12.48.15;
        Tue, 01 May 2007 12:48:16 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <20070501191703.GA25287@pe.Belkin>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45974>

On Tuesday 2007, May 01, Chris Shoemaker wrote:

> That's only true when the revision is not specified in the external.
> The repo you track may not do that, but it's not uncommon to do so.

It's been a while since I used subversion, and even longer since I used 
externals - is that a new feature?  I used subversion since before 
version 1.0, so I often missed new features when they arrived. 

> And, as I think you're pointing out, it's the only way to get any
> sort of reliable information about the relationship between the
> parent and the external.

Does subversion automatically update that fixed attachment when you 
update the submodule?  I would have found that quite useful back then.

> I think it would probably be undesirable for git-svn to attempt to
> convert "floating" externals into well-versioned submodules, since
> they're not even well-versioned in the svn repo.  However, handling
> the "locked-down" externals is quite another thing.

Absolutely.  If the information is available, then git is certainly 
capable of recording it.  It sounds like subversion has a facility I 
didn't know exist, so I've been bad mouthing it more than I should.  Oh 
well :-)



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
