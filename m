From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH] Per branch properties for pull and fetch
Date: Thu, 27 Jul 2006 15:10:24 +0200
Message-ID: <8aa486160607270610q32093546uf28e9982d85edc1a@mail.gmail.com>
References: <87lkqfcvm2.fsf@gmail.com> <20060727085516.GC27593@admingilde.org>
	 <8aa486160607270240h412b0dcek1d57eeb2b254fb2e@mail.gmail.com>
	 <8aa486160607270306s3f49a01cq91ef61e2c9f005e@mail.gmail.com>
	 <20060727120220.GD27593@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 15:10:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G65dE-0001lY-Ol
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 15:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWG0NKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 09:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWG0NKZ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 09:10:25 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:54424 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751262AbWG0NKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jul 2006 09:10:25 -0400
Received: by wx-out-0102.google.com with SMTP id t16so1150112wxc
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 06:10:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t8QR4krSueWPoaIVIR8stwwa9JYQLnx1geUg2gJYh1aRQkZXbr8WPmsnURDzyFLmGxDrU8Qg7zW7IfekKDCtqfNtHhFfelRUNJbzxfLN596+e8q4kZgC/a2+zXaHuLH6rCEWTRpffaIg3qV2ylUZ3VtgzbGcXJaI/9p0wX8Fwac=
Received: by 10.70.18.11 with SMTP id 11mr794530wxr;
        Thu, 27 Jul 2006 06:10:24 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Thu, 27 Jul 2006 06:10:24 -0700 (PDT)
To: "Martin Waitz" <tali@admingilde.org>
In-Reply-To: <20060727120220.GD27593@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24285>

> The current default is to always use the remote's master branch, right?

No.

For .git/remotes/ remotes it defaults to the first Pull line.
For .git/branches/ remotes if defaults to master, but you can specify
another branch.

Santi
