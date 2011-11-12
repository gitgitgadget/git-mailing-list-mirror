From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Git: Unexpected behaviour?
Date: Sat, 12 Nov 2011 21:25:49 +1300
Message-ID: <4EBE2D8D.1090206@gmail.com>
References: <1321044904175-6986736.post@n2.nabble.com> <4EBD9428.3030506@gmail.com> <4EBDBCA2.7070603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 09:27:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RP8va-0006ud-J5
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 09:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab1KLIZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 03:25:53 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56174 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928Ab1KLIZx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 03:25:53 -0500
Received: by gyc15 with SMTP id 15so3608309gyc.19
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 00:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HbSiZ1KEVsbyZIq6VVpmjj15BYhHmHXGoZ7fAc7TliY=;
        b=MStomSGUia+BS84U9hP5WFuOo/RDWBGOvtRSco4/XOFrqlIss502y/t2I1CxxKq1gN
         zOZqQFeNH4Gj1cRTDnWWBsgWvbEsXa0j7MAmLEg2/ZGFmUFRYZyUQ87A43dazRUveR5f
         WY8lSE0MTcxMw99fNbiDksSGyvnAMR6/wH4XQ=
Received: by 10.68.28.3 with SMTP id x3mr30581330pbg.132.1321086352433;
        Sat, 12 Nov 2011 00:25:52 -0800 (PST)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id jm5sm37215486pbc.1.2011.11.12.00.25.48
        (version=SSLv3 cipher=OTHER);
        Sat, 12 Nov 2011 00:25:50 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.23) Gecko/20110920 SUSE/3.1.15 Thunderbird/3.1.15
In-Reply-To: <4EBDBCA2.7070603@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185304>

On 12/11/11 13:24, J.V. wrote:
> OK so "work tree" is a new term for me.  I thought we were in isolated
> sandboxes called "branches" and changes made in a branch would stay in
> that branch regardless.
> 
> so anything in the "work tree" is over layed on top of my branch if
> there are no conflicts?

Kind of. I'd say that your work tree is updated to match a branch when
you run git checkout initially. The branch is updated when you run git
commit (after staging changes in the index with git add or using -a).
