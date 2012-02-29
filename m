From: Zdenek Crha <zdenek.crha@gmail.com>
Subject: git archive invocation using sha1 to specify commit
Date: Wed, 29 Feb 2012 08:45:55 +0100
Message-ID: <CA+OUE96-mLc0RJZz0g0oBWxdZKeCMQ9xJbg6DjCacN119TFY+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 29 08:46:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2eEb-0008FT-Kx
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 08:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966138Ab2B2Hp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 02:45:57 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:40325 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966122Ab2B2Hp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 02:45:56 -0500
Received: by qcqw6 with SMTP id w6so1941639qcq.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 23:45:56 -0800 (PST)
Received-SPF: pass (google.com: domain of zdenek.crha@gmail.com designates 10.224.111.142 as permitted sender) client-ip=10.224.111.142;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of zdenek.crha@gmail.com designates 10.224.111.142 as permitted sender) smtp.mail=zdenek.crha@gmail.com; dkim=pass header.i=zdenek.crha@gmail.com
Received: from mr.google.com ([10.224.111.142])
        by 10.224.111.142 with SMTP id s14mr1188763qap.78.1330501556010 (num_hops = 1);
        Tue, 28 Feb 2012 23:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ygU0kVVbQMxKx54/y6u4xnGikTN4IOZ1As6+FPlo7+o=;
        b=UrexE1Xgk2SuoW0GvTsuZAfQrV7Ds+APyZvzgjvGFIZl2NAmR8oC3EV1rfZgsMxUzY
         VsUGhjxAkzuyfHeAr8yZsyKcFq1JS6XlI0Vkj4ZHyjK5fE9aeWrgNhDXsuU+pLLc/aO8
         D6n87unMjL9iv4W+4EMofJ8NCwnw4hSQqty64=
Received: by 10.224.111.142 with SMTP id s14mr969507qap.78.1330501555868; Tue,
 28 Feb 2012 23:45:55 -0800 (PST)
Received: by 10.224.120.145 with HTTP; Tue, 28 Feb 2012 23:45:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191815>

CC me on answers please, since I'm not subscribed to the list

Hello,

I would like to ask a question about commit restriction added to git
archive by commit (ee27ca4a: archive: don't let remote clients get
unreachable commits, 2011-11-17) and following efforts to loosen them
a bit.

In out company we are using git together with source indexing. We
store a git command for retrieval of source code file that was used
for building into pdb file(s). Currently, we are using an invocation
of git archive with --remote parameter and commit sha1 to export
exactly the source code that was used for build.

The above mentioned commit removed possibility to do that. I have read
about efforts to loosen the restrictions,
but I'm not sure whenever ability to export arbitrary sha1 will be
allowed too. Can anybody clarify that for me please?

Regards,
Zdenek Crha
