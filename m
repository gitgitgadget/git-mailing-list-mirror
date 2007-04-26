From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git submodule support feedback
Date: Thu, 26 Apr 2007 13:08:24 +0100
Message-ID: <200704261308.26451.andyparkins@gmail.com>
References: <200704261238.51234.andyparkins@gmail.com> <e5bfff550704260456r36bd7e0p8c4b18b1050ceb86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 14:09:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hh2mj-0001lN-26
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 14:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031188AbXDZMIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 08:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031190AbXDZMIy
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 08:08:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:37198 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031188AbXDZMIw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 08:08:52 -0400
Received: by ug-out-1314.google.com with SMTP id 44so600123uga
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 05:08:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nkwso0ZtJA/I8qRVL/54XVwoIliRvGGU11dJGd9iXghFiCTKs98baafHHvaHN+bJXamVI7Z5kovESBHcdwvece3rfPUI8HLAWfSAZyTwhPJAp7CgvVlQapEy3/IOAR4yDr8RoK5goXxtEkbx035jOWFuS9+4wf7p82VRn3IugZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LwUrvYFNg3X9G8STW6FYgiPAZWjbJn5LdoL83VYD78MJlaI/prgtSFcEbudxox95xwnTdQ+YGCzkCLwQY8qil2szJXasv0F+L6n+7j3mC1BZNOT2O+sTEuP+WgkBNZsez3XGvuOuGDO0o3iHCU0jNW+kBoY7+vchWrWPP/HfJko=
Received: by 10.82.146.14 with SMTP id t14mr3167995bud.1177589331480;
        Thu, 26 Apr 2007 05:08:51 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm21448ika.2007.04.26.05.08.40;
        Thu, 26 Apr 2007 05:08:47 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <e5bfff550704260456r36bd7e0p8c4b18b1050ceb86@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45632>

On Thursday 2007 April 26, Marco Costalba wrote:

>   In case you use qgit I would appreciate very much any bug report
> regarding this new submodules thing.

Of course; however, as of yet it's coping admirably.  I think that it's mainly 
because submodules are, for external-to-git purposes, displayed as patches to 
a file.

That means that qgit is showing the initial addition of a submodule as the 
addition of a file (which nicely shows up green in the file list), and the 
patch itself as:

diff --git a/submodule b/submodule
new file mode 160000
index 0000000..f806cbe
--- /dev/null
+++ b/submodule
@@ -0,0 +1 @@
+Subproject commit f806cbe233f4568611be37213c266013b692db19

> I still didn't test submodules compatibility myself, but in case of a
> bug report against qgit probably I will be forced to do ;-)

I'll certainly keep my eyes open.  As I say though: no worries yet.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
