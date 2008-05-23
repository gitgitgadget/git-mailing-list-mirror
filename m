From: "Robert Anderson" <rwa000@gmail.com>
Subject: git-svn: commit all changes as one svn revision?
Date: Fri, 23 May 2008 09:08:15 -0700
Message-ID: <9af502e50805230908t76c9b26exd36cfb6d0f1a9bcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 18:09:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzZpN-00071L-AU
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 18:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbYEWQIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 12:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014AbYEWQIS
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 12:08:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:40012 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbYEWQIR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 12:08:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so430653fgg.17
        for <git@vger.kernel.org>; Fri, 23 May 2008 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=xmwU4kRvQBozJoUfRyyKVnFiUTHwCM/SdXQjKRNEnEE=;
        b=IKC1GXVj/oGSrbvYgEO97114eSF54Ke7/zHSNvvLpLZ7MohH1IjJ9E7/eWUWRU86dQCnPPpKqiKRyF19n0qY+6mLZ3M5RF/mht76Pwqf6m2Oozm91x6SDw9e9M+KJeytxcsCC+R2LKHAKcxykCxFnR1Mj4su4ZnBwM6mMbBgiKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FaySiIu7q7i6mz2kOUPvZ70sowntHN9kKQemjJl56NqP3ChgNimy1hVCy5EEGl8No5wbrtVMSqqk5JTC5HSLULVsRefwnZhJIZn1XUgrgN5YRZKlKBFWAXlV+6MZvISaMz2CXAYFCj2DxqkQB+NlrCLp5Ezo7na9LVwB34HUT08=
Received: by 10.86.59.18 with SMTP id h18mr35312fga.30.1211558895437;
        Fri, 23 May 2008 09:08:15 -0700 (PDT)
Received: by 10.86.4.6 with HTTP; Fri, 23 May 2008 09:08:15 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82718>

Use case:

I make a bunch of git commits developing something that was checked
out from a svn repo using git-svn.  I want to commit all the changes
since my last dcommit as one revision, rather than having each git
commit checked in separately, as dcommit behaves.

Is there a way to do this?

Thanks,
Bob Anderson
