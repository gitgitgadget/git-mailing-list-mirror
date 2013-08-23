From: Corey Thompson <cmtptr@gmail.com>
Subject: git-p4 out of memory for very large repository
Date: Thu, 22 Aug 2013 21:12:45 -0400
Message-ID: <20130823011245.GA7693@jerec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 23 03:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCfvs-00051v-O4
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 03:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188Ab3HWBMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Aug 2013 21:12:52 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:34689 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab3HWBMw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Aug 2013 21:12:52 -0400
Received: by mail-yh0-f48.google.com with SMTP id f73so3047yha.35
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 18:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=Wd2YsC8tVM5/keAqvW9sysHJpOegJBYP3w6+B5p8BXo=;
        b=JpaWH8ynAmvv9qnR1kicVpVauQTZIL5iRfZ9/UNSed1jw2a0efCiVj7c9nYbaCgGLx
         25K6Y2KcvA2nvh9XSocFDlYUX10DEEZvz2liQ2IWj5vPR6iWtkWqPrki+gms7kr5i/um
         Vkox5GFTZqA8fbVgl6Bn/LNLMUR/OfzN0f+mfYj5JocmyhiEbk+Ww9W2hoqGZHltmzTj
         X+657xQlQpWg8JD1mUWYnrnHHcr/1TUlSQrxI24ah/7M6liQ9AWSZsVqnhWzPk5LlJjO
         JPaJ0imVgbp6k+jTNiljJ2wSj9SyXhbkzwvpnos1xzWbP9CLt19XJiXm45wjj5T6gMRA
         uJ4Q==
X-Received: by 10.236.53.164 with SMTP id g24mr12904524yhc.18.1377220371624;
        Thu, 22 Aug 2013 18:12:51 -0700 (PDT)
Received: from jerec (c-71-59-19-88.hsd1.ga.comcast.net. [71.59.19.88])
        by mx.google.com with ESMTPSA id s9sm17724180yhb.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 22 Aug 2013 18:12:50 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232795>

Hello,

Has anyone actually gotten git-p4 to clone a large Perforce repository?
I have one codebase in particular that gets to about 67%, then
consistently gets get-fast-import (and often times a few other
processes) killed by the OOM killer.

I've found some patches out there that claim to resolve this, but
they're all for versions of git-p4.py from several years ago.  Not only
will they not apply cleanly, but as far as I can tell the issues that
these patches are meant to address aren't in the current version,
anyway.

Any suggestions would be greatly appreciated.

Thanks,
Corey
