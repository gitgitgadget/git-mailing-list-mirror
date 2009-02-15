From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2 2/2] Teach @{-1} to git merge
Date: Sun, 15 Feb 2009 18:24:05 +0900
Message-ID: <20090215182405.6117@nanako3.lavabit.com>
References: <7v4oyxzeay.fsf@gitster.siamese.dyndns.org>
 <76718490902132311j5add87bcpb103c951a8192b05@mail.gmail.com>
 <7vzlgpxz4g.fsf@gitster.siamese.dyndns.org>
 <7vskmhuzla.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902142332210.10279@pacific.mpi-cbg.de>
 <7vfxigqwsp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 10:26:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYdGl-0006Ht-LG
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 10:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbZBOJZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 04:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbZBOJZE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 04:25:04 -0500
Received: from karen.lavabit.com ([72.249.41.33]:59389 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbZBOJZA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 04:25:00 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id C559C11B8BA;
	Sun, 15 Feb 2009 03:24:59 -0600 (CST)
Received: from 1730.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id C8SEORXG5MFM; Sun, 15 Feb 2009 03:24:59 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=4Hx58yl/amUF2E/PVvFeGli2ZeG/S7UIOq4Wf6Hep5OFjV9lRgv+Mbwb2Gy8+AmObWl9XHqw4OwPmfdghYJNutWJtvIeU23mweF2VG1pd2SeXnpwZQjLZA+yQXYOi/6MF3sWd5ygONIRQHhODsy9Bczn9Cj+mNk4lHQRHKyVk3g=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vfxigqwsp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109984>

Quoting Junio C Hamano <gitster@pobox.com>:

> The tip commits come from get_sha1(), so obviously it would "work", but it
> does not show what branch it talks about.  HEAD is shown only when the
> user says HEAD (e.g. "git show-branch master HEAD") so I do not see much
> similarity there.
>
> The advertised new feature is that you can use the @{-1} syntax anywhere
> you would use a branch name and it would work as if you typed the name of
> the branch, so in that sense show-branch that shows @{-1} and does not
> show the name of the branch is a bug.
>
> It is the same thing for "git-merge @{-1}".  Sure, it would record a
> correct tree in the resulting commit, but without the fix it would say
> "Merge branch @{-1}" which is wrong and needs to be fixed.

I am sorry, but I don't understand your logic.

'git-merge' can merge any commit. The argument doesn't have to be a branch name. But it behaves differently when the argument is a branch name. Therefore, @{-1} syntax must behave in the same way as any branch name. I can understand that part.

What I don't understand is your comments about 'git-show-branch'. It also takes any commits, not just branch names, and it's output doesn't seem to treat a branch name any specially from other commits.

I think Johannes'es analogy with HEAD is correct.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
