From: "Ryan Leigh" <ryanl.pi@gmail.com>
Subject: Push merges?
Date: Wed, 26 Mar 2008 14:52:06 -0700
Message-ID: <ba5eca00803261452r4b5a7b6bi600c30e79b945477@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 22:52:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JedYC-0006eN-WD
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 22:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803AbYCZVwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 17:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756612AbYCZVwJ
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 17:52:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:1506 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551AbYCZVwI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 17:52:08 -0400
Received: by ug-out-1314.google.com with SMTP id z38so208690ugc.16
        for <git@vger.kernel.org>; Wed, 26 Mar 2008 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=dqqYHMoVvJzjPMxjJGwqje/pwG38NZaiN9rUR5RWh6w=;
        b=OVEEzw46D211eH1eGTDd5rD7wmOZ9svJFOt88yf5SpM5TN62UrfUKwOrT7zzPmerVRcGnhrKuF5DlQaBEhJqjJGTi5t7dj8988P86x5DRmCq+KRSclSEhXv92Q3lxFcppBjMfMHSDwnd38iTZ1FOcNYk4Y6JXar8RSkkyZoxNpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aeLE6hJtAfdDU53MiS3IpKb216E3xL1IywouHmJr9JdVbtZXIGtPeO/CiRXAh0ZQrlX+Hk6dH9n6i/7Dkh1TcYR/SBdNoHKJ0KOj+W4z+tK7HqtKyzmm+D4NtwftHT1aTJzsmUvubncs56iXxFBASDRGZvpAH7oHsWBUBWGSWSU=
Received: by 10.67.116.7 with SMTP id t7mr1740358ugm.38.1206568326492;
        Wed, 26 Mar 2008 14:52:06 -0700 (PDT)
Received: by 10.67.122.18 with HTTP; Wed, 26 Mar 2008 14:52:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78315>

Hello all,

I've been getting to know git and I've stumbled across a "problem" and
I haven't yet been able to find a solution. For example, say I have a
branch "base" and two branches of that "foo" and "bar". I make some
change in "base", commit it, and now I would like to have it in both
"foo" and "bar". Is there a command that rather than get another
branch and merge with the current branch will instead take the current
branch and apply a merge on other branches? I've done google searches
and looking through documentation and tutorials and I can't seem to
find an answer one way or another. I wanted to make sure that before I
go write some script to handle it that what I am looking for isn't
already a feature.

Thank you,
Ryan
