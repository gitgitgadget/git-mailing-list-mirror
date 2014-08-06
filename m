From: Robert P Fischer <rpf2116@columbia.edu>
Subject: Apple violating git LGPL?
Date: Wed, 6 Aug 2014 14:10:08 -0400
Message-ID: <CAC_jL3wO9jkE4HapvJjn-4uW4RtSxubFthrxzQJ87EQ4Gq-9Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 06 20:10:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF5fG-000815-QR
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 20:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754425AbaHFSKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 14:10:11 -0400
Received: from buckwheat.cc.columbia.edu ([128.59.72.251]:40181 "EHLO
	buckwheat.cc.columbia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420AbaHFSKK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 14:10:10 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by buckwheat.cc.columbia.edu (8.13.8/8.13.8) with ESMTP id s76I9lKv000742
	for <git@vger.kernel.org>; Wed, 6 Aug 2014 14:10:09 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id C1BD538
	for <git@vger.kernel.org>; Wed,  6 Aug 2014 14:10:09 -0400 (EDT)
Received: from tarap.cc.columbia.edu (tarap.cc.columbia.edu [128.59.29.7])
	by hazelnut (Postfix) with ESMTP id B660F38
	for <git@vger.kernel.org>; Wed,  6 Aug 2014 14:10:09 -0400 (EDT)
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com [209.85.192.45])
	by tarap.cc.columbia.edu (8.14.4/8.14.3) with ESMTP id s76IA9dQ029158
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 6 Aug 2014 14:10:09 -0400 (EDT)
Received: by mail-qg0-f45.google.com with SMTP id f51so3124157qge.18
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 11:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=sVbK1ttqOCJf2EOHPJXmqSi3wUHfmyCiemKUWEVhyBE=;
        b=BLMmYYmuD83TEp7TJmTia7mOCRfDrleaGmFKFRVcuWNaSSEzZwu9W1Aov4MW6ZmgTr
         /WsuRS4JOiThd7YNPzBgdZnI62oTvlpBzTxeTOO3IszsL9heLt6Sh8CEpBbZvJ/UJRoz
         4sxrWJIa+zjny7wyUej3L8wac8dW/AZlv5gTLLbUPNTXe6Vp44+rDKIDdISCinClxKli
         6PysX75o0rVXuCJerTV1Ix/CH5W9WCcvmT8GFXibEE/wmZ/7y7tml1qm9EFQmBhmwuJo
         DIoi6aqsf3MDUS9Q1LIWoyHROVXbK0aJ2CCHVHC38M+du45Ot7nacOJQQVPj9iEyJCI5
         5UOg==
X-Gm-Message-State: ALoCoQn1cuEm4OLJNvURKlhniVm+2t3plnFH3BcoVH/Tie1fnOPUW2oHiGeTc28oRu4YmTdRREqW7G96UDAPhKOAeNJocCVBPdapxmetBVOmUwwp5KTfBOA=
X-Received: by 10.140.97.131 with SMTP id m3mr5645006qge.80.1407348609119;
        Wed, 06 Aug 2014 11:10:09 -0700 (PDT)
X-Received: by 10.140.97.131 with SMTP id m3mr5644961qge.80.1407348608812;
 Wed, 06 Aug 2014 11:10:08 -0700 (PDT)
Received: by 10.224.176.17 with HTTP; Wed, 6 Aug 2014 11:10:08 -0700 (PDT)
X-No-Spam-Score: Local
X-Scanned-By: MIMEDefang 2.68 on 128.59.29.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254884>

Hello,

I ran git on my newly-set-up OS X Mavericks machine, and get:

        $ git
         Agreeing to the Xcode/iOS license requires admin privileges,
please re-run as root via sudo.

Running 'git --verision' gives the same result.  This seems
problematic in a few ways, and I am wondering if the git community is
interested in addressing it:

1. Why do I have to agree to Apple's licensing terms to use an LGPL
program?  Is this appropriate?  Is it allowed under the LGPL?

2. This is a significant problem for me, because I'm using a work
machine and do not have admin access.

3. The version of git I ran is clearly NOT a plain vanilla "official"
git, it is a derivative work.  Has Apple provided the source code of
the special version that I just ran?  If not, that would seem to be a
violation of the LGPL.

Thanks,
Bob
