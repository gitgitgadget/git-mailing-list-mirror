From: Rostislav Svoboda <rostislav.svoboda@gmail.com>
Subject: Re: .gitignore vs untracked working file
Date: Mon, 10 Aug 2009 15:49:39 +0200
Message-ID: <286817520908100649j4d369a10p22c667ee077daa47@mail.gmail.com>
References: <286817520908100257n35b178ebu387161658554b4a@mail.gmail.com>
	 <20090810100148.GB22200@pengutronix.de>
	 <286817520908100317k4e98faf9n4e852b7abd4719fe@mail.gmail.com>
	 <4A800785.8050909@viscovery.net>
	 <286817520908100559u6cdcaab0u3a7fdb92cd43eed9@mail.gmail.com>
	 <4A801D48.3020902@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 15:49:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaVG0-0007C6-8N
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 15:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbZHJNtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 09:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbZHJNtk
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 09:49:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:42271 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbZHJNtj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 09:49:39 -0400
Received: by fg-out-1718.google.com with SMTP id e21so737598fga.17
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=7y0FuFhZE9anegdgeIlR+pOCvod1t4CmhstKxJrmmKc=;
        b=pOiSGp9PaZcAdXoZUjM75HJKJyIOB6H8WMfbMN9QxxKCOG0hlKjcae3iWBvsLxt846
         tngDI2vG2CpDY4AjxD+HM2CV6M0CbPpZ70DLtH/EL8CGuwqex5RiQQP1hLxjxQobV+Ex
         LjqYVOssOocQiY5mce4qpS5Y/2wpEirbHHYGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=ZJpQnqfOs7OJYdtiSEAfQauULxijD5WHsyS5WJ5SMGpANEhioIOC2NFNcu37bIIjsW
         dPQZhWlW5Cxq31pq942LX0+R61gGCIp21KBsaXz8FMuK4gwAptoKdHax/5K84+JAgbEJ
         CPYubtQhfAZSl6ihKHhNUzpHkNr0NgwLaU0qA=
Received: by 10.239.168.15 with SMTP id i15mr439879hbe.169.1249912179531; Mon, 
	10 Aug 2009 06:49:39 -0700 (PDT)
In-Reply-To: <4A801D48.3020902@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125444>

> This is not only about ignored files, but untracked files. And the check
> is already there: git said:
>
> Untracked working tree file 'Project/bin/path/file.jjt' would be
> overwritten by merge.

Well the meaning of the error message is clear to you but it wasn't
for me. I simply would not ask if I knew how to correctly interpret
it. I hope I'll have a time to make a little improvement here...

Bost

PS: ...and you can reject it if you don't agree :-)
