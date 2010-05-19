From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: git pull
Date: Wed, 19 May 2010 05:03:18 -0600
Message-ID: <AANLkTikDmfiUwhn2wQNVkhTVMUpv2pyp5pU5OvmfzM-T@mail.gmail.com>
References: <AANLkTimLZgkojC5L0ZdDewhprLgehLw2w4EZDwyViF4R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: matteo brutti <webmbackslash@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 19 13:03:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEh3x-0007w2-Fy
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 13:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288Ab0ESLDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 07:03:40 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:50331 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349Ab0ESLDj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 07:03:39 -0400
Received: by gxk27 with SMTP id 27so4074703gxk.1
        for <git@vger.kernel.org>; Wed, 19 May 2010 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=8KBZshYv3Pg/Bf1LA6dGMNqwSWvc+mfy1epBUXrQhNs=;
        b=O37R1Z1UdHiCdsVtypAnoveXi5b9QU3vHxyxXiEuHCwL6X6Q3qj4fJJWkkJnMVsLVS
         kXpRH84DidAaGPYaHyN39jSHSh3XxVKioQLxzBzT3s8VVsYytzPTFvklE2I0Mk6Kkuui
         9/k0q+cLcdC2gCulGkpfJiole4VvGM36O4XGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lzszIe12XKW022vFA7kut3sBGZhcIYgrK/K3y3wFDyYta+psaYSy3So0jx+iz0UqXh
         Zp6FUMhxVRn9ZC0o77IENEQeavg6f6tMBrAluqM7SOwUJ54qi+UdR63LD/ublwx5zXsY
         tyF7FzEpMx0/dtQoVqXRQNbuKUXrYXho+plG4=
Received: by 10.91.18.28 with SMTP id v28mr3190626agi.94.1274267018089; Wed, 
	19 May 2010 04:03:38 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Wed, 19 May 2010 04:03:18 -0700 (PDT)
In-Reply-To: <AANLkTimLZgkojC5L0ZdDewhprLgehLw2w4EZDwyViF4R@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147326>

On 17 May 2010 15:51, matteo brutti <webmbackslash@gmail.com> wrote:
> Hi,
> i'm learning about git and soon have a question.
> My repo is in /dev/sda6 and my home is in /dev/sda4, as are both in
> local i thought that when i committ, i'll found the files on repo
> changed, it was not so! I learn i have to use git pull, but i didn't
> understand why.
> I made some tries, put my repo in /home/user/myrepo cloned in
> /home/user/myclones changed files and committed and the changes was in
> the repo without any need of pulling, and i have permission to write
> to /dev/sda6, so why have i to pull changes?
>
> Thanks.
>
>
> Matteo

If you clone repoA into repoB, then you commit some new changes to
repoA, you won't see the same changes in repoB unless you pull them
from repoA.

I don't think it matters whether or not they are in the same partition or not.

As far as I understand, if you clone within the same partition, the
object database might be hard-linked. This won't affect what files you
have checked out though. It would just mean that you won't need to
"fetch", because the objects are already there.
