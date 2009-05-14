From: Dan Loewenherz <dloewenherz@gmail.com>
Subject: Re: Eliminate redirection to stdout and stderr when quiet option
	is available
Date: Thu, 14 May 2009 03:48:37 -0400
Message-ID: <20090514074837.GA3676@andros.launchmodem.com>
References: <6f5a4e780905140013g75d85558tfaa3c85430f8a8a3@mail.gmail.com> <alpine.DEB.1.00.0905140934560.27348@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Loewenherz <daniel.loewenherz@yale.edu>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 14 09:48:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4VgQ-0003c3-3P
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 09:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756087AbZENHsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 03:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755659AbZENHsl
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 03:48:41 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:35012 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053AbZENHsk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 03:48:40 -0400
Received: by qw-out-2122.google.com with SMTP id 5so901144qwd.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=iPM57LojdzKbpM4cW09/k7PZbvCZdA6WBu8wamG5/tc=;
        b=bG/uFGB+fkVCiuA5wutrC3keeKdN+PfOcZI1f4hYRKLvTHnwajOefZf73QlDuAV+Ll
         q8SwoBRlLzm+jKGxVcYjT0flU8Y9C0T12affSUCmKBndPEUjGTxt8uXJHOk+0CllaZyl
         gCqCDtkSP4wXZ6fmqihJ9PEHq3CBHdjCQMacQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Uxhp72TO5hk+J6FUdVsUqaO3tQBtBPJlnprfr2XZqBE2oihT92FJO9Dk0waAA/uIx5
         86EdOnMSdkARy+D+Gr2t8Mu3c788sCXjV+qSx94AAdGgASMcxpwzzVr5lA6Jn73ljh5f
         319GVzY6HxQ3UYNhSzVUzmTrZhPFVHWtEMK7k=
Received: by 10.224.60.131 with SMTP id p3mr2375932qah.116.1242287321269;
        Thu, 14 May 2009 00:48:41 -0700 (PDT)
Received: from andros.launchmodem.com (adsl-065-006-168-015.sip.mia.bellsouth.net [65.6.168.15])
        by mx.google.com with ESMTPS id 6sm3198840yxg.0.2009.05.14.00.48.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 00:48:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0905140934560.27348@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119166>

On 14/05/09 09:35 +0200, Johannes Schindelin wrote:
> I like this patch, but I think that
> 
> 	git rev-parse -q HEAD
> 
> _does_ output a commit name...
> 

Thanks for pointing this out. I probably should have checked to see that 
the changes still gave the desired output (or lack thereof). I'll resubmit 
the patch.

Best,
Dan
