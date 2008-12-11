From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: How track evolution of *file* across many branches?
Date: Thu, 11 Dec 2008 08:34:44 +0100
Message-ID: <81b0412b0812102334l4f82ed9du5a635b8679c9611a@mail.gmail.com>
References: <20081211071354.GA22730@seberino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: chris@seberino.org
X-From: git-owner@vger.kernel.org Thu Dec 11 08:36:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAg5b-0001jF-Ft
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 08:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbYLKHeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 02:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbYLKHeq
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 02:34:46 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:47285 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYLKHep (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 02:34:45 -0500
Received: by rv-out-0506.google.com with SMTP id k40so768756rvb.1
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 23:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pQ38tpkvSE5huQHptuspzbF7GaZ7KyKjR46E83YvOwo=;
        b=YMOe4YzEN+0ZC5cCUv/6wjM+htp5gZkK29NtmZ+kp6k4wkcadY/1mz15vHLQN2fZgi
         7u+izK98I0+0uyiQKu4Ss+ZRt+ArkAJPqRXEi3oDF0Gna+w+/mEmmh4HIdxtA5O1B5JM
         hby2w/3D3R21RMl3V3pnTccfInlcMXu4EP5yI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=itFxOofnTFi8PKFL9JHFm74OcoPZt+LBxnKWC8qOgmAlhssaMaK1RqzO/buVaF5G1Q
         bDA2xNVp7/wud2sh63JP7Q8mXmtlvUeHrk5sdVkZyd8BVARdMcjvR7+qqWcRixRholMI
         t2tT8MWabyust3Sxng5lgoUyJNrJUAVi+w/DE=
Received: by 10.114.102.1 with SMTP id z1mr1628669wab.186.1228980884816;
        Wed, 10 Dec 2008 23:34:44 -0800 (PST)
Received: by 10.114.74.15 with HTTP; Wed, 10 Dec 2008 23:34:44 -0800 (PST)
In-Reply-To: <20081211071354.GA22730@seberino.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102785>

2008/12/11  <chris@seberino.org>:
> How track a file across multiple branches.
>
> Specifically...
>
> 1. How find all branches a file appears in?
>
> 2. How find changes in each branch for that one file?
>

gitk --all -- file1
