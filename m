From: "Carlos Oliveira" <coliveira@gmail.com>
Subject: RA layer request failed
Date: Mon, 14 Jul 2008 14:41:58 -0400
Message-ID: <3cfdbff10807141141h2a182dd5vc79a6b41bdbea748@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 20:43:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIT0o-0008Pu-6R
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 20:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbYGNSmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 14:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYGNSmC
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 14:42:02 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:8374 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbYGNSmA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 14:42:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2143530fgg.17
        for <git@vger.kernel.org>; Mon, 14 Jul 2008 11:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=nyPv/ytOsVl5Jk5O40b95xf+Ckn6jiQpyGDOGbETROc=;
        b=fgPt3TiE/UQoqEqCP9x0731nAdcbLLK3hZ3vMP5HfzKAkYMfxm4oTxraJvqwcZhZnQ
         7lhQmUSSGjde0lDYlIkOPBvhC3gSa+f64Nv/x9+ozP/DFEJgV9rK6CCvZ3Sg/CvrmGP1
         0f0sePPCJ3wqmRNAmOwgU+paGICKep/alesSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=WCjFqEq449wzXTwpv70BFR8iA58KmBs+AiwfpROexES6KphXnEwGzCUoSTQhhXP69r
         +hhucScEYb0IgCa4MulJ14nwEEj5MLqKFA+Q+BULimSJe5f3nIdQpUe2sfdyygpf0iRX
         /T2QoLYal0EJb0lAIMOTMuAFjfysOrBgaCiks=
Received: by 10.86.68.20 with SMTP id q20mr14820647fga.2.1216060919056;
        Mon, 14 Jul 2008 11:41:59 -0700 (PDT)
Received: by 10.86.92.20 with HTTP; Mon, 14 Jul 2008 11:41:58 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88445>

Hi Everyone,

I am using git svn dcommit, and I am receiving the following message:

RA layer request failed: COPY of <file>: 40 Not Found ... at
/usr/bin/git-svn line 461

This is the first time I see this message after I started using git
svn (I use it a lot).
This all started when I had a interrupted dcommit, which I managed to
rebase to a safe
state.

Does anyone know what this error means, and how I can fix it?

Thanks,
-Carlos
