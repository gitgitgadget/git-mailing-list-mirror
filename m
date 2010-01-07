From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: merging two equivalent branches
Date: Thu, 7 Jan 2010 19:22:00 +0100
Message-ID: <46d6db661001071022t79ca65foac249d948a20c328@mail.gmail.com>
References: <B0543B3C-C139-4BD3-B028-58B4DA132422@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 19:22:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSwzu-00075f-53
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 19:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119Ab0AGSWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 13:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084Ab0AGSWI
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 13:22:08 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:36140 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab0AGSWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 13:22:07 -0500
Received: by bwz27 with SMTP id 27so11657913bwz.21
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 10:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=i+Gkah/7BJHDKfgF6R4liAobnC49OrorcsiqRJkMcR0=;
        b=bzSmtcQaJacMTeY7QnZ0kWjl75YtHR/kWyEBCqXigaIoxiw25LPUrZzu8ErlvnZY6O
         e8D/cxLybICwKWzb9OoHSC0fyyuW5bR9x5rMutcTziuqCJGeM93MjmK2QqCHFPwyfh0V
         F/bcllbDwc+UZIWKsnJViSFm/mfbssY0vnhpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=msMwjYYgPYL0TvpMSyiAXj1q8o/Eizi7czVkzJxEwkHVTfhhHfS7PTirspdn69Yl8t
         3fE3fICBa060AhgdWchAOdJxcvtHKhKiP+EZ96Sc57t4tOeUsi9utT9zKoBNCVQQpa9B
         X7q/ZqSg/aY06KqV8v1AfI/gtiIPwNN9bxNJE=
Received: by 10.204.152.200 with SMTP id h8mr307630bkw.150.1262888521262; Thu, 
	07 Jan 2010 10:22:01 -0800 (PST)
In-Reply-To: <B0543B3C-C139-4BD3-B028-58B4DA132422@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136378>

On Thu, Jan 7, 2010 at 7:17 PM, David Reitter <david.reitter@gmail.com> wrote:
> Hello,
>
> I have a problem with my git project, resulting from an upstream branch beyond my control being rewritten.
>
> Can I specify parents for a revision whose history is hidden from git-log?
>

I recall asking a similar question in 2008, and the answer was to look
at "git graft" and use "git filter-branch" to recreate history.

My 2 cents

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
