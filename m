From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Help merging two repo without connection
Date: Sun, 16 Nov 2008 16:06:55 +0100
Message-ID: <bd6139dc0811160706l4dfad335wc4048cd3cfca80ec@mail.gmail.com>
References: <AB681AEE-D229-4F1C-8D7B-8E60E0ED8E96@web.de>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Luca Siciliano Viglieri" <lsiciliano@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 16 16:08:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1jES-000335-2G
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 16:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbYKPPG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 10:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbYKPPG5
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 10:06:57 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:62785 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbYKPPG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 10:06:56 -0500
Received: by yw-out-2324.google.com with SMTP id 9so894493ywe.1
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5ZOnjrqMkjKY+gXNslfBIjEE7gRvj2VFON6CeT41RYQ=;
        b=WaWBeBOnfJ83njjbT1gnZRAGlpF8BpsygLHjlcu/pOBNoMuhz5SQcPcxT0Et56CXDf
         2ISIxAGEJanY7oTvWWlx2hUIBytF82ixaLEfcBvZRNYOJaltf3GApcjCNmO5aawZ/BaJ
         f19ECq82fQRIOyoCurO3u8Cnw6yEIeqsegldk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=P63EZVMGa9zr39LH2QIfka8Px++/h3YI01u68iG5VdkddH7QLF/CN6C2imyS4eOFTv
         TfWwP6G3fhV5Cc6/9T9g219xfCGvJeEg1VfOI/4bOeK/Lofo4qDyRHeOObM7ZYDLqgEk
         AJ9yJ5pC/CM/BgEzLSezmgakmMQJOZqlCe6OU=
Received: by 10.151.27.15 with SMTP id e15mr5988562ybj.59.1226848015419;
        Sun, 16 Nov 2008 07:06:55 -0800 (PST)
Received: by 10.150.149.14 with HTTP; Sun, 16 Nov 2008 07:06:55 -0800 (PST)
In-Reply-To: <AB681AEE-D229-4F1C-8D7B-8E60E0ED8E96@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101135>

On Sun, Nov 16, 2008 at 15:59, Luca Siciliano Viglieri
<lsiciliano@web.de> wrote:
> Hi,
> i'm trying to keep synched two repositories without always having a  direct
> connection.
> My situation is the following:
> I have a project on my computer with GIT repo.
> Another developer visited me and cloned my repository connecting the two
> computer (for example via  SSH).
> Than i sent him for the next days patched of my changes but when he came and
> we merged i got the following tree:

I suspect 'git rebase' might help you out. When you apply the patches,
apply them to the branch they were based off (instead of to the most
recent master), and then rebase -that- branch (with your 'git am'-ed
patches from your other box) onto your most recent master. That way
you should be able to keep  a linear history :).

-- 
Cheers,

Sverre Rabbelier
