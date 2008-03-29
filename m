From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH] git-svn: remove redundant slashes from show-ignore
Date: Sat, 29 Mar 2008 16:47:46 -0700
Message-ID: <1206834466.6543.30.camel@brick>
References: <b762bfda0803291340ta70ee88k8d5d7c7e384e41e0@mail.gmail.com>
	 <20080329233717.GA16157@soma>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Mar 30 00:48:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfkme-0000Bt-KE
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 00:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbYC2Xrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 19:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbYC2Xrk
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 19:47:40 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:1118 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbYC2Xrj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 19:47:39 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1133337wah.23
        for <git@vger.kernel.org>; Sat, 29 Mar 2008 16:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=riQJyDgkEl5dqfTwoDls5TyP7gzv6oNNRYeg5eEJ6v0=;
        b=USi8dIArksPZ1ht5XzCzw9HlA9aTrj9ves/zITGMi3US4ksV2kNoI/K1U0BSmabSK9mO0/f/AbBsqFsWFBGZT/+mLv/0fm9yJHhp+K9jfq2Udfha/bUeJige05EmBbIUIfQ49XtjRnC3OHPHd8N2tZNnQSlNv402gMfDCGmkjWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ROm20x1/xW5kRXlbJicEFhF0mRadfrXxqnZ+8ubGJaRpKPIQwl471i/OHgjcmz18tOb9sR9TKrBCFOF7x6veQXdc1Pv2WoZyVfIMq8QkrkkKDV0dSlE2HuuCg/9o1jLGXUqG4jiRIupRfR5JTnXavOREz9C1oRa+orxK1A3wMD0=
Received: by 10.114.66.2 with SMTP id o2mr6836942waa.102.1206834459158;
        Sat, 29 Mar 2008 16:47:39 -0700 (PDT)
Received: from ?192.168.1.100? ( [216.19.190.48])
        by mx.google.com with ESMTPS id v38sm268379wah.7.2008.03.29.16.47.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Mar 2008 16:47:38 -0700 (PDT)
In-Reply-To: <20080329233717.GA16157@soma>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78492>

On Sat, 2008-03-29 at 16:37 -0700, Eric Wong wrote:
> Jonathan Scott Duff wrote:
> > Recently I tried "git svn showignore" on my parrot repository and it
> > failed.  I tracked it down to the prop_walk() sub.  When it recurses,
> > $path has an extra / on the beginning (i.e., when it recurses, it
> > tries to get the props for "//apps" instead of "/apps").   I *think*
> > this is because $path is used in the recursive call rather than $p
> > (which seems to contain a properly transformed $path).  Anyway, I've
> > attached a patch that works for me and I think is generally the right
> > thing.
> 
> Patch-submitted-by: Jonathan Scott Duff

Shouldn't that be Signed-off-by?

Cheers,

Harvey
