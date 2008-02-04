From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 0 of 7] [resend] - Improve handling remotes, origin, submodules
Date: Sun, 03 Feb 2008 22:52:33 -0500
Message-ID: <47A68C01.9000600@gmail.com>
References: <1202059867-1184-1-git-send-email-mlevedahl@gmail.com> <alpine.LSU.1.00.0802032237320.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 04:53:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLsOY-0007cv-Ry
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 04:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbYBDDwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 22:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbYBDDwl
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 22:52:41 -0500
Received: from ag-out-0708.google.com ([72.14.246.248]:52869 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbYBDDwk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 22:52:40 -0500
Received: by ag-out-0708.google.com with SMTP id 35so881402aga.10
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 19:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=8K7BcwaQ512gdM+q/ozLpu96VzEMzw59045nyRVghus=;
        b=BUSZ1h0mWZzsD0TMgYhHI6i+cjQ2sgn134WlSTG8dXGjm6gIeGjMqS1Q3g6Fm3eMMoLBHdOiCimcPRD/HNJOzjpDFdLFF24OeXD3zTn6O2qkPyRnVOSdp4CHVAD6hXud1hKAcCaVLRyNz+98gjDeeHDXjzz6AuNxg9QTrdMKD2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=f8v5wG5yRIUiUPlfa8TzCCW8ee+ro5tB1ksFp2I+pPItlibatp7OCfbA1VCFD3hcLUyxGelKF2sFOvV/tCUWygqO8IDa4b9zClvU8T17x54Hhzvc6K4fvmFEkiXq/jsW6IZBcuLtPQwd7HyamQ+vAhVdenlk4USSFSwkAxvIqmo=
Received: by 10.100.227.20 with SMTP id z20mr14063620ang.74.1202097156879;
        Sun, 03 Feb 2008 19:52:36 -0800 (PST)
Received: from ?192.168.1.117? ( [71.191.242.88])
        by mx.google.com with ESMTPS id c14sm13912593ana.21.2008.02.03.19.52.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Feb 2008 19:52:35 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0802032237320.7372@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72458>

Johannes Schindelin wrote:
> Hi,
>
> As far as I understood, your problem was _purely_ a submodule issue.  I 
> find it utterly unnerving that you keep trying to sneak in _anything_ 
> unrelated to submodules.
>   
It is not purely about submodules, but in fact about a centralized 
concept (named "origin") disrupting a distributed workflow using 
submodules in a distributed version control system.
> I am getting pretty angry that you keep trying to complicating things in 
> that area!  
It is easy to substitute emotion for sound technical arguments. Please 
don't, it helps no one.

Mark
