From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] GPG Signing of Commits
Date: Fri, 3 Aug 2007 07:52:04 +0200
Message-ID: <81b0412b0708022252g4ac91ec2g70ac18badcc67dea@mail.gmail.com>
References: <f8tl14$o4r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "David Soria" <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 07:52:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGq55-0007cc-M2
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 07:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbXHCFwI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 01:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbXHCFwH
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 01:52:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:1102 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbXHCFwF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 01:52:05 -0400
Received: by nf-out-0910.google.com with SMTP id g13so194311nfb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 22:52:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oR6aPG4LvSiWp9C5en/+7LRrlt4UIpxFWHHx+rL/U/ec/ZPg4cz/7cAT8MmXlvsg5VFl97Ngy5Gi+pKQ7M5N3Wotk2X4i3ZKnnJv+K4++CBuoqwNgwij5OAL1IcT7/3BqNy0XvSr3ZBQUE/5/ZsiYszxowTYLPxuCtZU4uPmkaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b/O3hsHs9FBnDcPLWwqs86mDLFPX54g0YeCpba6pi/OrjKwxWs/8Q0V2fz7960Jy0LYgYbpENW+9J0cZHiPy8/N3yYH3RulIRzFY4/EkQ5v9JUfApNwZ84a8mv+Yd2WoV4mLWykPkXpicqNl7ZvCBDynh8XX+POJfrV0YWjbnV8=
Received: by 10.78.165.16 with SMTP id n16mr732820hue.1186120324354;
        Thu, 02 Aug 2007 22:52:04 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Thu, 2 Aug 2007 22:52:04 -0700 (PDT)
In-Reply-To: <f8tl14$o4r$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54670>

On 8/3/07, David Soria <sn_@gmx.net> wrote:
> Hi list,
>
> i personally like the feature of signing commit messages using GPG. What
> do you think about the patch? It's just the mechanism taken from git-tag.
> Would be good not just have validation for tags, but for commits.

Where do you verify them? Where do you *propose* to verify them?
