From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: [PATCH JGIT] Add "compare with Git Index" action.
Date: Fri, 13 Mar 2009 11:28:48 +0100
Message-ID: <551f769b0903130328g49ce9971t53e1571d1b7de06c@mail.gmail.com>
References: <49B63ADC.4080009@gmail.com>
	 <200903110022.53854.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 11:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li4ek-0001Qm-0e
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 11:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbZCMK2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 06:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752670AbZCMK2w
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 06:28:52 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:54404 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbZCMK2v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 06:28:51 -0400
Received: by fxm24 with SMTP id 24so2584252fxm.37
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 03:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v2HsUWpqQpjrRFFFsP8KSUOVCyF+a4FvGyY8MoEebkE=;
        b=rFnFUeGOHul5aujy4Hgyo9cl4oR2g8fOtf17/1BRg+xgepZYqe0RqFMyJNstE11csP
         /c0RaCbJPq6YOeQQT7KBiUA3byQ6fQtuIrFE/4amPjWscPo2HwQKJevnfmAvpvirT/H9
         pY1atFGuKhSKf9oQEnGKuj/SAxScVG17k9FWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X8huFZfZig3rHR/CsRe7n8N+SbZGpGLojNjTtc/NMa60drL/Ftqi9lCDkbq63bWTGl
         B3SBEhiknDfypgK3Q/4H+CQPe9WNFyzlhIRm7UwVwMyd1MfD5nj6j9D1y2qxidIiCwQ6
         bSwNya4g9TOyxvrxq4PJurIREiSxcXUfnzy6s=
Received: by 10.103.217.5 with SMTP id u5mr564263muq.118.1236940128292; Fri, 
	13 Mar 2009 03:28:48 -0700 (PDT)
In-Reply-To: <200903110022.53854.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113164>

2009/3/11 Robin Rosenberg <robin.rosenberg.lists@dewire.com>:
> Saving works, but the diff regions aren't updated on save.

Sorry, I do not understand. Can you explain me more?

> When there is a diff
> this would give us the partial staging similar to git gui, if only (not your fault) the
> commit dialog would allow us to make a distinction between changes in the
> workdir and the index.

Yes, I know that this patch is not very usefull for the moment.
I was more looking for a review as an inclusion.
And you found one bug. Thank you for that!

--
yann
