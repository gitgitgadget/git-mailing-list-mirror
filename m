From: Francis Moreau <francis.moro@gmail.com>
Subject: How to retrieve the rewritten list like the one made by git-rebase
Date: Tue, 29 Oct 2013 12:00:10 +0100
Message-ID: <CAC9WiBjC1VnzQFwvpK=Bgy2aE86QZHEUFqpg6ikzApaz0NvyLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 29 12:00:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb724-0008RS-1e
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 12:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616Ab3J2LAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 07:00:12 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:63548 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab3J2LAL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 07:00:11 -0400
Received: by mail-vc0-f171.google.com with SMTP id ik5so1233190vcb.30
        for <git@vger.kernel.org>; Tue, 29 Oct 2013 04:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=qQbgmK8oaKoe0TB07C1RgJ8M/Wz245J78uXtyylgIGg=;
        b=J5LRC1rySCmh3EIPPmlpH+JvRZq8ES1LPubL/7aOYvNPJA+6Pa1VX+8JHhDpcPCX1I
         wCEQNLNxHWKv+2fiF+pLusHKCLGqO8cfloMBVFKbNZXKGSCoVOD/PT7ZnVddtftFRm/E
         uCPfslKRxwfeJnRZx5GyTg3w60cqFl2vBtnSkcAmfOb0B4XN3Lo7/edcoE3J2zD3R1hR
         pi+XX5++8Nm/sFXsPZk7We8E1YYHmuokdXbQmEEh/I/pr7sfDNHDpgTlDo97zL0+Edyu
         EJCuN8V3kDfoa1RGG3nR+eipg4oKgGrT9KsteHO1J1+MN1rr3XuBnUwTQnYn1N4SZE6+
         aKsg==
X-Received: by 10.52.106.201 with SMTP id gw9mr686804vdb.49.1383044410984;
 Tue, 29 Oct 2013 04:00:10 -0700 (PDT)
Received: by 10.58.218.39 with HTTP; Tue, 29 Oct 2013 04:00:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236922>

Hello,

I'd like to get a similar rewritten list than the one that git-rebase
pass to the post-rewrite hook.

Is there any ways to do that without using the post-rewrite hook ?

Thanks
-- 
Francis
