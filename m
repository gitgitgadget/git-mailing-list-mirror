From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Recommended work flow with git to send in patches
Date: Tue, 27 Jul 2010 22:15:02 +0530
Message-ID: <20100727164500.GD5351@kytes>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
 <20100727153901.GA5351@kytes>
 <AANLkTinEQKuxHD6MbXq43E=AWymebvoWXM5v2Tm6vejw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tong Sun <suntong@cpan.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 18:46:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdnIs-0003on-W5
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 18:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772Ab0G0Qqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 12:46:49 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60089 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab0G0Qqs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 12:46:48 -0400
Received: by pwi5 with SMTP id 5so534965pwi.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=O4oNbBBrrlOPZxVCDu1uwr12YeHCIi+CflhZn5/P1dc=;
        b=KWIqIRO9Hy6Ex9mT6kecGDyksl000gBVPLOnxgCWevN/sWh4ENmdiSzWZqMDuqdkvc
         cj48Nz9v1Ka4jUp0YI7avSQWY1bnr8GTknvfdsZLRdC5dG+RmXSBrbbdlaHXPRJ0mvGc
         uuQI+DIm4u3GfiSYHm2Hs6Q6Tehv/qaKLRu2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mDGc5yl/9ZwdjqCu+F/7X1wgvGMyMN2EqRs8e4/rdyzHKc/JOvOACyFK8C0vpn8L6F
         Au94kwhqPQuhBN4qSJrrbkXJ22/OZpLfawtbdemtSokMQC+Zkg2L1DEp4bvZenfTHqhX
         wH0jemt29TTyeIJtmJqm1XUXWxYZuGdoUAOwQ=
Received: by 10.115.107.7 with SMTP id j7mr13896351wam.107.1280249207822;
        Tue, 27 Jul 2010 09:46:47 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id c24sm9172917wam.7.2010.07.27.09.46.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 09:46:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinEQKuxHD6MbXq43E=AWymebvoWXM5v2Tm6vejw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151954>

Hi Tong,

Tong Sun writes:
> Thanks a lot for the comment.
> 
> Could you elaborate it a bit with actual commands, starting from 'git
> pull git://remote/project master' please?

$ git symbolic-ref HEAD refs/heads/rollout
$ rm .git/index # Git recreates it automatically anyway
$ git add LICENSE
$ git commit -m "Add LICENSE" # root commit
$ # git add ... git commit cycle

-- Ram
