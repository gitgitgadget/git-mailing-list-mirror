From: Fabio Scotoni <fabio@esse.ch>
Subject: Re: German translation of git man pages
Date: Wed, 30 Jul 2008 16:05:03 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0807301604010.4094@hydra.esse.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 16:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOCJp-0000pl-9R
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 16:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbYG3OFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 10:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbYG3OFJ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 10:05:09 -0400
Received: from mail-proxy-be-01.sunrise.ch ([194.158.229.48]:11067 "EHLO
	gw-out-be-01.be08.sunrise.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751043AbYG3OFH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jul 2008 10:05:07 -0400
Received: from orion.esse.ch (adsl-62-167-95-8.adslplus.ch [62.167.95.8])
	by gw-out-be-01.be08.sunrise.ch (8.13.1/8.13.5) with ESMTP id m6UE54aA022483
	for <git@vger.kernel.org>; Wed, 30 Jul 2008 16:05:04 +0200
Received: from localhost (localhost [127.0.0.1])
	by orion.esse.ch (Postfix) with ESMTP id 74ED85E28
	for <git@vger.kernel.org>; Wed, 30 Jul 2008 16:05:04 +0200 (CEST)
Received: from orion.esse.ch ([127.0.0.1])
 by localhost (orion.esse.ch [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08532-01 for <git@vger.kernel.org>; Wed, 30 Jul 2008 16:05:04 +0200 (CEST)
Received: from hydra (localhost [127.0.0.1])
	by orion.esse.ch (Postfix) with ESMTP id D73E25E17
	for <git@vger.kernel.org>; Wed, 30 Jul 2008 16:05:03 +0200 (CEST)
Received: from 192.168.1.9 ([192.168.1.9] helo=hydra) by ASSP-nospam;
	30 Jul 2008 16:05:03 +0200
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
X-Virus-Scanned: by amavisd-new at esse.ch
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90792>

Hello,

On Wed, 2008-07-30 at 14:25 +0200, Stephan Beyer wrote:
> The glossary may also be a good help:
> http://git.kernel.org/?p=git/git.git;a=blob;f=git-gui/po/glossary/de.po

I think we should follow this Glossary. Git-gui users should not be
forced to learn again. Learning git is already enough work.

On Wed, 2008-07-30 at 13:18 +0200, David Soria Parra wrote:
> You might want to provide a public repository, which we can pull from
> and send you patches.

Of course. Here it is: git://repo.or.cz/srv/git/gitman-de.git
(You may blame me now for using a public repository.)
I did create the mob user ( http://repo.or.cz/mob.html ) and it's
branch. Pushing only over ssh.
I used the repository of git from yesterday.
The only translated file at the moment is gittutorial-de.txt.
Every file without -de at its end is the original English file.
DO NOT MODIFY them.
If files with -de at their end have English passages or are completely
English means, they haven't been translated.
Note: You should fix any Eszett errors, I'm Swiss, so i was unable to
insert any Eszetts.

On Wed, 2008-07-30 at 13:06 +0200, Stephen R. van den Berg wrote:
> A good translation will translate those words.  However, since the
> commandline interface uses the English words, you'll be forced to
> re-explain that relationship a lot of times (using parenthesis, most
> likely).

I think we should avoid this. It just makes the text more unclear and
harder to understand. Instead, we should provide something like
"gitglossary-de.1", so interested users can look up our translations of
English words.

On Wed, 2008-07-30 at 11:21 +0000, Mark Struberg wrote:
> (Reminds me of some old Siemens BS2000 mainfraims back in the 80s.
> They translated really ALL terms to german, which was frankly
> completely unreadable)

Yes, I exactly know what you mean and I would like to keep some terms,
but they were translated to German and so I feel forced to copy the
glossary of git-gui.

With best regards,
Fabio Scotoni
