From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: linux-x86-tip: pilot error?
Date: Sun, 22 Jun 2008 14:48:35 +0200
Message-ID: <237967ef0806220548t3fd73211v354071efe2db22e4@mail.gmail.com>
References: <20080622123620.GA9328@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, git@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
X-From: git-owner@vger.kernel.org Sun Jun 22 14:49:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAP0e-0002JD-De
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 14:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbYFVMsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 08:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbYFVMsh
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 08:48:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:48006 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbYFVMsg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 08:48:36 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6500342rvb.1
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=8V5b7vRyYqD65fbav5l8oRD4dQdz+JAQdU0l2my8K/I=;
        b=shDYiH06wlDh0+tKNxf3o5OyhOeg6S0UpXipZUoA1jntU+XWk+q5oE5T8EaZmYiL2M
         Z4nFEi4F7dMN2AVoeq7jiwtb6Kvb26+ul4yb23TYDoZFBA30zsReaTsjNICsKnlXPYYM
         0P9RII1+EUzCGSIsWsCnieQJqs6EYFjGiaxPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Z3AQT8pWrZ4yfqtxjkTDjqRbduByRnS4yTjmvybwY7IfRMi3y+pNXCxNaaVCPuJyE8
         V3KB542NVYVnpB9Ktl5CtkiVto/Wg+udtUAm8nRSHqbC5VRk1jTzdSQ+j63i9mmo1geT
         kS4RzwKDU5y/hKDwVs28PWp8eyrWC/mgI3Eqs=
Received: by 10.141.34.12 with SMTP id m12mr10848837rvj.26.1214138915880;
        Sun, 22 Jun 2008 05:48:35 -0700 (PDT)
Received: by 10.141.153.6 with HTTP; Sun, 22 Jun 2008 05:48:35 -0700 (PDT)
In-Reply-To: <20080622123620.GA9328@linux.vnet.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85767>

2008/6/22 Paul E. McKenney <paulmck@linux.vnet.ibm.com>:
> Hello, Ingo,
>
> I took the precaution of rebuilding my linux-2.6-tip from scratch as follows:
>
>  544  mkdir linux-2.6-tip
>  545  cd linux-2.6-tip
>  546  git-init-db
>  547  git-remote add linus git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>  548  git-remote add tip git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
>  549  git-remote update
>  550  git-checkout tip-core-rcu-2008-06-16_09.23_Mon

When checking out remote branches, you have to specify the remote:
git checkout tip/tip-blabla
(it'll warn about detaching HEAD, this is normal).

-- 
Mikael Magnusson
