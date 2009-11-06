From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Git & Project Workflow
Date: Fri, 6 Nov 2009 22:44:53 +0100
Message-ID: <20091106214452.GA13724@vidovic>
References: <ae09c2a40911051619s36c9a781pdb403fb9140affdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Tommy Wang <subscription@august8.net>
X-From: git-owner@vger.kernel.org Fri Nov 06 22:45:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6Wcg-0003F2-L6
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 22:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758418AbZKFVpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 16:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758296AbZKFVpT
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 16:45:19 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:65012 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757928AbZKFVpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 16:45:17 -0500
Received: by ewy3 with SMTP id 3so1510565ewy.37
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 13:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=df2XkHFNygeOZsndKnlV3+PRSoKWD3/TEIAQw0hKjvA=;
        b=nZBFy6EhpBy8XLJnfM7/YLET0lRM6CvT4KHmwppVaKJsEA0bqlu0uVyM6xu5UjTl8p
         WQ1x4uqMkd+cIpeAVWFeBCl3hkhYujwW0kLGAE7KTyhWulEID0P3ICqhejEKotckzjQH
         CEnt5vVMJ3+bJmewMEgAD5ZSEk8L52qVtsa1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qwINrhNKyYxP4yvkKCq/K5jFnzVCr+aTpAG5MtInPu4iqvClP4dbOvMXabMH/nhy0c
         i+i41uPdOJmQtJQ9Rie4WXD9+G+lEOSvUQD+ZU7Z7u++rlxXbrMWbRwNI9PJNGidZ0e+
         VNWzGQpg8DfchLBtXRvNOwXZRKtl1AQlJAw3A=
Received: by 10.213.0.138 with SMTP id 10mr1420041ebb.12.1257543922231;
        Fri, 06 Nov 2009 13:45:22 -0800 (PST)
Received: from @ (91-165-129-169.rev.libertysurf.net [91.165.129.169])
        by mx.google.com with ESMTPS id 5sm1378737eyf.47.2009.11.06.13.45.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Nov 2009 13:45:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ae09c2a40911051619s36c9a781pdb403fb9140affdf@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132326>

The 05/11/09, Tommy Wang wrote:

> Hi,

Hi,

>      it takes considerably more time to look through a list of
> commits, and pick out the ones that can be moved from main -> limited.

Instead of doing this massive (time consuming) cherry-picking, why don't
you avoid the whole "main -> limited" workflow ? This looks a bit ugly
for me.

I think that the main developers should work by default with the limited
repo and only commit for the secret files into main. This would result
in only pulling limited work into main ("limited -> main" workflow).

Let's rename main to secret and limited to normal to have the semantic
stick with my point. In this case, whole developers work with normal for
the "normal" tasks. If they need a secret change, secret developers
commit and push to secret. Then, you only need to pull normal from
secret and resolve conflicts in one place.


-- 
Nicolas Sebrecht
