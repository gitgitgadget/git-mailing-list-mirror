From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/2] user-manual: use standarized quoting
Date: Sat, 23 Jan 2010 02:18:53 +0200
Message-ID: <1264205935-19203-1-git-send-email-felipe.contreras@gmail.com>
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:22:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTm9-0000m1-1Q
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755724Ab0AWAVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190Ab0AWAUl
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:20:41 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44817 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755482Ab0AWATC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:19:02 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so1544233bwz.21
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ljBBQq4Qe1Rh+feIvQ9DgsGbT50/9Ux6gjmVf+fjF98=;
        b=iM18xx85rpLwRdhcXzlTbuPmjtEKFhepjiBkCd17OQk1VQC0LPU1Mox6rSGXe5Qema
         VJNSY/LJZJQjkQjSgAWx2jDZgPjj9ENqnA5wwW3vpcr2Sv4j+HR5nEYix0PcrcVHNf5Y
         OEXERaP4VfDCm/8+SrTHYn4Wh6sUfNgnX+Lpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=l77qZyvrenDUzLrHgiEYRLCfrdusvGOlbxe8VCztSBquKWkhGZxRWcIH3o6grEz+Q9
         js7DkM8e18zAOsAQ0RkSw+EdRNFC1LmXOks2UxUSYsuAlAqkTF5AAmblOlJPafdeFL96
         UgiM31VnL06JWMf8wcwXRI3Qp4Xfuo+9aJ8UY=
Received: by 10.204.160.67 with SMTP id m3mr621677bkx.51.1264205941148;
        Fri, 22 Jan 2010 16:19:01 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 15sm1229066bwz.12.2010.01.22.16.18.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:19:00 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137795>

Hi,

This is a big patch that was sent before, but now I'm explaining my rationale
for the quoting style I used. I noticed a few deviations on my own rules, so I
fixed them.

It's exactly the same as the previous, but since the server silently dropped
the mail, I splitted the patch in 2.

What do you think?

Felipe Contreras (2):
  user-manual: general quoting improvements (p1)
  user-manual: general quoting improvements (p2)

 Documentation/user-manual.txt |  884 ++++++++++++++++++++--------------------
 1 files changed, 442 insertions(+), 442 deletions(-)
