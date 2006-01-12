From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: [wish] Auto-generate gitk's pretty pictures
Date: Fri, 13 Jan 2006 10:02:01 +1300
Message-ID: <46a038f90601121302x3d06898dk3f9a0ab7114ef70a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Jan 12 22:02:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ex9al-0004xT-T3
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 22:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161270AbWALVCk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 16:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161269AbWALVCk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 16:02:40 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:14168 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161270AbWALVCj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 16:02:39 -0500
Received: by wproxy.gmail.com with SMTP id i34so470839wra
        for <git@vger.kernel.org>; Thu, 12 Jan 2006 13:02:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BpzxyKxUkK1NyxPrJ0QMUHo/gCyrcD3NyxuET7dfjfxNYg1DWvTZyfBsRo+6N74MYtmkZtROM6xfX0epwG+Y2C8U6XT9QRWShAKeOUCuui5UNUH/lqUUwFyfEDFU1weDey396RrnlFHIJpu49yh/TWJ0CiRYEJtF4MEd51Ah2H4=
Received: by 10.54.83.7 with SMTP id g7mr3070847wrb;
        Thu, 12 Jan 2006 13:02:02 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Thu, 12 Jan 2006 13:02:01 -0800 (PST)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14588>

Being an ignorant in matters Tk, I am wondering whether it'd be
possible to hack gitk so that it renders the top canvas into a file.
gitweb doesn't give people any hints of how the heads are related, so
I am working on the idea of running an hourly cron on the server that
does

 gitk -d --all --max-count=1000 --prettypic=foo.png

and link to the png from gitweb. Is it easier to trick gitk to do it,
or should I be thinking of porting the logic to some other script?
(Possibly in Perl using GD).

cheers,


martin
