From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: cg switch -l doesn't work when branches point to the same commit
Date: Wed, 11 Jul 2007 15:36:39 +0200
Message-ID: <81b0412b0707110636u77b56f1biccb221489933972a@mail.gmail.com>
References: <f158199e0707110559q43c290b4x2caee13cac46cf29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bradford Smith" <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 15:36:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8cN5-0007w6-4H
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 15:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764939AbXGKNgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 09:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764824AbXGKNgm
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 09:36:42 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:19175 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764923AbXGKNgl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 09:36:41 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1178971ika
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 06:36:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LE0sLUEr/vq7ULJ2/5rPHCT0HgL5aSbsZOLCqwPVi3vjxK15danoEz33RvCAY+Ye6tKZMduhlNSheDB/weJ/SpDq6LESsCza/C0ilvxUM74idR9KeJs0bBb9uXL05YMyI7HuHuz5R9f3fNu2JgEy7HAAi/WvZVKHLSXhUkic9Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k2QjC1t6OwXQu5FH9Sbui83PzoeEHejyfyEK7l6GM1tVzpuYSKQm3U/EJVx/5HoDOJV4h4Zm8jcbcYFqMDoEl70z4v2BNBVKoBh31wQ4l24Y1nEgWPqIgCzeXQWDQsNYSWy+bwDA9aPCkEi00PDeyddSFuoL3qoXd6qLBvOf3Go=
Received: by 10.78.159.7 with SMTP id h7mr2425539hue.1184160999140;
        Wed, 11 Jul 2007 06:36:39 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Wed, 11 Jul 2007 06:36:39 -0700 (PDT)
In-Reply-To: <f158199e0707110559q43c290b4x2caee13cac46cf29@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52159>

On 7/11/07, Bradford Smith <bradford.carl.smith@gmail.com> wrote:
> The message below applies to software versions:
>
> git version 1.4.4.2

It is fixed sometime between your version and git-1.5.2.2.
Use git checkout.

> cogito-0.18.2

Cogito is unmaintained ATM.
