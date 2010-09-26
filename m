From: Jon Seymour <jon.seymour@gmail.com>
Subject: [RE: v6 0/4] rev-parse: allow --flags to output rev-parse-like flags
Date: Sun, 26 Sep 2010 11:24:20 +1000
Message-ID: <AANLkTinuM=TiNC-AhcnNyQdh+AFij4jNU=bBqjJ0HXbC@mail.gmail.com>
References: <1285431515-21321-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com
X-From: git-owner@vger.kernel.org Sun Sep 26 03:24:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozfyd-0005OA-NU
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 03:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab0IZBYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 21:24:22 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49998 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab0IZBYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 21:24:21 -0400
Received: by qyk33 with SMTP id 33so5867557qyk.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 18:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=vjP1z3MPQLW7fhRA+pThOqFGV4EKnZMTLdC0FC83bsg=;
        b=ak1DUgJM9czb6R201oAWhownqaQ5K3Ap8wDPX61NFUpOMjkgfi8zAqtnnSJkYDQgRw
         rfMsxGT7Xxl5h0rJzhlECcvc/x0J6TF3R5iXEC+nvFa9NnoSH2giVmkmYpuXXxBup2Cv
         diIuRZPI/Fg3Vzt9lsxEC2GWjfy2ZZ94LlxUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MwoZA+WkXxOtIDtU93VqLvF0R6687enfCXp9lIGGkZnG/PjzgN+5GZym7SsK4M4gKE
         Rw6pZurp0WD2KDOd7VcpaCf08647jcWIIR/cVV+LcoTbbL59RBeMXlivJ28H+A1f46MZ
         j78UpY7jo2+O4xZOk1MoKPvQ4c9MnhR1dY5dY=
Received: by 10.224.28.134 with SMTP id m6mr3952292qac.86.1285464260680; Sat,
 25 Sep 2010 18:24:20 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Sat, 25 Sep 2010 18:24:20 -0700 (PDT)
In-Reply-To: <1285431515-21321-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157207>

Those interested in the latest version of this series can poll
the stop-interpreting-after-flags branch on git://github.com/jonseymour/git.git

I have tagged v6 which is re-organized slightly w.r.t v5 so that tests
and documentation of existing behaviour are cleanly separated from
proposed changes.

I will post another version of this series to the list if/when I
receive additional
feedback or a final ack.

Regards,

jon seymour.
