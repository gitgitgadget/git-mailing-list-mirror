From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Handling large files with GIT
Date: Tue, 14 Feb 2006 19:56:48 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com> 
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org> <43F113A5.2080506@f2s.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 19:57:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F95M6-0002Uc-82
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 19:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbWBNS4u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 13:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbWBNS4u
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 13:56:50 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:44727 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030497AbWBNS4t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 13:56:49 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9AE92146E86; Tue, 14 Feb 2006 19:56:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 8BEA610E2;
	Tue, 14 Feb 2006 19:56:48 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5C4D6146E86; Tue, 14 Feb 2006 19:56:48 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Ian Molton <spyro@f2s.com>
In-Reply-To: <43F113A5.2080506@f2s.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16156>

Hi,

On Mon, 13 Feb 2006, Ian Molton wrote:

> Im curious as to why anyone would want to use a SCM tool on a mail dir 
> anyway - surely no-one edits their pasnt mails and needs to keep logs?
> 
> surely incremental backups would be a better way to manage something 
> like this?

Point is, if you want to read your email on different computers (like one 
desktop and one laptop), you are quite well off managing them with git. Of 
course, you could rsync them from/to the other computer. But rsync is slow 
once you accumulated enough files, since it has to compare the hashes of 
tons of files (or file chunks). Git knows if they have changed.

Hth,
Dscho
