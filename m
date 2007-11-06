From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: git-rev-list diff options broken
Date: Tue, 6 Nov 2007 19:15:38 -0300
Message-ID: <f329bf540711061415w30fd069fi19adeccf45735ccf@mail.gmail.com>
References: <f329bf540711061414k1627521bvaf4a7a06460cc3fd@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 23:15:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpWiA-0001Q2-LI
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 23:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281AbXKFWPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 17:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754139AbXKFWPk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 17:15:40 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:26734 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbXKFWPj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 17:15:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2583450wah
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 14:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MyRrMc+nTRm03fCZDyHA2DFUX4fnCWwGKceU/osp5k8=;
        b=IAPteggGd0hdXIs1IMVhzlGdRZg8j1OLvdvNA7RLq7MDNM04stFz8eFQSK+3t6q3JNSxDlugQE/qma0sNZCw9pMSj+L3nfX7gPXZ4j9AannraNr4C0OMXsy//AeZkWuFXMxK1if1pBVuRCOjQD4Qq1uwB+UPbnYs+yr5pfs+W8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZBQP3KTT9945SrmlgtUIAMAX469y+SDAjn21BwScQpiq6lNaxo2Pb4xPVyo3DCSTJaOl+XFc2E+wVN39hIbUzz1VrX3I2GrAHZL3+Qwr0531iwPoqpH+uTF66wztY8mIVx5Czoa+SKmLE+HpZoI17ihAhgvwsSlAVHM5XtsFrp4=
Received: by 10.114.125.2 with SMTP id x2mr874410wac.1194387338484;
        Tue, 06 Nov 2007 14:15:38 -0800 (PST)
Received: by 10.114.76.4 with HTTP; Tue, 6 Nov 2007 14:15:38 -0800 (PST)
In-Reply-To: <f329bf540711061414k1627521bvaf4a7a06460cc3fd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63737>

2007/11/6, Han-Wen Nienhuys <hanwenn@gmail.com>:
> so any attempt at showing diffs with git-rev-list will fail. What's
> the deal with this?

this is with

  git version 1.5.3.5.576.gfe6193

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
