From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Wed, 03 Jun 2009 03:39:11 -0700 (PDT)
Message-ID: <m3vdnda9f7.fsf@localhost.localdomain>
References: <20090602174229.GA14455@infidigm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: sparse@infidigm.net
X-From: git-owner@vger.kernel.org Wed Jun 03 12:45:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBnyC-0002Md-D6
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 12:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbZFCKpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 06:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbZFCKpA
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 06:45:00 -0400
Received: from mail-bw0-f165.google.com ([209.85.218.165]:60265 "EHLO
	mail-bw0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbZFCKo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 06:44:59 -0400
X-Greylist: delayed 348 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2009 06:44:59 EDT
Received: by bwz9 with SMTP id 9so32343bwz.37
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 03:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=5wDxMPPmXlQ59UCHwzQFT88FzNn6pZyXsDbDq3rbTy4=;
        b=it0DpFtmzhXk/ZTZitQftMiiUdSieHVNb/uaqqwEcNfN3/bIJ1CX0cd0ZmVuECY9We
         RhAgyLmDLrsSngTASfRxu/oSYbpNqhVCXrsG0DPI8oJWM+u3m6RYa4MxU3ZMOzdBJe7Y
         drqfzHzGiRMnanRY+RbaOKgYOCqzrldbsnc0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=ob4/Ul5fPHFi1qXMGuIYiNY6Ex+usY4fVTzk80j1DwcDyRGvKJKI8XmBaKLIO5iSPd
         dQhSPPtedi0fugXqPdUshO0wlRXSWXnXz88IdGZ/geu0nzaYJSgFVVo7YV1Uyz36HtT0
         CdXYpxeUazAk9bbKmA3/so7eKFCKmDOgVTxig=
Received: by 10.103.137.12 with SMTP id p12mr477425mun.94.1244025552189;
        Wed, 03 Jun 2009 03:39:12 -0700 (PDT)
Received: from localhost.localdomain (abws210.neoplus.adsl.tpnet.pl [83.8.242.210])
        by mx.google.com with ESMTPS id n7sm4404854mue.28.2009.06.03.03.39.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 03:39:11 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n53Ad9kf019018;
	Wed, 3 Jun 2009 12:39:09 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n53Ad8wH019015;
	Wed, 3 Jun 2009 12:39:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090602174229.GA14455@infidigm.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120597>

sparse@infidigm.net writes:

> When cloning over http git spews a bunch of hashs that don't really convey much.
> The attached patch disables them unless --verbose is specified.
> 

Please follow guidelines stated in Documentation/SubmittingPatches:
 * it is preferred to have patch inline, rather than as attachement
 * put comments between "---" and the diffstat

Also please do the following:
 * use git-format-patch output rather than that of git-show to
   generate patch to send.

Also "Prevent cloning over http from spewing" is not, in my opinion,
good description; "Make cloning over http non-verbose by default"
would be better.

Finally a question: if we turn off verbose output, do we have any kind
of progress info fot git-clone over http?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
