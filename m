From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Sharing a massive distributed merge
Date: Thu, 17 Mar 2011 10:10:36 -0400
Message-ID: <AANLkTi=25=99Gh9hGUxEuvB9Xvv=f8uJxThaMxaAQKbq@mail.gmail.com>
References: <4D8119BE.2090208@workspacewhiz.com> <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
 <20110317063816.GD11931@sigill.intra.peff.net> <AANLkTimTKbKWmf80u-kgnvQ2gT8hx2KTm6HGbWejt3eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 15:11:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Duz-0002ku-5X
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 15:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab1CQOLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 10:11:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52172 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900Ab1CQOLH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 10:11:07 -0400
Received: by iwn34 with SMTP id 34so2855617iwn.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 07:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=4E8LKAW2925BUsV+waP7oZIskOyrNcv4GodzVVG2Mzg=;
        b=AMu+MeocNebKw44fLmz0YScn3PnL1/VDx1YJSLOiMCkStbZB1wTRCPKY57nWzyxXcA
         9BjLaralWghiY9DwwM0hYIwzTGSMa4fIsYdM9FjEPFSY4EMYxP1IamNFhJGpt7je4nW5
         7axkDizG3S9CAkWPxYLKUkYfJaQkSZPPlXTYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=l42G7SQ9rDedyQi1GKGocqz/Xce/vVOFG8LcelXtJgZGl7Xj9/qpa/tpe+xMQMnvhV
         VEMOSnMVw7A7fezMC9dYdxF2DLFNIOgEodXOO8bV6gyeFkWPyfjcGMaiVIn6PKlD42Cn
         eV5wazxfAhHD4H/cDQY1o5AHSt5u9iQxve8aE=
Received: by 10.42.75.137 with SMTP id a9mr2028660ick.194.1300371066155; Thu,
 17 Mar 2011 07:11:06 -0700 (PDT)
Received: by 10.231.34.7 with HTTP; Thu, 17 Mar 2011 07:10:36 -0700 (PDT)
In-Reply-To: <AANLkTimTKbKWmf80u-kgnvQ2gT8hx2KTm6HGbWejt3eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169243>

On Thu, Mar 17, 2011 at 4:53 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
> What if they just revert the rest? Reset the files to their states before
> merge.

That's the same as checkout --ours which is sometimes a valid
resolution for a file. So I think "I resolved this file" needs to be
recorded either way.

j.
