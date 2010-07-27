From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Recommended work flow with git to send in patches
Date: Tue, 27 Jul 2010 22:58:13 +0530
Message-ID: <20100727172811.GE5351@kytes>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
 <20100727153901.GA5351@kytes>
 <AANLkTinEQKuxHD6MbXq43E=AWymebvoWXM5v2Tm6vejw@mail.gmail.com>
 <20100727164500.GD5351@kytes>
 <m339v4luk2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tong Sun <suntong@cpan.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 19:30:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odnz2-00040R-Jz
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 19:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab0G0RaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 13:30:05 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56391 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab0G0RaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 13:30:00 -0400
Received: by pwi5 with SMTP id 5so556814pwi.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Cb6eM+YMFKB2Y5gcBY2+pyYtFXyo8APT1OmBOk1FyGw=;
        b=xM633IrRAeqzCaxf7WusQCHI13LoD/IOKvLHCNNa2eTb4/jxqnh6tuMwfKOKfvyHAD
         1QFXthrBLoavNa2yKiTnQGOfvJmr9K5XYznjTeiI2O+MrnGoNbdYsm6/f4Fssm9iL8Mj
         U6HukXXsYvrpjSotbxn/qa1z14NuBGhQ+cnT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YNOdaA9ySppPLp7eBepjEq0HS3Z7wckulyP461uaBiwVJhs4Kovs4JRzBJUSBCZS5p
         InVQHDxebngan+rHisFIfYjqBzg3S4C8jKRuAwxVe/lJ+2Jtw7ppMB+tafqHtma0Coiz
         opVNMppef3r6+fxmIq/g3Kd8XiW9W3yuN6E/k=
Received: by 10.142.164.14 with SMTP id m14mr10744332wfe.70.1280251799622;
        Tue, 27 Jul 2010 10:29:59 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id x18sm5909718wfd.20.2010.07.27.10.29.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 10:29:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m339v4luk2.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151960>

Hi Jakub,

Jakub Narebski writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> > $ git symbolic-ref HEAD refs/heads/rollout
> > $ rm .git/index # Git recreates it automatically anyway
> > $ git add LICENSE
> > $ git commit -m "Add LICENSE" # root commit
> > $ # git add ... git commit cycle
> 
> Ramkumar, in git 1.7.2 you can simply use "git checkout --orphan newbranch".

Thanks for pointing this out! I'm still using many plubming tools- I
ought to find out their equivalents in the new porcelain.

-- Ram
