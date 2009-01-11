From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH] Cleanup of unused symcache variable inside diff-lib.c
Date: Sun, 11 Jan 2009 21:50:29 +0100
Organization: private
Message-ID: <86ab9x8t4a.fsf@broadpark.no>
References: <1231699002-5316-1-git-send-email-barvik@broadpark.no>
 <alpine.DEB.1.00.0901111944360.3586@pacific.mpi-cbg.de>
 <86iqol8wql.fsf@broadpark.no>
 <alpine.DEB.1.00.0901112044230.3586@pacific.mpi-cbg.de>
 <86eiz98v0s.fsf@broadpark.no>
 <alpine.DEB.1.00.0901112112540.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:52:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM7Hn-0002A0-Ne
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbZAKUuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbZAKUuc
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:50:32 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:48703 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbZAKUub (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:50:31 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDB00L41R86LS10@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 21:50:30 +0100 (CET)
Received: from localhost ([80.203.78.153]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDB00G66R85XP80@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 21:50:30 +0100 (CET)
In-reply-to: <alpine.DEB.1.00.0901112112540.3586@pacific.mpi-cbg.de>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105223>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

<snipp>
>> --signoff
>
> If you had signed off on your commits already, not necessary.  (FWIW I 
> keep a sign off as a marker that I actually think this is good to be 
> submitted, or at least close.)

  From the Documentation/SubmittingPatches file, for me I think that the
  '-signoff' is supposed to mean:

  [....]
   - if you want your work included in git.git, add a "Signed-off-by:
     Your Name <you@example.com>" line to the commit message (or just
     use the option "-s" when committing) to confirm that you agree to
     the Developer's Certificate of Origin
  [....]
  The sign-off is a simple line at the end of the explanation for the
  patch, which certifies that you wrote it or otherwise have the right
  to pass it on as a open-source patch.  The rules are pretty simple: if
  you can certify the below:

        Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:
  [....]
  then you just add a line saying

	Signed-off-by: Random J Developer <random@developer.example.org>

  This line can be automatically added by git if you run the git-commit
  command with the -s option.
  [....]
  
  And the 'a' and the 'd' in the DCO I do agree with in this particular
  situation, so I added a '--signoff' to the patches.

  -- kjetil
