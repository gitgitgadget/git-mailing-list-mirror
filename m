From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies allow, never, and only
Date: Mon, 10 Mar 2008 19:18:47 -0800
Message-ID: <402c10cd0803102018k2f1dd9e0k6b766671f36ff5f0@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 04:20:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYv21-0001R3-Cq
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 04:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbYCKDSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 23:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbYCKDSz
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 23:18:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:17648 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbYCKDSt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 23:18:49 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2215511fga.17
        for <git@vger.kernel.org>; Mon, 10 Mar 2008 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IdANFaNcRdZKj8KJRLDq+2ZZjI+5UgIRYn9rIvhE2ks=;
        b=nbuExm9fOARppvCF2UFAXXgBpJLzCkdwX9QLV60AkRw3HBnsREDf5XqQ4O7/p5qNeJl7Tvmx3CWPLGJWqRRaliAushm3LoIszQf9yFQPikzSIDeYqSZg9gPeCJSsETBPcKmf4h5DQ/PVaE5babvS39GrL487E5ur7EWpoXjdEFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LirgGMN1ax22RtrZWfuo4oggZ3dS1v7ithGCpdxg01vONe4vVLbR8qWwnUhJVvteXc6KLDLDnHT2Dy13jDu7AIPiJA2FGDke6dd2JDFtR1oIGcp30Gxq4EVAJs+2r6AglVnczU5rg5tLVpIORQfuXstdh8E2BIFyVi9iPo48IVc=
Received: by 10.82.121.15 with SMTP id t15mr15067868buc.8.1205205527695;
        Mon, 10 Mar 2008 20:18:47 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Mon, 10 Mar 2008 20:18:47 -0700 (PDT)
In-Reply-To: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76789>

Hi,

I have split the original patch I had for the fast forward strategies
in two.  I hope to get something close to this patch accepted.  I need
this feature for the Accurev integration I am working on.  I will be
able to spend time on this the next two weeks.

-- 
Sverre Hvammen Johansen
