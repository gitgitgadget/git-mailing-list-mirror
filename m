From: gapon <gapon007@gmail.com>
Subject: git bug/feature request
Date: Tue, 27 Nov 2007 11:27:41 +0100
Message-ID: <200711271127.41161.gapon007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 11:28:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwxfi-00062Y-Dl
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 11:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbXK0K1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 05:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbXK0K1r
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 05:27:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:33174 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbXK0K1q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 05:27:46 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1200345ugc
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 02:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Ge9+apuY6EJFPj5p9qfW1cWusNFDwt15Jar44tAYtDg=;
        b=EoXgksWqCWDxz9XBOxqiiENzChRF3ocA1Y5QrNQkOvu7x7b35Gvn8oBh+cFh39DlIqQjv62MJ5+HT+hzHp28bybAGwbQjY6atf8Pd70v25H4hqgcdtafRKvBS2PFRSQTE3dQ6p9Dpu+80vV6iyoHA2KoCDbQJ7PXJLUp9TBWI9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tw33RggrLaiyLGkKeQo72s+z+png3msmgvlh3jJ1Uo3YuXZHNnvh4aQ8BZp3OedkLDkNINTWjM+dorM539DMUNbRfLKBWGbzEeTJ+FYQqoRKCEIK8y2lxafje5hLcxSBO6iElKew/Rf6tBFCcsmoD2dEpng7s1kOxwxACvcWRqg=
Received: by 10.66.220.17 with SMTP id s17mr874538ugg.1196159265031;
        Tue, 27 Nov 2007 02:27:45 -0800 (PST)
Received: from dhcp-eprg06-20-185.czech.sun.com ( [192.9.112.196])
        by mx.google.com with ESMTPS id e32sm4240619fke.2007.11.27.02.27.43
        (version=SSLv3 cipher=OTHER);
        Tue, 27 Nov 2007 02:27:44 -0800 (PST)
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66181>

hi all,
first of all i don't know if there's a bugzilla or something similar for git - 
i have found just this email (on http://git.or.cz/ webpage).

i have discovered "weird" behaviour of git in this scenario*:
- user A is working in repo A
- user B clones repo A
- user B makes some changes, commits, pushes
- user A makes some changes, git status (no info about new commit in his repo 
from user B but it's probably ok i'd say - but some of my files are marked as 
changed and already added to index  but i haven't changed them - that's 
confusing, isn't it?)
- user A can commit his changes => shouldn't be there any info/message/warning 
displayed? it would be helpful to have here some info about "foreign commit" 
in the repo or something like this

hmm?

thanks for git, it's simply the best one!
gapon

* yes, i know that this scenario is "incorrect" but... it's possible and 
therefore i think it should be somehow handled - i tried a similar one with 
hg and bzr and i like their behaviour more
