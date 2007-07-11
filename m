From: "pradeep singh" <pradeep.rautela@gmail.com>
Subject: git-update-server-info may be required,cannot clone and pull from a remote repository
Date: Wed, 11 Jul 2007 19:38:22 +0530
Message-ID: <a901b49a0707110708o7c883bb0s707d9791f344f1f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 16:08:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8crk-0007er-LH
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 16:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761523AbXGKOIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 10:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761343AbXGKOIY
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 10:08:24 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:20166 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759546AbXGKOIX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 10:08:23 -0400
Received: by py-out-1112.google.com with SMTP id d32so3048866pye
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 07:08:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=A7B4xyg6qKNZ6kpZ2zwntLBdUftwXjbu5E1vWvLCvzREeGU3wEoWOrZKzSF/zAbyRbKzsKyvB1X8fF89Qk5Ncr9HywqbnILAWN/tvZ7qVaxvMLg0HRVHx4hDNHxoaGluhxj3szF8e27Pw3J+Fjhr/UkK2kUx0bpJX2nUwmjeTes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Gwp6BdqBrG8UfH3QRIPvZh6bFtr6CrHTTGzhEhVPChjvUZUSllsXVDjtRlR/b/+HeJKJsuVJbHti2gGTDwd/OqnHK2MbNat0vas7Psu1IHkApyBQ0Aswbybsu9NYcyWakbE1bYdNwRHPaUcFyfSyfF9TrBf2cmmh35aJn++4KHY=
Received: by 10.35.117.5 with SMTP id u5mr10488683pym.1184162902305;
        Wed, 11 Jul 2007 07:08:22 -0700 (PDT)
Received: by 10.35.72.8 with HTTP; Wed, 11 Jul 2007 07:08:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52161>

hi All,

Please bear with me as i am completely new to git.
I tired setting up git repository on one of my Ubuntu 7.04 machines.

I followed the howto instruction for setting up a git repo over http
using the HOWTO  given in the /usr/share/doc/git-doc/howtos .

All went correct.
Now i am facing some trouble here.

1. I already have a source tree controlled by git on the same
machine.I want to make this as the master for the new public
repository. I created a bare git repo in it as per the howto. Now i
want to commit my local git repo to this public repository.I failed to
do so sadly :-/.Can anyone point me to the correct place or link?

2. Even when i did a (from another machine)
 $git-clone http://100.121.232/work.git work
 It says,
 Cannot get remote repository information.
 Perhaps git-update-server-info needs to be run there?

 I ran git-update-server on the original machine, restarted even
apache2 but still same thing.

Can any one help me with this?
I ll appreciate some good documents or howtos on setting up git
repository painlessly.

BTW how am i supposed to use gitweb?
PS: I am not an expert sysadmin so i am completely unaware of apache2
tweaks and cgi pecularities.

Any help or pointers will be great.

Thank you
--pradeep
-- 
Pradeep
