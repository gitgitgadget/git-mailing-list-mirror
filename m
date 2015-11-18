From: Lars Schneider <larsxschneider@gmail.com>
Subject: Three dot notion used inconsitent?
Date: Wed, 18 Nov 2015 11:31:17 +0100
Message-ID: <1CDF2D38-B73A-4C49-BC10-1F3BA1873733@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 18 11:31:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz01R-0000Nk-JN
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 11:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbbKRKbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 05:31:24 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38600 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbbKRKbV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2015 05:31:21 -0500
Received: by wmec201 with SMTP id c201so66282847wme.1
        for <git@vger.kernel.org>; Wed, 18 Nov 2015 02:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=/5Z0YvH/Hf+hau8VAjpgH1LHmpRl5TM8baDNYPIUxmw=;
        b=qAaUEIq5phcRWPrTjD6fQ1NT4/59gbDKaDTaZLpbQmUtFZbHtmNT94dxQnaOl7yezT
         xGZMZOyqBM7AVVvQ9fZg+Gwg5/MkOW+JIm6WD6Ahsk1v0IE0THg5QCFo5oi0qsNmQDHd
         gCDT6FW+F6cFNYoQn2jPJegxZIrEKZwOL8Qi3gCMjFCNYRm1GRKujodomXb8HSkCyyQr
         lXS7W9OwlSO2fXjYLqhuj8KkeApwv6L64vcWKjJ4PYLMsAMJELPje57giouDecgFetdC
         lifOSjG7hT6Mz/4ZKb/ZR4euOuGgC+u/1Ki8IziJNCqWEvqfLEc0RaHURA74+hEK0SO3
         YfVw==
X-Received: by 10.194.7.69 with SMTP id h5mr976736wja.117.1447842680547;
        Wed, 18 Nov 2015 02:31:20 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id v4sm2141424wjx.18.2015.11.18.02.31.19
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Nov 2015 02:31:19 -0800 (PST)
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281445>

Hi,

I just stumbled across the this:

git diff branchA...branchB
--> gives me the diff between (the common ancestor of A and B) and B. That means I never see changes on branchA.

git log branchA...branchB
--> gives me the commits reachable from A and B. That includes changes from branchA.

Is this because of a design decision that I do not (yet) understand or is this inconsistent for historical reasons?

Thanks,
Lars