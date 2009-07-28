From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/3 v2] Use an external program to implement fetching with 
	curl
Date: Tue, 28 Jul 2009 15:30:13 +0200
Message-ID: <40aa078e0907280630p7751c3d9m639e63e7700a8819@mail.gmail.com>
References: <alpine.LNX.2.00.0907280207350.2147@iabervon.org>
	 <alpine.DEB.1.00.0907281505290.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 28 15:30:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVml9-00035F-AZ
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 15:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbZG1NaQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 09:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbZG1NaP
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 09:30:15 -0400
Received: from mail-bw0-f221.google.com ([209.85.218.221]:36934 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbZG1NaO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 09:30:14 -0400
Received: by bwz21 with SMTP id 21so15328bwz.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Gm9ns3ZXNAmzmiIuvVSFkbgRvSS+JkP1bwRLmoF4HxQ=;
        b=xusmARFMvpjhLFimmrn6co55lbgm0+PtF/CCTZ4lu21gdZsSQs5ht8siyBhRzI9kIM
         nna1Nza1pnbg1ff8RJ/Bo1d1zhQPagBs31mpgZmTbb1gQa41sVhje6ND4UD+Yk8nCW7w
         tJ/vDB2tI6uDbWYB5pfthxNbSGHTzw5kGNHrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NX8YC7chBPHuYQkxOzWVpGrtVH2yHwLNxtU4Uy58sZuwHnt7N6bSRHRMiMUBTlEcZo
         R4y4hqBCebKzenbcsWormZ9iVfCSmJCTEEBlP9ocmQcPs6HcN9u0YmNWXnSLCRVpcV9j
         rHwSnd0MmXWeBPnmWzOlJHVS6hSIIS6QWezQ0=
Received: by 10.204.76.199 with SMTP id d7mr4090578bkk.84.1248787814001; Tue, 
	28 Jul 2009 06:30:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0907281505290.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124251>

On Tue, Jul 28, 2009 at 3:19 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> If you already start some infrastructure like this, you should go the
> whole nine yards and make helper functions in remote.c or transport.c that
> help implementing "git-remote-<protocol>" helpers.

You mean helper-helpers? :)

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
