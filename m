From: "James B. Byrne" <byrnejb@harte-lyne.ca>
Subject: Re: [Fwd: Re: GiT and CentOS 5.2]
Date: Tue, 8 Jul 2008 15:15:54 -0400 (EDT)
Message-ID: <42591.216.185.71.22.1215544554.squirrel@webmail.harte-lyne.ca>
References: <50493.216.185.71.22.1215543081.squirrel@webmail.harte-lyne.ca>
    <76718490807081158v5acb6e6co670597d5e08db6c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 21:17:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGIgY-0007MW-6B
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 21:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbYGHTQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 15:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753751AbYGHTQM
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 15:16:12 -0400
Received: from inet06.hamilton.harte-lyne.ca ([216.185.71.26]:36731 "HELO
	inet06.hamilton.harte-lyne.ca" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753716AbYGHTQM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2008 15:16:12 -0400
Received: from inet07.hamilton.harte-lyne.ca (inet07.hamilton.harte-lyne.ca [216.185.71.27])
	by inet06.hamilton.harte-lyne.ca (8.13.1/8.13.1) with ESMTP id m68JG68k021124;
	Tue, 8 Jul 2008 15:16:07 -0400
Received: from webmail.harte-lyne.ca (inet07.hamilton.harte-lyne.ca [216.185.71.27])
	by inet07.hamilton.harte-lyne.ca (8.13.1/8.13.1) with ESMTP id m68JFrhv011542;
	Tue, 8 Jul 2008 15:15:54 -0400
Received: from 216.185.71.22
        (SquirrelMail authenticated user byrnejb)
        by webmail.harte-lyne.ca with HTTP;
        Tue, 8 Jul 2008 15:15:54 -0400 (EDT)
In-Reply-To: <76718490807081158v5acb6e6co670597d5e08db6c1@mail.gmail.com>
User-Agent: SquirrelMail/1.4.8-4.0.1.el4.centos
X-Priority: 3 (Normal)
Importance: Normal
X-Harte_and_Lyne_Limited-MailScanner-Information: For further information contact postmaster@harte-lyne.ca
X-Harte_and_Lyne_Limited-MailScanner-ID: m68JFrhv011542
X-Harte_and_Lyne_Limited-MailScanner: Checked by clamav and Found to be clean
X-Harte_and_Lyne_Limited-MailScanner-SpamCheck: not spam,
	SpamAssassin (not cached, score=-1.269, required 3,
	autolearn=not spam, AWL 1.33, BAYES_00 -2.60, SPF_PASS -0.00)
X-MailScanner-From: byrnejb@harte-lyne.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87787>


On Tue, July 8, 2008 14:58, Jay Soffian wrote:

> You could of course answer this yourself. Download the latest RPM, rpm
> --nodeps or rpm2cpio it and see if it works.
>
> But from the looks of it, the git binary links against libraries not
> on your system and it will not work.

Yes, it appears so.  Having just converted our projects from subversion to
git I am reluctant to beat my brains out trying to maintain yet another
moving target that is, in the end, only a support tool. The most recent
GiT source builds without complaint on my development system so the
dependencies are purely build environment artifacts and are not
substantive.  This change to the rpm build platform is unfortunate for me
since I now lose a very convenient update process and have to choose
between rebuilding at each release or stabilizing at 1.5.6.1.

Nonetheless, I will no doubt live through this... Sigh.


-- 
***          E-Mail is NOT a SECURE channel          ***
James B. Byrne                mailto:ByrneJB@Harte-Lyne.ca
Harte & Lyne Limited          http://www.harte-lyne.ca
9 Brockley Drive              vox: +1 905 561 1241
Hamilton, Ontario             fax: +1 905 561 0757
Canada  L8E 3C3
