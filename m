From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Recommended work flow with git to send in patches
Date: Tue, 27 Jul 2010 10:11:38 -0700 (PDT)
Message-ID: <m339v4luk2.fsf@localhost.localdomain>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
	<20100727153901.GA5351@kytes>
	<AANLkTinEQKuxHD6MbXq43E=AWymebvoWXM5v2Tm6vejw@mail.gmail.com>
	<20100727164500.GD5351@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tong Sun <suntong@cpan.org>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 19:11:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odngx-0001mq-MI
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 19:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365Ab0G0RLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 13:11:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51805 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab0G0RLl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 13:11:41 -0400
Received: by fxm14 with SMTP id 14so772577fxm.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 10:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=JqtNm+qFPwr31pppf76syZA7nLiDMrN7pKVA9pr1INk=;
        b=MHLYmODyhZc9uBA4ORKH8Kqgs4JHu7ZpudDaCtEp8q/dW0F0kZPGuvV5OLqpU+5i11
         3rmqqFdlyZl1x4AbQJVZl2Tez6sacVEjU9q/j6Wd3Lai6axHHze5GmAeOusUQfJlmSg4
         jQH9Nh2iByvfiK1jt4gqJsI1vBSk4u63Gf+xc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Z6a/39oWGFF3Dl9hJxsHyylMORWgSSY8iv+d3XNBuyyzX1VNGeAehRzlKloeWb2/m7
         CBomwrBlSZDX62EJLQAIUs0n5+1oX/leUy0dP6RpoFopGbuWuXtE0MKz8/hPkALxCReo
         tt84hIMbgbdpeqXTCzrfjDrc0ziWe+MPVRJmY=
Received: by 10.223.111.206 with SMTP id t14mr8411874fap.32.1280250698392;
        Tue, 27 Jul 2010 10:11:38 -0700 (PDT)
Received: from localhost.localdomain (abvi50.neoplus.adsl.tpnet.pl [83.8.206.50])
        by mx.google.com with ESMTPS id c5sm2060555fac.19.2010.07.27.10.11.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 10:11:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6RHAuHZ000300;
	Tue, 27 Jul 2010 19:11:06 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6RHAcS7032757;
	Tue, 27 Jul 2010 19:10:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100727164500.GD5351@kytes>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151959>

Ramkumar Ramachandra <artagnon@gmail.com> writes:
> Tong Sun writes:
> > Thanks a lot for the comment.
> > 
> > Could you elaborate it a bit with actual commands, starting from 'git
> > pull git://remote/project master' please?
> 
> $ git symbolic-ref HEAD refs/heads/rollout
> $ rm .git/index # Git recreates it automatically anyway
> $ git add LICENSE
> $ git commit -m "Add LICENSE" # root commit
> $ # git add ... git commit cycle

Ramkumar, in git 1.7.2 you can simply use "git checkout --orphan newbranch".

-- 
Jakub Narebski
Poland
ShadeHawk on #git
