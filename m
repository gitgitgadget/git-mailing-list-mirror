From: Spelic <spelic@shiftmail.org>
Subject: Forward-port a patch using git
Date: Wed, 01 Dec 2010 16:37:14 +0100
Message-ID: <4CF66BAA.1010203@shiftmail.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 16:53:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNozL-0007de-9b
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab0LAPwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 10:52:53 -0500
Received: from mx2.isti.cnr.it ([194.119.192.4]:3610 "EHLO mx2.isti.cnr.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753376Ab0LAPwx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 10:52:53 -0500
X-Greylist: delayed 896 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Dec 2010 10:52:52 EST
Received: from SCRIPT-SPFWL-DAEMON.mx.isti.cnr.it by mx.isti.cnr.it
 (PMDF V6.5 #31825) id <01NUWVLFGXZ4LS6RT4@mx.isti.cnr.it> for
 git@vger.kernel.org; Wed, 01 Dec 2010 16:37:12 +0100 (MET)
Received: from conversionlocal.isti.cnr.it by mx.isti.cnr.it (PMDF V6.5 #31825)
 id <01NUWVLFCD5CLS6H7A@mx.isti.cnr.it> for git@vger.kernel.org; Wed,
 01 Dec 2010 16:37:12 +0100 (MET)
Received: from [192.168.7.52] (firewall.itb.cnr.it [155.253.6.254])
 by mx.isti.cnr.it (PMDF V6.5 #31826)
 with ESMTPSA id <01NUWVLEG308LX4CPO@mx.isti.cnr.it> for git@vger.kernel.org;
 Wed, 01 Dec 2010 16:37:11 +0100 (MET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11)
 Gecko/20100713 Thunderbird/3.0.6
X-INSM-ip-source: 155.253.6.254 Auth Done
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162540>

Hi all
I have patches (xyz.patch files) which apply cleanly to kernel 2.6.36 
and 2.6.36.1 and do not apply cleanly on 2.6.37-rc4 (I mean they do 
apply but with massive offsets...)
I would like to forward-port them to 2.6.37-rc4, i.e. create equivalent 
patch files that would apply cleanly on 2.6.37-rc4 with zero offsets.

I have thought that there should be some git mechanism to confirm that 
such massive offsets which "patch" sees are actually correct and not 
false-positives, and are caused by the commits from 2.6.36 to 
2.6.37-rc4. There should be some mechanism in git to track line shifts 
in source files caused by commits...
After confirming this, Git should create for me equivalent patch files 
that apply cleanly to 2.6.37-rc4 that I can give to other people.

Is it possible? I am unfortunately a newbie with git. Can you help me?

Thank you
PS: I have downloaded the linux-2.6-stable git repository containing all 
needed revisions: v2.6.36, v2.6.36.1 and v2.6.37 .
