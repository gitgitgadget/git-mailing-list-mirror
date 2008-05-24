From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: git-diff cr/nl files on linux
Date: Sat, 24 May 2008 19:54:09 +0700
Message-ID: <fcaeb9bf0805240554j71693d5eo2a425ee0efe2f364@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 24 14:55:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JztH6-0003XH-UE
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 14:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbYEXMyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 08:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYEXMyL
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 08:54:11 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:11351 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbYEXMyK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 08:54:10 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1066822fkq.5
        for <git@vger.kernel.org>; Sat, 24 May 2008 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=uEvKM2NVO++QTLWfalUAg4iWnoVJwdGRwBz7yjTw5BU=;
        b=s0itldsAeDfGtMyVMNncemFE3fB8jqbYadwyws7e9ahtPj5TNubqfkL8fKcxsnuGZDJfwUyRsR2gUmJT2E2kAimYHVLm2Rrzpi/+j5U6zMnX0NN7SQpzKY8PGksnPq6UvaPy9q06subNQYKdJOEGp9FiKp3axlQetHr7lDGMVO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cughQvFwEKy4MArTrx5RBiY6DVPAM3fqjOjSQHtSdEabQLAzLihvHqe+WvjngkuAHhO26Q3fFiMTvpELsdlZa+eLPA6BYc49jP9fxgqBYbQMr2pa+qgdAvrHHfdOO8+mV2UT09FsWgukzrMGLeGojWi9jSSSUyN1DsohmycwXLE=
Received: by 10.86.98.18 with SMTP id v18mr910750fgb.31.1211633649092;
        Sat, 24 May 2008 05:54:09 -0700 (PDT)
Received: by 10.86.62.13 with HTTP; Sat, 24 May 2008 05:54:09 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82812>

Hi,

Is there any way that can make git-diff show cr/nl ending files on
linux without ^M at the end?

Thanks
-- 
Duy
