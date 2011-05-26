From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git EOL Normalization
Date: Thu, 26 May 2011 11:20:13 +0400
Message-ID: <BANLkTim6DbteE4CYUBUsKbTdNCHOu0_+Dg@mail.gmail.com>
References: <20833035.39857.1306334468204.JavaMail.root@mail.hq.genarts.com>
	<29536877.39971.1306336806278.JavaMail.root@mail.hq.genarts.com>
	<BANLkTik3iRKx4P_3nbzygadmLPEOr2vGhA@mail.gmail.com>
	<m3y61uxan2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Bash <bash@genarts.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 09:20:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPUrm-0001mI-N9
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 09:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab1EZHUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 03:20:15 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44182 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab1EZHUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 03:20:15 -0400
Received: by qwk3 with SMTP id 3so218569qwk.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 00:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vAkvmY9+698n0mnedKNkEet+RaFkUrvpHs/urocHH1A=;
        b=JdD79v5VgGSXfW5kEN+jQ9kGLVbpQd5FbS+MZZJLEW3F0FIfSHlzI4s+0HSRATAq9K
         NO0vSP6tzcAX5w/Na4Nm+pv+b0l5vSl3CeFKzycQQss2NYQSEzUtk3sUs9s7ca/qjVsP
         Hch3NuIRQe3Ujh1RI78iNHheOGY8w2DXND+Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TJcipETqscVdvnD8lJZsqrgEREW4Jv6cNMgz+wmKLWOEtQTUBVm+vPS3n7CAsW2jH5
         UOA1pJh0SIrMFe02OSEzdSqfFrSZZnAEBB9Yi+yr3YYVcJdAtI0x4lU9vEe+Rl1sDgS7
         0ehU0EwdxViaiBK/b8IsufiH8+Q4y3+vUkyCU=
Received: by 10.229.136.1 with SMTP id p1mr310792qct.218.1306394413595; Thu,
 26 May 2011 00:20:13 -0700 (PDT)
Received: by 10.229.77.226 with HTTP; Thu, 26 May 2011 00:20:13 -0700 (PDT)
In-Reply-To: <m3y61uxan2.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174501>

On Thu, May 26, 2011 at 10:02 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> I think git examines only first block of a file or so.

I have looked at convert.c:

http://git.kernel.org/?p=git/git.git;a=blob;f=convert.c;h=efc7e07d475c66f7835dc6cbbd3bc358f01c41c3;hb=HEAD

and gather_stats works on the whole file as far as I can tell.

Did I miss something?


Dmitry
