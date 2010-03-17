From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git branch --current?
Date: Wed, 17 Mar 2010 22:04:50 +0700
Message-ID: <fcaeb9bf1003170804s4c9fdbb6id2c045bdb90f8c6f@mail.gmail.com>
References: <fcaeb9bf1003170743kc347d53jefe41039e3b9a69a@mail.gmail.com>
	 <76718491003170748h349c5ed0u7649864cc824f549@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 16:04:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrunp-0001QW-0g
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 16:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068Ab0CQPEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 11:04:51 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:59342 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab0CQPEu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 11:04:50 -0400
Received: by pxi36 with SMTP id 36so603153pxi.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=yg1XCuNRBpW3CH+HuHfwgHZAEqkUIeqktxCtiF2qTvA=;
        b=pvR1zf+KKLdkXkjObCpNzD4gL54y0Lu0ARW7Dgb7zr7bYhlvfs4PRQqnVbRsH5G1yy
         ep9MiMrFRozDVS/bjJ0zSjQuQCSnN7siUHkRioxnYmKw0YvtJsnQY+yJYCywor5WyHB1
         mrosoqNG/lzgaj8uJsatNuxD77++HW5XhRF1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=AvUligLu+EPCVqpPJSdRCLzmeHLE+BGocNOmdtT8xHpUYHvk23aPN2IFPVjtWfrS5t
         fm4vs9p7RBecK4mEec5xJWHo/IctUixk8MQuFrpDpsslTP4ieH4CmQiHX00rLuZRqHrF
         PikaLhFL/u2pfwm2ASxPnfMMAAXePytNl1g5g=
Received: by 10.141.187.14 with SMTP id o14mr891355rvp.217.1268838290264; Wed, 
	17 Mar 2010 08:04:50 -0700 (PDT)
In-Reply-To: <76718491003170748h349c5ed0u7649864cc824f549@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142397>

On 3/17/10, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Wed, Mar 17, 2010 at 10:43 AM, Nguyen Thai Ngoc Duy
>  <pclouds@gmail.com> wrote:
>  > I use "git branch" when I need to know the current branch. But I have
>  > many branches, looking for the star is "time consuming". I'd rather
>  > have something like pwd, just print the current branch name and that's
>  > all. A bit more information about current branch wouldn't hurt, as
>  > long as the branch name is printed at a fixed location.
>  >
>  > What command do you use to know what branch you are on?
>
>
> Doesn't everyone who's anyone put it in their prompt with the bash
>  completion script? :-)

Me obviously :-) But bash is not the one true shell. I need to use csh
sometimes.

>  Well, if not, how about a simple alias:
>
>  pwb = rev-parse --abbrev-ref HEAD

Hmm.. I have alias.pwb = symbolic-ref HEAD. Both solutions are not as
good as "git branch", say detached HEAD case.
-- 
Duy
