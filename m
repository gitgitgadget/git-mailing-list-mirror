From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Merge priority
Date: Thu, 26 Nov 2009 16:42:42 +0100
Message-ID: <81b0412b0911260742l4beb2305y87c01dd61d7c2b57@mail.gmail.com>
References: <26ae428a0911260444j45437a92r47d7f2e8b292829e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 26 16:42:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDgUb-0007Zr-SG
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 16:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755901AbZKZPmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 10:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755846AbZKZPmi
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 10:42:38 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48063 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171AbZKZPmh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 10:42:37 -0500
Received: by bwz27 with SMTP id 27so627033bwz.21
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 07:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Wka+YfRPb6xkbjH24z+4hJhXvTj+rvj8pdJb1wBfRg4=;
        b=O9p3erpxxzHV5Pje8W6f4K3r4r3axV0kLlF5u6tZFtWyYYGaLhHLSPitOR0n/BjtJu
         RFKPxrBGkA2vlj/9TrgzKsZVReGx/kksm7lsJCJZfRJ86bAb6eButod4tNYakbrd1G1C
         tElRXASV9ZC58556YTyN09M+U2pmuWySze9KM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=adnFw28hFmpuIYr0i5t1rFpMy3Rwe8D0fhrKrUuu4ODll00NPGdfIR0L07ZAREMF86
         12J7gUP9bPi9Pnh8q3BbqhAfo2K9fmndhDCLAOZOhQclRLjU1smAVoIV83wmQc+a9b32
         f3ifqwBkAUtl/gRbMtQlFUzwffRg6ULYKvG1M=
Received: by 10.204.34.18 with SMTP id j18mr9131970bkd.38.1259250162914; Thu, 
	26 Nov 2009 07:42:42 -0800 (PST)
In-Reply-To: <26ae428a0911260444j45437a92r47d7f2e8b292829e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133804>

On Thu, Nov 26, 2009 at 13:44, Howard Miller <howard@e-learndesign.co.uk> wrote:
> I now want to update all my customer branches with the latest fixes
> and patches. Naively, I would just check out each branch and merge the
> stable branch - job done. However, is it sensible to ask if there is a
> way to say that the stable branch is more important if there are
> conflicts.

No, all branches are equal. Besides, are you sure it is safe to just take
your stable version of the code in a conflict? Maybe the stable code uses
something a customer branch renamed or removed?

You can take a look at rerere, though. It should help resolving repeating
conflicts  by recording a resolution of your choice.
