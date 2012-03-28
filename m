From: Bo Chen <chen@chenirvine.org>
Subject: GSoC - Some questions on the idea of "Better big-file support".
Date: Wed, 28 Mar 2012 00:38:05 -0400
Message-ID: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 06:38:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCkeF-0002LG-Um
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 06:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146Ab2C1EiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 00:38:07 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51676 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab2C1EiG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 00:38:06 -0400
Received: by wibhq7 with SMTP id hq7so538010wib.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 21:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:date:message-id:subject:from:to:cc
         :content-type:x-gm-message-state;
        bh=ML69xS6Rdo+pqc/g9XUzfvhOO2xx8lH/uccv8rDz7aA=;
        b=jvf7avWW9fJbvtt/fMX5U3EYldpuPTCt1CuMFsh3bNExHVCfLY2weIY0E+o6MCu68W
         j8le9hStHpIxV5mRwcdtku7HPPdt59D0XaLaKKRxZxCmpSk0G8Zx0h0kg5Gdd2KvU1sC
         qCwW25BjI0ikot0d/R95wBA+yRoKlRTxscE8wHuqoFurjC1yOXPavn6E10QIAGj1IcNf
         0FfSButcHeqMFnZMIv13wkgai7c82CgLVJ6WeRoEMx70HXN7es02U3rw7bUXAxXysCvR
         lRLdqaeRBPBzZkl781B2Dp5JrifVksLMRI2P3F6h+LoWKYK6SVDecHs5lrIVV2Z68nbV
         8M4w==
Received: by 10.180.88.169 with SMTP id bh9mr3507694wib.5.1332909485025; Tue,
 27 Mar 2012 21:38:05 -0700 (PDT)
Received: by 10.180.81.70 with HTTP; Tue, 27 Mar 2012 21:38:05 -0700 (PDT)
X-Originating-IP: [69.248.109.119]
X-Gm-Message-State: ALoCoQlEuXASgS2sS1Nchv0cHtk5t8O6VPPBHKbrKTR4kC5fkAsYNETkpw5Zz8tpT51HqrBNFW3O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194106>

Hi, Everyone. This is Bo Chen. I am interested in the idea of "Better
big-file support".

As it is described in the idea page,
"Many large files (like media) do not delta very well. However, some
do (like VM disk images). Git could split large objects into smaller
chunks, similar to bup, and find deltas between these much more
manageable chunks. There are some preliminary patches in this
direction, but they are in need of review and expansion."

Can anyone elaborate a little bit why many large files do not delta
very well? Is it a general problem or a specific problem just for Git?
I am really new to Git, can anyone give me some hints on which source
codes I should read to learn more about the current code on delta
operation? It is said that "there are some preliminary patches in this
direction", where can I find these patches?

I will appreciate it if anyone can offer some help.

Thanks.

Bo Chen
