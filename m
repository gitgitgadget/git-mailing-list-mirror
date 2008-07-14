From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [RFH] Finding all commits that touch the same files as a specific commit
Date: Mon, 14 Jul 2008 16:30:52 +0200
Message-ID: <bd6139dc0807140730o2cdc64d0m28a83dfa72d1496b@mail.gmail.com>
References: <bd6139dc0807120858vc058451lb10933b5225c8521@mail.gmail.com>
	 <7viqvavao4.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0807130743y178a865amebcf130a68283854@mail.gmail.com>
	 <alpine.DEB.1.00.0807131929200.8950@racer>
	 <bd6139dc0807140417h7c9cd309g7cf911e78e7f78c5@mail.gmail.com>
	 <alpine.DEB.1.00.0807141311520.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailinglist" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 16:32:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIP5o-0003DA-Eu
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 16:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbYGNOay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 10:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbYGNOay
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 10:30:54 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:18218 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbYGNOax (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 10:30:53 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4892390wfd.4
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=LsK/iNeRo11FvFK2U+f/Q6vtQFdGvO9ATufsXtVWL0o=;
        b=dYU4ytOsLRfWlNMPs0Fe/ejUf+ZMulQ2TgbiKHxQOdi5r2RDDU1lrCSRTlTSVmHMA7
         2p4qb+n14sMAMnVAGD+LHS46q9lWoH6PZhMWiUoRL9LPd1XpZQaxwNhNphdPZlO2X7HB
         xLaK75soQEe+tBCo6prat19IcmtfsHdWk0tcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=CqGP3dS60CYzDhPg+7+jY4Ij26RulAhNcoJzQJTa2i+0GK2y81leg5had9uiFxV7XS
         kadwr+1l40T7dUV7TXFHGm/gdXXCOP3beDkM6yQZ5Be9yC16QL3J/unMWQUnQFYrbDkX
         iE6ut1WK9HIu5Le5Va2S8wVWllbq5zVcHY2EM=
Received: by 10.142.142.14 with SMTP id p14mr4229660wfd.114.1216045852934;
        Mon, 14 Jul 2008 07:30:52 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Mon, 14 Jul 2008 07:30:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807141311520.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88428>

On Mon, Jul 14, 2008 at 2:13 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> IMO following the file renames/code moves precisely is really worth the
> time it takes to calculate.  Otherwise, the statistics will not reflect
> what was going on in the project, right?

Ah, I did not mean to imply that it is not worth the time it takes to
calculate, more that I do not know how to implement it that way. Of
course if someone has the time/motivation to do so I would very much
make use of it, but I do not have time to do so myself (at least not
until after GSoC). I can have GitStats just ignore the subtree merge
cases (and say that it is not beyond the scope of my project to take
such into account) and have a working program by the end of GSoC. But
if I spend time on getting this to work instead I might end up with a
program that does follow sub-tree merges but is only half-done, and as
such probably won't receive a "OK" grade. So, yes, I would very much
like to see this, but no time to look into doing so myself until after
GSoC.

-- 
Cheers,

Sverre Rabbelier
