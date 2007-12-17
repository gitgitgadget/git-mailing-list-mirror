From: "Gerald Gutierrez" <ggmlfs@gmail.com>
Subject: RE: git with custom diff for commits
Date: Mon, 17 Dec 2007 15:27:11 -0800
Message-ID: <002901c84104$6149cbc0$02fdfea9@na.acco.com>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com> <Pine.LNX.4.64.0712172300510.9446@racer.site> <vpq1w9kaphg.fsf@bauges.imag.fr> <Pine.LNX.4.64.0712172310090.9446@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
	"'Matthieu Moy'" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:26:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4PME-0005SO-7m
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763563AbXLQX0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757500AbXLQX0L
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:26:11 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:16768 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758519AbXLQX0K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:26:10 -0500
Received: by wr-out-0506.google.com with SMTP id c49so1471759wra.1
        for <git@vger.kernel.org>; Mon, 17 Dec 2007 15:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        bh=WjQLxjMtMAjjNX/4wDzeQIka44IK30D/popBto1X31s=;
        b=yGszxuBd3Z1c8houMSqzdo+Zz/dQWMOD9T/GeKzpbgpfwS03tiW1mrtauSqEPRPPs0Vf9pbaBf6tmTiTQrknbSJVxp1Gy0rTBmDJJPiKNMGOmYtzl42ZwKXnLr0NaFcE+Au/sUJpjWLTn4e/i0GtWF6iVYy0Wczr/cryt0Wbte8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:references:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=kn9K9M/+JTjN4qYByMasBPCd3Kw9XE+Wh0nQvga56rX0Quhh0IMk1ePACzHjCjE8ryc/+07K8ekmje55ED7k6AXfTy0sXyChCOIyfJQyoalHqQYMyh2AO3DoJAB0GGGfQb19qntm78BNirJG+RJeGMn3pGP5qEsKRy6mYtiFPPo=
Received: by 10.150.138.8 with SMTP id l8mr2643613ybd.72.1197933966792;
        Mon, 17 Dec 2007 15:26:06 -0800 (PST)
Received: from BURGXGUTIERNB ( [63.87.154.251])
        by mx.google.com with ESMTPS id k3sm6056593rog.2007.12.17.15.26.03
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 17 Dec 2007 15:26:06 -0800 (PST)
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <Pine.LNX.4.64.0712172310090.9446@racer.site>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Thread-Index: AchBAkHQnAD4vuLIT8mPy1HYw9r6mAAAdt4Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68661>

 
> Ah, right.  I completely missed that you were talking about 
> git-commit, not git-log on git commits.
> 
> Yes, setting up a "clean" filter that removes the timestamps 
> is probably the reasonable thing to do here.

I read about the filter too, but have no idea how to implement it. Any
examples that I could follow?

Thanks,
Gerald.
