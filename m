From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [long] worktree setup cases
Date: Fri, 22 Oct 2010 07:34:36 +0700
Message-ID: <AANLkTinS0co8TMmyRCQ4Xe9+pDR-uUn20WNQwYJEAQea@mail.gmail.com>
References: <20101020085859.GA13135@do> <20101020190709.GB10537@burratino>
 <AANLkTimzfxJFz2FRVCJ7b4+icXMxpQGNo0WGm_BXzXNy@mail.gmail.com>
 <20101021033042.GA1891@burratino> <AANLkTikwApJ2EtJNiOZPHVrz6seJNP-zEqzH_b62ksLf@mail.gmail.com>
 <20101021185132.GB28700@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: weigelt@metux.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 02:35:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P95b5-0002Bu-DN
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 02:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657Ab0JVAe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 20:34:58 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59279 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab0JVAe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 20:34:57 -0400
Received: by wyf28 with SMTP id 28so217464wyf.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 17:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=XC3FE2+Uu0ReF+BDUJQn3W1/mmpcGMQcA7Z3lHdqd+8=;
        b=KPgOmIXsG8o6rk/W+JOdDqq5XDuukA8VvA4VjwY7LxreJqIMLfd5xFG3/IDgwxw52b
         yV1ZY7WcM5Mf6nhEIG/19Rp3pe6Znr7KLOmoCFQ0Amd55GybY34Rh/5lIeB5cv6wuGQq
         un7R2nxIV02GWvbL8qB14jjNhFzAMOPsKRppw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=TZPYzy8L3yVGPVlH+f9tcFJCsd1ZWJBGwd2rbVmxnBzGcEf6uPZlVe+8Cd59uyslWH
         7ISMp4oNYCsRLsYOpJ51hf7a7ftfGPyWsHXK+fw71FC9+RIp5LuAoTTtFAlyG0Yk4QmU
         Bq3tnTBzys8emPLFbPeUrc/JIEW1xRObW/mgg=
Received: by 10.216.181.15 with SMTP id k15mr1720558wem.82.1287707696309; Thu,
 21 Oct 2010 17:34:56 -0700 (PDT)
Received: by 10.216.171.207 with HTTP; Thu, 21 Oct 2010 17:34:36 -0700 (PDT)
In-Reply-To: <20101021185132.GB28700@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159610>

On Fri, Oct 22, 2010 at 1:51 AM, Enrico Weigelt <weigelt@metux.de> wrote:
>> Also the "relative to $GIT_DIR" may be confusing. If $GIT_DIR points
>> to a file that points to a true repo, then to which one it is
>> relative?
>
> Despite the fact that I doubt the usefulness of an .git file at
> all, it IMHO should be interpreted as an kind of userland symlink.

I do find .git file useful. I put my worktree in a server where it can
be wiped out completely. So I don't want to put my .git there. .git
file can be used this case so I don't have to set
GIT_DIR/GIT_WORK_TREE every time and my .git is safe elsewhere.
-- 
Duy
