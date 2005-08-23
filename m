From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: [RFC] cg-log -r order:matters
Date: Tue, 23 Aug 2005 23:12:58 +1200
Message-ID: <46a038f905082304126e8ecd65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 23 13:13:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7WiG-0000Pj-3p
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 13:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVHWLNA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 07:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVHWLNA
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 07:13:00 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:54003 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932126AbVHWLM7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 07:12:59 -0400
Received: by rproxy.gmail.com with SMTP id i8so1133711rne
        for <git@vger.kernel.org>; Tue, 23 Aug 2005 04:12:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kPpwVK7qFQVtxza+iXa/N37CPfIiY23XRx21RMP01tOgUnvWahrK5V1TF6BkwRhYC2Y/+r5gCf+8mflT9p3z/fa8gBu4c47TAj4zjmH76oULSxtfcDLII1xYOC1XQ4EKApaIVgy1UYGdK5IESSYaT94z2PWZKxhFcGB9n18CMJ4=
Received: by 10.38.75.28 with SMTP id x28mr380381rna;
        Tue, 23 Aug 2005 04:12:58 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Tue, 23 Aug 2005 04:12:58 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It's sometimes unclear which head is "ahead" of the other. If I get
the order wrong, cg-log shows no log output. Is this expected?

I was expecting a warning, or a reverse-ordered log. Or both. ;)


martin
