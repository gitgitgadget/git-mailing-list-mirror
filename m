From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: cleaning up after using git branch delete commands
Date: Wed, 7 Nov 2007 11:11:42 -0500
Message-ID: <9e4733910711070811y72f96a90i4db9acdf93aa765c@mail.gmail.com>
References: <9e4733910711070606t2c558ac9ob4c729d5baca8fb9@mail.gmail.com>
	 <tnxwssuyug1.fsf@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 17:12:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpnVx-0003kU-Dz
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 17:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024AbXKGQLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 11:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751925AbXKGQLp
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 11:11:45 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:61864 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758012AbXKGQLo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 11:11:44 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1734262nze
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 08:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+XuFftpmkHRWfCkwxipIfJmHDiNmvdfkIcuBABBM8Vc=;
        b=tvOGZyFtPDtJD9WWBIMmbqKi3b38ZlK174dDvj4F+JXLfM8KekYCNbGnSHknBgh1VH+wNasAByfPc2vSsVgZaucL1TJi/QWHSkJIpZAA5ONnwIsqQ0ZPfbG/vvjjYYnfyNb+N0e6Ww8B4UQXMSU37z/u8wGevjqZsjW2En5xOgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GteC2nbhrMYaM8OJIZh7T/rkAe2M9rAQVb55F1Rx4DlAtNmSw08gz15yRdcFiMUoSygb+Gp125MOY0Rnx+woYXMyPa+zFTDM9fG/luD3d07KyatN05LKz+oNGFM7f5rqWdS0RJR1ZtsC8awO6x2pSfEqtpfj8jUhmsD8/yjJAZI=
Received: by 10.114.184.7 with SMTP id h7mr7698638waf.1194451902767;
        Wed, 07 Nov 2007 08:11:42 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Wed, 7 Nov 2007 08:11:42 -0800 (PST)
In-Reply-To: <tnxwssuyug1.fsf@pc1117.cambridge.arm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63832>

On 11/7/07, Catalin Marinas <catalin.marinas@arm.com> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> wrote:
> > I've used git commands to delete several branches that had stgit
> > active on it.  Doing that has left a bunch of clutter in the .git
> > directory. Is there a stgit command to remove all the clutter from
> > branches that no longer exist? I'd like to use the branch names again
> > but the clutter is interfering.
>
> You can create the branch back with GIT and run "stg branch --delete
> --force", though I don't guarantee it will work (BTW, I only recently
> relaxed the branch deletion rules in StGIT so that it doesn't complain
> of missing files and completes the operation, so you should use the
> latest HEAD).

how about a 'stg gc' command that gets rid of all the inaccessible clutter?


>
> --
> Catalin
>


-- 
Jon Smirl
jonsmirl@gmail.com
