From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 09:40:21 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49D33686.30872.5EB934@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <3e8340490903282241u355ce5b3u1a6ff23b27f4ec12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 09:42:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lov5P-0006HD-NZ
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 09:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759573AbZDAHkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 03:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757931AbZDAHkk
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 03:40:40 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([194.94.155.53]:24728 "EHLO
	rrzmta2.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753470AbZDAHkj (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 03:40:39 -0400
Received: from rrzmta2.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 98C27AD0F2;
	Wed,  1 Apr 2009 09:40:39 +0200 (CEST)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta2.rz.uni-regensburg.de (Postfix) with ESMTP id 8E4E29F327;
	Wed,  1 Apr 2009 09:40:39 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n317eVnd000785;
	Wed, 1 Apr 2009 09:40:31 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    1 Apr 09 09:40:30 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 1 Apr 09 09:40:30 +0100
In-reply-to: <3e8340490903282241u355ce5b3u1a6ff23b27f4ec12@mail.gmail.com>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589357@20090401.073615Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115346>

On 29 Mar 2009 at 1:41, Bryan Donlan wrote:

> On Fri, Mar 27, 2009 at 3:21 AM, Ulrich Windl
> <ulrich.windl@rz.uni-regensburg.de> wrote:
> 
> 
> > 3) "git undo": If possible undo the effects of the last command.
> 
> You can roll back the state of most local references by using the git
> reflog (see git reflog --help for more information). This covers most
> situations - but note that it only works to roll back to a committed
> state, and won't save any uncommitted data at all.

Hmm...kind of an idea:

"git undo <command>" print help text on how to undo the effect of <command>.
I feel that may be useful. maybe replace "undo" with "undo-instructions".

Regards,
Ulrich
