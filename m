From: bill lam <cbill.lam@gmail.com>
Subject: Re: how to track changes of a file
Date: Mon, 16 Jun 2008 23:49:10 +0800
Message-ID: <48568B76.5050108@gmail.com>
References: <48564499.3050008@gmail.com> <485646F9.1030300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 16 17:50:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8GyD-0008Ox-TG
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 17:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbYFPPtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 11:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753955AbYFPPtT
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 11:49:19 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:25663 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbYFPPtS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 11:49:18 -0400
Received: by py-out-1112.google.com with SMTP id p76so2043445pyb.10
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 08:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=AFI8B9LikuiTFte1IP6alS6zkEZZkkhBuKLqrkI8eJQ=;
        b=Ub/dONgKWG1HnMqWU99IMDsrk4V4cVJPa9juPeTvC0HeuQ5AExOdXKuQiXBZOn/Hip
         lAY+fleIa3SaBeOLsuP5oTXsvYDFzx4MlXunBHhdyxfcTv7KvF5p07BIqbtBr8sJPX+I
         7zbQfH4BF10EuynmvQI6js1D78DPxtd7ZTh1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=eI6eTo4AxZRv1nUybWohosIQmVtxXN48QpFBGDHS6yqWHCz55uUz/JTCeQ+Z0GAUgq
         TI+uP0KG6tNT5cuCCdUXTn/bZth5s1up0fXEsbaoA9/6wuvW9pI4c0gLspnI5lQ16a64
         WQ77Xm4WWsbV7Adq6aXYiR8ST4zE5Zby5BklY=
Received: by 10.114.183.20 with SMTP id g20mr6402185waf.77.1213631355443;
        Mon, 16 Jun 2008 08:49:15 -0700 (PDT)
Received: from ?192.168.1.201? ( [58.152.200.105])
        by mx.google.com with ESMTPS id m29sm9116871poh.4.2008.06.16.08.49.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 08:49:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <485646F9.1030300@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85195>

Johannes Sixt wrote:
> $ git rev-list -3 -- glinvc03.ijs
> 
> 
> $ git show {23335c,31e4f2,b515f0}:glinvc03.ijs

Thank for you help, but these 2 command did not work, did I missing something? I 
I use git version 1.5.4.3 on linux.

$ git rev-list -3 -- glinvc03.ijs
usage: git-rev-list [OPTION] <commit-id>... [ -- paths... ]
   limiting output:
     --max-count=nr
     --max-age=epoch
     --min-age=epoch
     --sparse
     --no-merges
     --remove-empty
     --all
     --stdin
     --quiet
   ordering output:
     --topo-order
...


$ git show {23335c,31e4f2,b515f0}:glinvc03.ijs
fatal: ambiguous argument '23335c:glinvc03.ijs': unknown revision or path not in 
the working tree.
Use '--' to separate paths from revisions
