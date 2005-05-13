From: Morten Welinder <mwelinder@gmail.com>
Subject: cg-init
Date: Fri, 13 May 2005 09:32:32 -0400
Message-ID: <118833cc050513063251cf8ecb@mail.gmail.com>
Reply-To: Morten Welinder <mwelinder@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri May 13 15:25:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWa9r-0000H1-CT
	for gcvg-git@gmane.org; Fri, 13 May 2005 15:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVEMNci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 09:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVEMNcf
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 09:32:35 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:16185 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262362AbVEMNcc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 09:32:32 -0400
Received: by rproxy.gmail.com with SMTP id a41so397760rng
        for <git@vger.kernel.org>; Fri, 13 May 2005 06:32:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nZjtoZ7ntwqU+nVtwtx4F/3CpRzIOKX0GqDZw7SuOZFVoPXUUZQx9jfcO9bBVXAiP16/vAOtEzsnpzRfNUBuR0sm4eJrTEpAzGWmMoyIMW6CdovOZEqMeBGUPcDfyWeCpE+Cl46Bk6sT0cg9B5botS+Q5C0rRIENDnFmsY4nBok=
Received: by 10.38.152.1 with SMTP id z1mr1397102rnd;
        Fri, 13 May 2005 06:32:32 -0700 (PDT)
Received: by 10.38.76.77 with HTTP; Fri, 13 May 2005 06:32:32 -0700 (PDT)
To: "Petr \"Pasky\" Baudis" <pasky@ucw.cz>,
	GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

1. This still doesn't work from an empty directory.
2. The rm/cp/mkdir/touch will not work if $_git starts with a dash. 
Lots of -- needed.

Morten
