From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Problems with EGit
Date: Wed, 3 Dec 2008 20:21:57 +0100
Message-ID: <200812032021.57901.robin.rosenberg.lists@dewire.com>
References: <4936689B.1030903@gerina.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bastian Flinspach <bastian.flinspach@gerina.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 20:23:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7xJn-00066o-Jo
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 20:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbYLCTWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 14:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbYLCTWJ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 14:22:09 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:45620 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751188AbYLCTWI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2008 14:22:08 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB02BE5D4A; Wed, 3 Dec 2008 20:22:01 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <4936689B.1030903@gerina.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102280>

onsdag 03 december 2008 12:08:11 skrev Bastian Flinspach:

Hi Bastian,

> When i try to commit changes via the command line, everything works fine 
> (well, except for me not being able to use my keyboard right for 
> entering the commit message, but thats probably not important because i 
> want to use EGit anyways).
> Eclipse recognizes the repository and also displays changes i make. When 
> trying to commit, however, i get a permission denied error.
> 
> So, this is basically where i am stuck. What can be the problem and what 
> would be a solution? I assume, that i might have something to do with 
> Linux users and privileges, but i am not yet versed enough to identify 
> the problem on my own.

If Git does not have permission problems, neither should EGit, I think, In the
workspace there is a file called .metadata/.log that you can inspect. See
if you can find anything interesting, i.e. a seemingly relevant stack trace or
other error message. The file can be quite large so try to cut it down.

> Please keep in mind, that i am a complete beginner with these topics 
> when answering.
We all started at the beginning. 

-- robin
