From: David Aguilar <davvid@gmail.com>
Subject: Re: Superproject branch tracking?
Date: Wed, 21 Jan 2009 15:25:03 -0800
Message-ID: <402731c90901211525i2db339a6t94a4478268dfcf1a@mail.gmail.com>
References: <49779220.5000900@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Loeliger <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 00:26:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPmSr-0003P8-MJ
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 00:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbZAUXZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 18:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbZAUXZG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 18:25:06 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:4032 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbZAUXZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 18:25:05 -0500
Received: by wf-out-1314.google.com with SMTP id 27so4601003wfd.4
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 15:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UUXoe0wXmyxGF5BzDpUor9ihDEiPSE3A2t/aOteUHoI=;
        b=Sm5PMk8xcX5rpjdAYg6J1GNQ9yMorjc/eAh4vDiWKfjf6N7EttDKt4sjGB8IX/7US2
         8bBMvIA3T1cEYFzHc6OqsTjR8MKIw9rgs2C2HDAG+c8Dv3heifjtQLwejisV6yLoDHUC
         CB1+TIgieXNuhRgQmR8FJ1spGSa39io+X2YGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MR0q6IpVvXMn4JZx0YJUBEivhf/zAQsTuy47uenOfSqazqj5iM/+gPWdhIqnJ79NPu
         FMgw/H37OeCnNRV9YXxYfqcboix/6WM3Zy6yleDW3huH4J7/FdAsrm9kTlApg2ZZTtHi
         NUitYXrzp4bb/wAS+VfCs7WE2otWXlaT5GpA0=
Received: by 10.142.80.7 with SMTP id d7mr509316wfb.29.1232580303600; Wed, 21 
	Jan 2009 15:25:03 -0800 (PST)
In-Reply-To: <49779220.5000900@freescale.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106700>

On Wed, Jan 21, 2009 at 1:22 PM, Jon Loeliger <jdl@freescale.com> wrote:
> Guys,
>
> Can someone tell me what the current best practice
> to have a Git supermodule maintain a branch that is
> actively tracking a similarly named branch in all of
> the submodules?
>
> That is, I want have a scenario where I would like
> the master branch of a super-project to always (or on
> demand) reflect the current HEAD of the master branch
> in each of the submodules.
>
> Does anyone have a script up their sleeve that I can
> use as a hook in the super to notice updates to a submodule
> and cause it to scurry around the sub-modules and create
> a new (updated) commit in the super?
>
> Thanks,
> jdl
>

Hello

Have you seen Shawn's repo tool?

    http://kerneltrap.org/mailarchive/git/2008/10/22/3763214

It might not do *exactly* what you're looking for, but it is magical.

There's also a repo-discuss google group where repo-specific questions
can be addressed.


-- 
    David
