From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Created branch in wrong place... how to fix?
Date: Wed, 1 Jun 2011 13:47:12 +0100
Message-ID: <BANLkTingMK3Zv6NZdFAiLXZzJpSZYZmjQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 14:47:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRkpu-00023j-Ij
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 14:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161749Ab1FAMrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 08:47:19 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50648 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161715Ab1FAMrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 08:47:15 -0400
Received: by gyd10 with SMTP id 10so2174859gyd.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 05:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=5IG97LxULdoM7sFhOd3wb4AD+O6uKx53dC33kK3KS2I=;
        b=Pkdo9hAoxGmqhO4Uw3+gXHP+UZm/l00zCeiNtIdIZd4+xwYRoYQxrn/A5UBgGiNXz0
         UZAtVLihqHNbZCrydU+z5jB1gK2isH+Ws38qaz/PZ5UJ5/I+6GYnkeTwEFkMP7KyNiRo
         dAclknB/dLnMBVAoqyihFV6E1fFjBoBzUqsYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=UEbGODBL1/+P9XBOAVR89YO4NpxsFUT7JiGxqgHrJLhKWMey2FXyEyXOu7U9K8leen
         IDU+1He1YYISStY7w2K1eIXuNEsSeqr6NIgNEo1r/CIFNU4d/kqlHsd4bpu+kwC9RiFh
         eJN9iR/eBqTOcv2m4r8RO27L0A+7VtOk2qFlQ=
Received: by 10.90.239.17 with SMTP id m17mr6075607agh.138.1306932432962; Wed,
 01 Jun 2011 05:47:12 -0700 (PDT)
Received: by 10.90.116.15 with HTTP; Wed, 1 Jun 2011 05:47:12 -0700 (PDT)
X-Google-Sender-Auth: tpiufumBbaoH_2WYC_hgX8AGaIE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174864>

Hi,
I created a branch in a project and did a series of commits. I now
discover that I really wanted to make all those changes against a
completely different branch of the same project. There shouldn't be
any issues as the branch introduces entirely new files (no changes to
existing code).
I'm struggling to see a way to do this without loosing the history.
Some Google'ing suggests 'rebase --onto' but I'm struggling to see how
this works or if it is appropriate. Any pointers much appreciated :)
Thanks.
