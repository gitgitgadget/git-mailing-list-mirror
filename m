From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: Conforming to pep8
Date: Thu, 08 May 2014 21:10:25 -0500
Message-ID: <536c3911ea173_741a161d310f2@nysa.notmuch>
References: <20140509015429.GA550@wst420>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: William Giokas <1007380@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 04:21:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiaR8-0001vG-2C
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 04:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbaEICVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 22:21:17 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:49927 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043AbaEICVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 22:21:16 -0400
Received: by mail-yk0-f176.google.com with SMTP id q9so2948721ykb.7
        for <git@vger.kernel.org>; Thu, 08 May 2014 19:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=1lRF35gIV59FgYyt5FpSHHJC7JmWD/UtLC0K9AWa2DI=;
        b=BKKliQzQ7gLmVfnSMFsoKy7OlFgx16gMdp09uwIfyLQINpSKnTuiNQRUDjLcBKPEfD
         azjNhMBbsMIONZ/l/7GzqVSsnMzHj1MADqy6i5Oj/LC/LvOWh0mQfZNqoU0ceTyLkstV
         DbcsmEk2jN6KyRMWdUrtEPK6uLYj56T1jksalRziePvMbqtZmcrVh79C477SjRTk95P0
         zah0mTWNUsk43ZFcZbH2CHV2B1KDlJkbQ0yCL1IGiVzP44vfQctpukEDyIbic2khl/ot
         0Ru1O4OypAe6bEacxbG3ptpwx+PlqA84tep1E7OPrIrAfhIAkui58psy5e+FAwAU4Rl4
         pe5A==
X-Received: by 10.236.140.16 with SMTP id d16mr10729958yhj.55.1399602075602;
        Thu, 08 May 2014 19:21:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id w47sm4149186yhk.47.2014.05.08.19.21.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 19:21:14 -0700 (PDT)
In-Reply-To: <20140509015429.GA550@wst420>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248504>

William Giokas wrote:
> Which is a whole bunch of errors and warnings thrown by pep8. Is pep8
> just getting put by the wayside? I would much rather have these
> scripts conform to that and have an actual coding style rather than
> just be a hodge-podge of different styles.

Personally I try to follow pep8 in git-remote-{hg,bzr}, but only to some
extent.

I do this:

  [pep8]
  ignore = E401,E302,E201,E202,E203,E126,E128
  max-line-length = 160

That said there's a couple of issues present that I didn't notice.
Thanks for checking.

-- 
Felipe Contreras
