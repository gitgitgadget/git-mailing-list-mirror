From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How change e-mail to use google's gmail instead of machine's prompt?
Date: Sat, 23 Feb 2008 15:02:44 -0800 (PST)
Message-ID: <m363wfcm3v.fsf@localhost.localdomain>
References: <998d0e4a0802231444t1632ed97r102cefdfe4d3990d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J.C. Pizarro" <jcpiza@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 00:03:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT3Ov-00069t-A9
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 00:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565AbYBWXCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 18:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbYBWXCu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 18:02:50 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:29879 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754534AbYBWXCt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 18:02:49 -0500
Received: by fg-out-1718.google.com with SMTP id e21so713047fga.17
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 15:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=HYvMFinaVus2ptnW/ZC9Fyjdi8Vzz/vwFSUHHsq43ug=;
        b=t/lCJDSPsTzxdzaQe/f2tSoJ9FfhDhLW3l/CSt4CCWSa39/PsQAQ8/qyeExxn7+0b52eswjaGcFv9QmkHCubTGQoVLJvWh9j7O6KCs+JV/HeX+d3+Rhb1PfCn/VXgqNSoKkQx9SOJJMVTQ3iWvRcd3QCCCRGY90Rek6IZFoX7x8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=nojONTVyz4xIgtiUClzGV7mhKoJj238xpNOCycVtiiTq0zJO/NqSRwS4of/8932uQ3wEjAZLkJiKkkwO+mSYPiTi4ouW4rxyPgaiiIyjX8rql+cULKTHDa3fDPyVsZ6FJq9O6/+lxvE8Ax4k7f8HoI7YuGIclFfDKsT/80d3VIE=
Received: by 10.82.146.10 with SMTP id t10mr1834412bud.8.1203807766268;
        Sat, 23 Feb 2008 15:02:46 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.83])
        by mx.google.com with ESMTPS id y37sm5350913iky.7.2008.02.23.15.02.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Feb 2008 15:02:44 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1NN2jRt017137;
	Sun, 24 Feb 2008 00:02:45 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1NN2iPK017134;
	Sun, 24 Feb 2008 00:02:44 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <998d0e4a0802231444t1632ed97r102cefdfe4d3990d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74877>

"J.C. Pizarro" <jcpiza@gmail.com> writes:

> Hello, my short prompt in the console of my machine is
> +---------------------------+
> | net1@pc0:~$               |
> +---------------------------+

> How can change it to use my own email jcpiza@gmail.com instead of my
> machine?

RTFM!!!

Edit your .gitconfig file in your home directory, adding

[user]
        name  = J.C. Pizarro
        email = jcpiza@gmail.com

or, if you prefer to use CLI utils:
$ git config --global user.email jcpiza@gmail.com

>  I loved the old Internet but i hate the new Internet services-based when
>  Internet is controlled by companies and governments for that you can't do
>  anything because it's controlled by them instead of by your.
> 
>    #;)

WTF?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
