From: Aneesh Bhasin <contact.aneesh@gmail.com>
Subject: Adding a new file to all git branches
Date: Tue, 24 Mar 2009 09:11:15 +0530
Message-ID: <f662f0210903232041p6f86b882of7b2d708946ea905@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 04:43:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlxXb-000564-St
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 04:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbZCXDld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 23:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbZCXDld
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 23:41:33 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:25111 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbZCXDlc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 23:41:32 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2083096rvb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:received:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Og5ogWyV8GtWlH/sI5aUsOP1blqo+M+YIswShdVFb84=;
        b=IAlKqhnp/Rbn1K1+EpQQIzJV8imTPv2D9+PL7BwpSQDIjad47IC144wi2W7HJY/eor
         c6sLWg6ubk+O6Jm5BczBXi6sjBTaTaYULCTnrTHDMuuQHL/FV6QnWkmfG2j4kXbz6rFC
         bn3xN8kHG2LAU0/On3Iy8orSHn4OHHmKeEsI8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Prm2l1ytGHYXObyFQ56u0C2CRXyUS6r6CmlP7DIZuP77l/ug7fsUnS/be6133HJu8z
         X0rPoR5AphTeFjUzdwIp1rcWyNz4bE+e0oYqodkKrL/3I+BULtVnFtYLc+B4nW0CgTDJ
         x1Uhee+GHi83iE4a5a6cLlPM5NGnwwS6FbyRY=
Received: by 10.141.96.19 with SMTP id y19mr2675285rvl.201.1237866091062; Mon, 
	23 Mar 2009 20:41:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114400>

Hi,

I was wondering if it is possible to add a file to all the branches in
a repository without individually checking out each branch ?

A possible use-case for such a scenario is say I have a git repository
with various branches related to different features, versions or
bug-fixes and I want to be able to add a README file which contains
instructions/information common to all of those branches as of now
(but may diverge in future). So, do I have to checkout each branch
individually to add the same README file to all of them or is there a
direct/indirect workaround ?

Thanks for your help..

Regards,
Aneesh
