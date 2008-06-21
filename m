From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Sat, 21 Jun 2008 23:30:54 +0200
Message-ID: <19f34abd0806211430x3d7195d8idc61b7103f899947@mail.gmail.com>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Bart Trojanowski" <bart@jukie.net>, git@vger.kernel.org
To: "Jan Engelhardt" <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sat Jun 21 23:32:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAAh3-0002fa-R4
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 23:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbYFUVaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 17:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbYFUVaz
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 17:30:55 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:19997 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbYFUVay (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 17:30:54 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6274524rvb.1
        for <git@vger.kernel.org>; Sat, 21 Jun 2008 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=F5Bxy1t2MSA7aK0LIoZdizcu4PO9fDT06qz5brZwCQw=;
        b=HmaxoeJe20DM2NQbgMP1F3jR+PRJHnpGUiGkGqcuSaAhgE6PXmuYV+/mc/NOnO4Ijv
         KlZfkYDpRFYp4UQu4h10MhfV0r0vhqzNHHOQghNG15MiM4f+5TphLkfurhg87tPlC9B6
         NkEkM/QqhJ+KpzRiP3dlj+MRAx6J/ef9tcNWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=irGilEEwgCU7HhlFOY0u5XaomoC0l7QhsH0sGBy8V3QvmPLA1goxH3KZTYabWCf+qb
         OOSk72OcA37O6DHjEKnVU/BbFm5S8N9XX48wkiKqZw9Bnd0yBNoPDM0YybXUIf0Q6hyK
         WctACJiCAc8qZovXsFZ5CiNg0w60cKBf3vGjE=
Received: by 10.140.128.3 with SMTP id a3mr5559171rvd.195.1214083854308;
        Sat, 21 Jun 2008 14:30:54 -0700 (PDT)
Received: by 10.140.136.1 with HTTP; Sat, 21 Jun 2008 14:30:54 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85727>

On Sat, Jun 21, 2008 at 11:21 PM, Jan Engelhardt <jengelh@medozas.de> wrote:
>
> Since git 1.5.6, `git status` always invokes a pager, which is really
> annoying when the output is less than the number of terminal rows
> available. Can I turn that off somehow or do I need to send a reverting
> patch?

I think it would work to set PAGER="less -F" (a.k.a. --quit-if-one-screen)?

There's also GIT_PAGER variable, core.pager git setting, etc.


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
