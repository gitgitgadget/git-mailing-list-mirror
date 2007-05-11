From: Jakub Narebski <jnareb@gmail.com>
Subject: Git Wiki after engine update lost macros; special pages like RecentChanges do not work
Date: Fri, 11 May 2007 03:04:22 +0200
Message-ID: <200705110304.23115.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri May 11 02:59:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmJUC-0007wi-P2
	for gcvg-git@gmane.org; Fri, 11 May 2007 02:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758402AbXEKA7y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 20:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758693AbXEKA7y
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 20:59:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:13850 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758402AbXEKA7x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 20:59:53 -0400
Received: by ug-out-1314.google.com with SMTP id 44so719363uga
        for <git@vger.kernel.org>; Thu, 10 May 2007 17:59:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pOEGo4re1eZmcWmsOnCnVJpb4A/Rypzu6y4PtfUTVQLKYFDl175J5Zp50LK9eRt+1RZLC4gDrWM5M9ZR1oQlXJvqfFIZJV4zxjALTYjLORyqBl6T0ChKGJshPGMI8ZpxUr7yViIRvYDqCuNMVlLArppBxrGt5bBRfWql+7OOxSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uiZEgLxaQ104kMkgivYqfEer4QZADQjHSh5ja8z8npIiF/4moOHF3cHoddR/W1BrZngLGQJsneTJC0fXwPX6PK6aMc9MFiMPb/oYOuyZl3cqqe9crX9s1AZRsji0owe4ta37B2u3IGltAgCW5vNs714N4BUrE4BtAH6co2jgihc=
Received: by 10.66.232.9 with SMTP id e9mr2456652ugh.1178845192112;
        Thu, 10 May 2007 17:59:52 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id 39sm5183432ugb.2007.05.10.17.59.50;
        Thu, 10 May 2007 17:59:50 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46921>

After wiki engine (MoinMoin) update at http://git.or.cz/gitwiki MoinMoin 
macros like {{RecentChanges}} or {{SystemInfo}} (by the way, somehow 
link to SystemInfo was lost on FrontPage). It looks like some 
configuration related to using Wikipedia-like links syntax was lost:

 * You can make links using [[linkname]] (or even [[target|label]]
 * If you ever need to use macros here, use a  {{macroname}}  syntax.

The second part is lost.

By the way automatic table of contents is now in a box which is 
unnecessary narrow; see e.g. http://git.or.cz/gitwiki/GitFaq
Could it be configured to something more resembling previous style?

-- 
Jakub Narebski
Poland
