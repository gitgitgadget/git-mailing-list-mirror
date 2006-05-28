From: Seth Falcon <sethfalcon@gmail.com>
Subject: git-format-patch question
Date: Sun, 28 May 2006 12:31:33 -0700
Message-ID: <m2odxikktm.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 28 21:31:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkQzG-0002k5-IF
	for gcvg-git@gmane.org; Sun, 28 May 2006 21:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWE1Tbg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 15:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWE1Tbg
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 15:31:36 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:5066 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750874AbWE1Tbf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 May 2006 15:31:35 -0400
Received: by nz-out-0102.google.com with SMTP id s18so405084nze
        for <git@vger.kernel.org>; Sun, 28 May 2006 12:31:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=MghTV/JLwtfyHtPr9eVwcsmiRmMJSzfFExk7VgIBq2UHlH1Y3nTfObvmo6h5AYyaA6ickii2o/harFgEw9XXzu7WLoQlFzb8kT95tqr2d5pZdEywePfppYpgZirGhQdHCRF0GdrqsToT4pGx0jWAUty3dnKMMDV/SeQfKt19bd4=
Received: by 10.37.12.56 with SMTP id p56mr2095279nzi;
        Sun, 28 May 2006 12:31:35 -0700 (PDT)
Received: from ziti.fhcrc.org ( [67.171.24.140])
        by mx.gmail.com with ESMTP id m1sm1953067nzf.2006.05.28.12.31.34;
        Sun, 28 May 2006 12:31:34 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20890>

Hi,

A few questions about git-format-patch:

1. When is one supposed to use --signoff?  I gather the answer is
   project specific, but a statement of what's expected for git
   itself would probably help clarify things for me.

2. How should I add extra notes to an email generated using
   git-format-patch?  Is this in the docs somewhere that I missed?  Is
   there a recommended way to do this?

3. Is signoff broken? I get:

    $ git-format-patch --stdout --signoff master
    fatal: unrecognized argument: --signoff  

   When I pass -s instead of --signoff, I get output, but no patch and
   no signoff looking thing.  Without --signoff and without -s, I get
   reasonable looking output.

Thanks,

+ seth
