From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [RFC/PATCH] test suite for Git.pm
Date: Sun, 01 Jun 2008 07:03:09 +0200
Message-ID: <48422D8D.2000909@gmail.com>
References: <1212292269-21534-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pasky@suse.cz
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 07:04:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2fk9-0006c6-0K
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 07:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbYFAFDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 01:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbYFAFDO
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 01:03:14 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:15804 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbYFAFDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 01:03:13 -0400
Received: by fg-out-1718.google.com with SMTP id 19so440330fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 22:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=qipv8XhZ3gHHB2E5y4n/Ww8abLsgeeORkHxyu7pdZfU=;
        b=F27u+yJrSj80DVyuTo1ptvHRFRmCM1pDKvSm3ejSDnfXWcdUX+Yr0lXUU/B4a0Uvqa7HYS+LMdn1ujsNyaSmGIshptwJxeZo/VzzTAOVk0f6HskzRlGC93IQVvSS0rIHWHunpVycT5CBEvs2zuww2nLToW+qWtGti+shaSbxcak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=WjQtohuvL/ZmtN3aQC1xoiq9zpuvL+Iq7zykzWP/mrYqw2AsPGLCvW3Ic4m/hQymD55l1MtRKdnlWguDO5jg2yutLdZ3G5QH6wG+vzpwO3x9CsLmXAFJJbqiz4Rg4zAk2dIyOEDBTzjI9QjkCbmF+ca+yXobLkrY4P7tXzpQPyQ=
Received: by 10.86.53.8 with SMTP id b8mr3289899fga.8.1212296591141;
        Sat, 31 May 2008 22:03:11 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.240.119])
        by mx.google.com with ESMTPS id 12sm2936567fgg.0.2008.05.31.22.03.09
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 22:03:09 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <1212292269-21534-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83432>

Lea Wiemann wrote:
> Added a shell script (t/t9700-perl-git.sh) that sets up a git
> repository and a perl script (t/t9700/test.pl) that runs the actual
> tests.

I just realized that it's a little hard to run this test suite since it 
depends on previous patches I sent.  So if you want to test it without 
applying those patches, please clone my repository: 
http://repo.or.cz/w/git/gitweb-caching.git

(Note that I may be rebasing the master branch and pushing new versions 
of my latest commit(s).  Hence, I believe that you will have to use 
git-pull --rebase to keep your clone up-to-date.)

-- Lea
