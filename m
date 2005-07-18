From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: git, porcelain, darcs, and version 1.0
Date: Mon, 18 Jul 2005 16:28:26 -0400
Message-ID: <42DC10EA.4050502@gmail.com>
References: <7islyev5s4.fsf@lanthane.pps.jussieu.fr>	<42DB341D.6050506@gmail.com> <7id5pfx5ci.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: darcs-devel@darcs.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 18 22:33:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DucEb-0001EO-Fc
	for gcvg-git@gmane.org; Mon, 18 Jul 2005 22:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbVGRU27 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jul 2005 16:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVGRU27
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jul 2005 16:28:59 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:49242 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261694AbVGRU26 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jul 2005 16:28:58 -0400
Received: by zproxy.gmail.com with SMTP id i1so977440nzh
        for <git@vger.kernel.org>; Mon, 18 Jul 2005 13:28:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=a5qS0U4cltCcgjuDgfQFdYS0Nz0U62R+E+xjRl/ZJQxof3921gQu0Y4aYycDVJVeY1rkbgLyx17i+1yjIuBAiMaxu37y9q6pGnOS3s0JMTWUoM8BQzWdgqIs8StFXnI14xR/iBp6LwR6BqVAC5jHcIFtHTpLUIHkeik4FSS64Qs=
Received: by 10.36.221.76 with SMTP id t76mr3773143nzg;
        Mon, 18 Jul 2005 13:28:26 -0700 (PDT)
Received: from ?192.168.2.109? ([69.159.204.165])
        by mx.gmail.com with ESMTP id 39sm6462722nzk.2005.07.18.13.28.25;
        Mon, 18 Jul 2005 13:28:25 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
In-Reply-To: <7id5pfx5ci.fsf@lanthane.pps.jussieu.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


>>Darcs and git work together to determine the minimal amount
>>that needs to go into libgit1.so.
> 
> 
> Hold on...  Nobody is speaking about *binary* compatibility, it's
> source-level compatibility that we need.  There is absolutely no
> reason to introduce the complexities of shared libraries into the
> picture.
> 

Source level compatibility and stability is the big deal.  Compared to 
that, shared libraries are an implementation detail, in my opinion. 
Sometimes those details get "interesting", but they are soluble.

I could care less whether you use libgit.a or a libgit.so.  Just as long 
as distros or anybody else can update their darcs if a major data-loss 
bug is found in git.  A recompile is acceptable.  Dealing with the 
addition of a parameter to index_fd() is not.

Bryan
