From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] fix "git-submodule add a/b/c/repository"
Date: Sun, 06 Jul 2008 15:05:38 -0400
Message-ID: <48711782.6090609@gmail.com>
References: <20080701150025.GD5852@joyeux> <7vd4lro7ct.fsf@gitster.siamese.dyndns.org> <20080706161101.GB23385@jhaampe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Sylvain Joyeux <sylvain.joyeux@dfki.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 21:08:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFZb1-0002Bz-8L
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 21:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbYGFTFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 15:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753567AbYGFTFv
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 15:05:51 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:15383 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbYGFTFu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 15:05:50 -0400
Received: by yw-out-2324.google.com with SMTP id 9so857380ywe.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=GLZ7biwU46yUJSOXcZ5sN+HSVXZg17PPZWiDQTLP71k=;
        b=BwTo2A5uLvzBXgw8Cg03WP1HfpT4PFKGQb+uth2jRyi5UDZK6E0l70zSRlJ2Yacx8f
         BxNmlLHjlQ8VX3/5YNExw+tpWoXSOn6pEfyJdSpFECUx/DGK2USeEwrBx3Yc5xn+usaL
         WZJQtUaIy7X6s3U3+5Qp1eHc/aiOBugFktLLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=lNXBp3cgXeQ/cl+Dof5/INO9VFVkQSLmWb61Jgdwnu/nlOL7ivLT23DgkXHUdBnuAB
         +rd1WJBMnHtyxmSd3JPPeh4DDAjbm30V9GoMLVgfGyg8uSaYICDWkHiKVq4d2r1Ap1hI
         WjgFgZky6WfTahQplN9P8TBjfvOWtkS59dOow=
Received: by 10.151.42.9 with SMTP id u9mr6567975ybj.170.1215371141474;
        Sun, 06 Jul 2008 12:05:41 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.246.235.165])
        by mx.google.com with ESMTPS id 6sm3976395ywn.0.2008.07.06.12.05.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jul 2008 12:05:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080706161101.GB23385@jhaampe.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87544>

Sylvain Joyeux wrote:
>  	git submodule add init dir0/dir1/init
>     
> Would clone dir0/dir1/init at ./init and add ./init as a submodule. This is
> actually what the current git-submodule (wrongly) does.
>
> Sylvain
>   
...after some prep work...

 >git submodule add init dir0/dir1/init
Adding existing repo at 'dir0/dir1/init' to the index

So, what's the problem?

Mark
