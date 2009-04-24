From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On "git status"
Date: Fri, 24 Apr 2009 14:39:40 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49F1CF2F.16472.640F8D0@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49F1BD85.16747.5FBF6DC@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49F1A51C.40704@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 24 14:41:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxKiu-0002KT-GI
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 14:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470AbZDXMkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 08:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753817AbZDXMkL
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 08:40:11 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([194.94.155.53]:13718 "EHLO
	rrzmta2.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753050AbZDXMkK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Apr 2009 08:40:10 -0400
Received: from rrzmta2.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 2F59EC513F;
	Fri, 24 Apr 2009 14:40:14 +0200 (CEST)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta2.rz.uni-regensburg.de (Postfix) with ESMTP id D4A309823E;
	Fri, 24 Apr 2009 14:40:13 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n3OCe28O011056;
	Fri, 24 Apr 2009 14:40:02 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    24 Apr 09 14:39:59 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 24 Apr 09 14:39:46 +0100
In-reply-to: <49F1A51C.40704@drmicha.warpmail.net>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=590375@20090424.123742Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117432>

On 24 Apr 2009 at 13:40, Michael J Gruber wrote:

> Ulrich Windl venit, vidit, dixit 24.04.2009 13:24:
> > Hi,
> > 
> > I'm unsure it exists already, but "git status" doesn't display the tracked files. 
> > Would it make sense to have those reported with a "git status -v" (for verbose)?
> > (You know: I'm thinking about "cvs status"...)
> 
> "git status" is basically "git commit --dry-run", which is different
> from "cvs/svn/hg status".
> 
> "git diff --name-status" gives output similar to those.
> 
> "git ls-files" allows to list all tracked files.

OK, so many commands to learn.... Still shouldn't "git status --help" be able to 
display some help text (other than "man page not found")?

Regards,
Ulrich
