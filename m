From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: ambiguous git-log date and timestamp syntax
Date: Sat, 1 Mar 2008 11:15:56 -0500
Message-ID: <715587AA-D485-4B31-A786-D26334506007@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 17:16:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVUOB-00048w-9Q
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 17:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659AbYCAQQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 11:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756644AbYCAQQF
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 11:16:05 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:54681 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756619AbYCAQQD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 11:16:03 -0500
Received: by wx-out-0506.google.com with SMTP id h31so5009562wxd.4
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        bh=F+L2IRw7KsSrPf9OTdTLBH3jVBt04cmbbkhJx1I5xSU=;
        b=SLFhGdUoo42iFJbYKuUSWML6AVPwM+5+tFRbWB9+j1t2ksPiTPssyPA0OKOSmoSFs5HTj3IeoWjbdXOo8sxA5TKwkt5Gy9qiMzzV/HPn9iiJiVk7neY5iV3Z/Kl0Hs2VtXUl/u5a9/8qMRRMJRcBSb/BJkRmJBCW3mHfOS7lY+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding:mime-version:subject:date:x-mailer;
        b=Jn1M0SmLmbfmAdgUon7opWvipqYFYfdKg3NrE+tejsmEkhC/opfMA8KE0fCBzEGjthFrcsQp0sNYA+NDOySgtPo1VgKfq4cWxWoUVtVenooHnUQgnfS6CH2xIYgx9nniru0l2hl2BtbXabtVMOrgqwMrmaEUMNmI3KoKaDfGhFY=
Received: by 10.70.21.10 with SMTP id 10mr9161749wxu.2.1204388160010;
        Sat, 01 Mar 2008 08:16:00 -0800 (PST)
Received: from ?192.168.1.103? ( [72.93.195.57])
        by mx.google.com with ESMTPS id i13sm1847664wxd.3.2008.03.01.08.15.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Mar 2008 08:15:57 -0800 (PST)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75682>

The docs are a little vague on exactly what your options are when  
specifying dates. If someone can provide me some details on this i'll  
make a patch for the docs.

--since=date, --after=date
	Show commits more recent than a specific date.
--until=date, --before=date
	Show commits older than a specific date.
--max-age=timestamp, --min-age=timestamp
	Limit the commits output to specified time range.

 From what i can tell it seems that dates can be specified relatively,  
e.g. "2 hours ago", or with any ISO 8601 or RFC 2822 date syntax. Is  
this correct, and are there any docs on specifying relative dates?

I can't find any details on what the "timestamp" format should be. Can  
someone point me in the right direction?

-Kate == masukomi
