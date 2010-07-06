From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: messages confusing
Date: Tue, 6 Jul 2010 10:58:44 +0200
Message-ID: <20100706085844.GB13054@vidovic>
References: <20100706053543.GA13054@vidovic>
 <7v630t5dvo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 11:06:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW46D-0005E0-Pj
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 11:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040Ab0GFJFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 05:05:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45237 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753914Ab0GFJFf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 05:05:35 -0400
Received: by fxm14 with SMTP id 14so4509608fxm.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=s6QzAH2XnUlaylLunDEIIad+xbxSwSF4j8zK1glGHvE=;
        b=xDl18gXau5u0Ux5WStyETSh5D6Uk10fCQgVSEBislrFKt1oSlQhIxFAGwAp49XBeFO
         /YHM9YbJDyEW7lSTN7aryDyDeO4TH8RK1ZmbHT35lK/D022CDjYWbMGFFhO3Cp9/Xw5V
         yf9UaZjvs9lt+lITbUkn+usQ1RmH/4tF5Mjr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DrhDOW1EjPoIG25g3X5pjPwSEsKZUsADW0Gy1Xp1oa53sRdY7JaYCqditTwx6Z+irB
         EwRmZM75Y/xgqJtGC5g1ME/J3IaWFjm0OEBlC6ucqB/Io6ZiRsLLFJvWFTZgkCW1+qCx
         LZzhUQYAbugCN63jMCuUee5sMnwzlfdHK30+k=
Received: by 10.223.115.194 with SMTP id j2mr3729926faq.60.1278406732414;
        Tue, 06 Jul 2010 01:58:52 -0700 (PDT)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id z11sm6963296fam.2.2010.07.06.01.58.48
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 01:58:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v630t5dvo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150337>

The 05/07/10, Junio C Hamano wrote:
> 
> This is quite an old message; I don't think it has much to do with 1.7-ness
> of your version.
> 
> The first "uptodate" refers to your tree state being up-to-date.  You
> already had the necessary changes the other history wanted you to
> have---they were acquired in your history before you started this merge by
> some other means.  Perhaps merging from other trees, or picking up
> equivalent patches from mailing list, etc.

This is what I was guessing but wanted to be sure that the resulting
messages were intended as is.

> A merge commit is still created in this case, in order to record the fact
> that everything origin/master wanted to do to your history has already
> been reconciled to your history.  Otherwise "git log ..origin/master" will
> still show commits your history does not have.

Thanks for the explanations.

-- 
Nicolas Sebrecht
