From: "Matt McClure" <mlm@aya.yale.edu>
Subject: tests for git-p4
Date: Sat, 12 Jul 2008 08:24:10 -0400
Message-ID: <e48c5e540807120524rabdcfa6vd91c16ef1b0f80a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 12 14:25:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHeAA-0002ux-IG
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 14:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbYGLMYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 08:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbYGLMYQ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 08:24:16 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:27241 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbYGLMYP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 08:24:15 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2224577fkq.5
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 05:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=hYBESjGbq+EMeYAvSiOwtBjyVGJF3DzrnKoONOuyUlI=;
        b=cqmaW3afDLnvhJEIO9D03BWuwiz/de5wsYnqn2umu26kOAYsPvBO3RrfwmHrDWzKzT
         mCt+gBtQ2enmFgjdPPIjoegks7ccAy4xK2nct0wglFsrLkiI0+dz3jIidvBpWvMxI7EW
         9Ls2UiAriD7SeCjrxqDQc4/FaonBvjK1kluIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=cNttYImzv0M4FoZftJ81cZ4iLi99w50Xz8lmfX8en7jITdMHxlEQg7yEx1tBDK3QdR
         eF/LTptyPbTz1c2wq3/29fJ9igxSEiS7ylmTnqLGTxh5PXF4mkGq2DPRZGqZp3uW3XvV
         aJe5LA4RiJutqgTFqleYRiwRHT1onwaR2eHfA=
Received: by 10.86.49.13 with SMTP id w13mr11390287fgw.65.1215865450646;
        Sat, 12 Jul 2008 05:24:10 -0700 (PDT)
Received: by 10.86.2.12 with HTTP; Sat, 12 Jul 2008 05:24:10 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: b47c7c9d93d3a924
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88236>

I'm planning to write a "p4-fast-export" that will facilitate using
Bazaar on projects maintained in Perforce.  I'd like to reuse code
from git-p4 since it appears to have much of the functionality I want.
 In fact, the main reason I can't just use git-p4 today is that it
does too much: it pushes the Perforce fast-export representation
directly into Git.  I'm going to work on covering the existing
functionality in tests before I start modifying the code, and I could
try to write those tests such that they'll be useful to the Git
project as well.

Would my tests be of interest to git-p4's authors?  Is there any
existing test framework for git-p4 that I missed?

Matt
