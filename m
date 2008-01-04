From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 4 Jan 2008 19:05:35 +0100
Message-ID: <e5bfff550801041005x3ab682dam8535c7bde75038dc@mail.gmail.com>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com>
	 <Pine.LNX.4.64.0801041030420.31161@torch.nrlssc.navy.mil>
	 <477E6D26.9020809@obry.net>
	 <e5bfff550801040944p7f8e722asfa726b34a4a712fa@mail.gmail.com>
	 <477E7439.9090209@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Pascal Obry" <pascal@obry.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jan 04 19:06:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAqvk-0002n5-If
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 19:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbYADSFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 13:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327AbYADSFj
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 13:05:39 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:15930 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbYADSFi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 13:05:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6197573rvb.1
        for <git@vger.kernel.org>; Fri, 04 Jan 2008 10:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TY6aGc6DVfMhPlct8i4PG8ET3Yi4Fg2mHSX87la9tRo=;
        b=nQ8YpFNfX7C7rvofmWlCnssSrJGSwdfGG68zVclxNi5U7oo0NiunVwDO9BIBaX4dACBhz1AwBL1OcFe6wf6Q5ceXeYVAV3ResWm4vX3HKmved+VHsf2/gbHHkRJPqxUfootoZ9IGLZVs/8/bnm2edMPG+pEjRMfMpMhXLP3M8iA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G7kpYov4c07ZgOmcYOc6vJwqs80QwuhX7GGteBR+1MjjSZSKUctEF3gsU24pPsMIu+9PrU4WdPxHCRDB27dkyk7wMtbvhbtmH7IRw0ojmC2C9DncLIhsnyCTnughbwKY6oEh6lJIzPtKh9hS1XBpuMx3uTr/heaE/KOnJCwVrGY=
Received: by 10.141.161.6 with SMTP id n6mr7683552rvo.41.1199469935929;
        Fri, 04 Jan 2008 10:05:35 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Fri, 4 Jan 2008 10:05:35 -0800 (PST)
In-Reply-To: <477E7439.9090209@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69589>

On Jan 4, 2008 7:00 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> Marco Costalba wrote:
> > Ok, drop is better then clear, but, if we need to add a new command I
> > vote for 'delete' or 'rm' to be consistent with git naming.
>
> If the stash list is thought of as a stack, then drop makes sense.
>

Yes, but is _not_ as a stack because you can say

git stash apply stash@{3}
git stash apply stash@{1}
git stash apply stash@{4}

i.e. you can access reflogs in any order, so thinking to a stack is
misleading IMHO.

Marco
