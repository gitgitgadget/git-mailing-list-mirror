From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: How to mark a complete sub-directory assume-unchanged/skip-worktree?
Date: Fri, 28 Feb 2014 07:58:54 +0700
Message-ID: <CACsJy8BJRixFno=Mb-3PGi-+JTq6RO19GdkveGdApdW8G9nKNQ@mail.gmail.com>
References: <3A9AA61FDE124808AA25DE3511CF99F1@PhilipOakley>
 <CACsJy8DV2uCQbfCP=Mf2qajVAtpTZvKKeCS2H4_o6LA3B96QAA@mail.gmail.com> <DAC4EA00279649D6B3F4DB1B3D662BA6@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 01:59:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJBnV-0005Vf-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 01:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbaB1A7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 19:59:25 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:35816 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbaB1A7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 19:59:24 -0500
Received: by mail-yh0-f49.google.com with SMTP id z6so24211yhz.8
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 16:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ULRbik/mqDs2g6ys/Cj/cjWWaa6/VfHqStyXcAdCAsE=;
        b=n3Mgi/L0996KMNflSiz47iTdpkV6O/V22VCakY6SywPCIPB5IsNSP3jYeAWA049Epy
         BiH+BVs9dykCDCRrJgqiYeT98PNSAF/1YOg1o2gitzTfwZlAWjozew/27Y9erNK87GzU
         PJkG064JF2+PebyOHAq8LV0drQtAc5kyAPjRu46IfW6O9WE0L/mYMSbquU+EOp6Xyg4g
         GoAJqrgUhFskAUNO4W3obGEW9cwjtlZ7ybPfrVyI+ZTrsnDf1ftu2qgKrR6GbciPnzce
         LqQpZbQyHHzvnM7IJfZIa/LjkkXdh0Ugo71P04DowMsIywgKS4m3M98C2V02gYdccdkL
         6qjA==
X-Received: by 10.236.96.201 with SMTP id r49mr18422249yhf.33.1393549164321;
 Thu, 27 Feb 2014 16:59:24 -0800 (PST)
Received: by 10.170.115.65 with HTTP; Thu, 27 Feb 2014 16:58:54 -0800 (PST)
In-Reply-To: <DAC4EA00279649D6B3F4DB1B3D662BA6@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242878>

On Fri, Feb 28, 2014 at 6:46 AM, Philip Oakley <philipoakley@iee.org> wrote:
> Is there a particular bit of code I'd be worth studying for the partial
> index example to see how well it might fit my ideas?

My last attempt was
http://git.661346.n2.nabble.com/PATCH-00-17-Narrow-clone-v3-was-subtree-clone-tt5499879.html
If you're interested in the index part then see 15/17 and maybe 03/17
and 04/17. I can try to rebase and publish the series somewhere if you
want to try it out.
-- 
Duy
