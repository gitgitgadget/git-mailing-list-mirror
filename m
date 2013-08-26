From: Bruce Korb <bruce.korb@gmail.com>
Subject: git-svn - canonicalize: Assertion `*src != '/'' failed.
Date: Mon, 26 Aug 2013 10:16:17 -0700
Message-ID: <521B8D61.8040608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: GIT Development <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 26 19:16:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE0Ov-0005Wa-O6
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 19:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576Ab3HZRQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 13:16:22 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:61930 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab3HZRQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 13:16:21 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so3644645pbc.8
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 10:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=n3FPGGSUDJkSWQd27valM/phoYx6RF6jNjA8AAPWx58=;
        b=SDSGUgagrcAtS4QFNc84kHm1XFfErp4yWm2lVTlDGVF7WLXG3FR2yNQfk7A5T6/ieS
         2RyvmQB3anPcz8XbpBtvB4KZNxmQLPnyuiykrtPamSFf2M0GtaxwY7WZXBrLk+tQqJw+
         VnwlsArz5pwj6NjHpHpQ0fCVhUxVnHbtscRXMRRiGX9dx4KM0x2/riMoITNTw5b7s4iJ
         riNeZntE3h7rXYafQSec1K19K8HPuc4ZMzv9NCgn+vOefX3Urro6MD3Wqllb87W2Uc9D
         yc+f4HE1S3j4eYanRiZehmQrh7mrtU23Gf2XgwlW8TqiKBQ/zL4/usNautgJo10lkyKm
         KFbg==
X-Received: by 10.66.155.36 with SMTP id vt4mr15699129pab.93.1377537380902;
        Mon, 26 Aug 2013 10:16:20 -0700 (PDT)
Received: from [192.168.10.2] (adsl-76-254-30-67.dsl.pltn13.sbcglobal.net. [76.254.30.67])
        by mx.google.com with ESMTPSA id iu10sm21232526pac.18.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 26 Aug 2013 10:16:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233006>

I was trying to clone a SVN repo, but not having luck:

 > $ git svn clone $PWD/private-lustre-svn $PWD/private-lustre-git
 > perl: subversion/libsvn_subr/dirent_uri.c:321: canonicalize: Assertion `*src != '/'' failed.
 > error: git-svn died of signal 6

What is Perl or Subversion or GIT trying to tell me, please?  Thank you!
