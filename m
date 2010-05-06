From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git branch documentation improvements
Date: Fri, 7 May 2010 08:59:22 +1000
Message-ID: <r2l2cfc40321005061559p9d3a5392rdc2b30f63a34ab9b@mail.gmail.com>
References: <201005070024.41172.ahartmetz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Hartmetz <ahartmetz@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 00:59:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAA2T-0007e3-Sj
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 00:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab0EFW7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 18:59:24 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:38291 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab0EFW7X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 18:59:23 -0400
Received: by qyk13 with SMTP id 13so498954qyk.1
        for <git@vger.kernel.org>; Thu, 06 May 2010 15:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=YhXP5BgLjq7YmGZxsAY+tv/LEDbkFXajiD8r5yuNNoI=;
        b=JnlLDovNWJNNWa/ndc1JZ+JjGzUMeu//3OY8dLKaA3Z+vNdfTeJxQqvDyPPdgecCBU
         YNWLge8SdTugRWGnik9bBfx1QCH3PgPK2sDzncUT0DCzBW0rT/02FwRe6KNjRKRDnf+X
         H2lTajpE66BWUCw9DgSX5s2lwRl7JaF8zwErk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=C07j5hlnPO0dWGu5lvzq/2Kq5EiGO8VRop7J1QCK/rOgGGlVwgmtNU1naITaxD5srJ
         xRWgmEIZG1tTyLrTe5Kh377TuKUMVTzPNE5dz5Ia+NxxX1G0zElCfLQW10shxZ2v5df4
         4CVEAeUO2C/ceGbY+7jPBAMtvVKZlC0C2vGsI=
Received: by 10.229.235.202 with SMTP id kh10mr5978794qcb.78.1273186762598; 
	Thu, 06 May 2010 15:59:22 -0700 (PDT)
Received: by 10.229.214.80 with HTTP; Thu, 6 May 2010 15:59:22 -0700 (PDT)
In-Reply-To: <201005070024.41172.ahartmetz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146510>

This patch would be easier to review, and thus more likely to be
accepted, if the guidelines in SubmittingPatches had been followed,
w.r.t. not using attachments to submit patches.


On Fri, May 7, 2010 at 8:24 AM, Andreas Hartmetz <ahartmetz@gmail.com> wrote:
> Hello all,
>
> Today I read the git branch documentation and noticed a few things, mostly
> style and consistency related, that could easily be improved, so I did just
> that.
> Please consider merging the attached patch if it looks good, or tell me what
> you don't like about it.
> The most significant change is renaming <start-point> (or is it
> <startpoint>...) to <branch-head> because even I as a relative beginner know
> that a branch is defined by its (movable) head, and <start-point> *does*
> actually specify the new branch head if I'm not mistaken.
>

While I agree with you start start-point is probably the wrong name
for this parameter, I wonder whether branch-head might be too
suggestive that the value of that parameter must itself be an existing
branch head.

I think the term "head-commit" would be a more accurate way to
describe the possible values of this parameter. That is, it is the
commit that will become the head of the new branch.

jon.
