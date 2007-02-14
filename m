From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Re: Newbie experience with push over ssh
Date: Wed, 14 Feb 2007 16:29:58 +0000
Message-ID: <45D33906.2040905@webdrake.net>
References: <vpq64a4bzp1.fsf@olympe.imag.fr>	<20070214142731.GA1478@moooo.ath.cx>	<45D33485.5020906@webdrake.net> <17875.14305.910866.273778@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 17:30:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHN1H-0003sk-8a
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbXBNQaH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbXBNQaH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:30:07 -0500
Received: from alf.nbi.dk ([130.225.212.55]:4916 "EHLO alf.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932369AbXBNQaG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:30:06 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by alf.nbi.dk (8.9.3/8.9.3) with ESMTP id RAA17504;
	Wed, 14 Feb 2007 17:29:59 +0100 (MET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
In-Reply-To: <17875.14305.910866.273778@lisa.zopyra.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39670>

Bill Lear wrote:
>> So, is there a way of using git to upload my code to a machine without a
>> repo ready-prepared?
> 
> If you must ...
> 
> % cat ~/.gitconfig
> [alias]
> 	scp !scp
> 	rcp !rcp
> % git scp -rp . me@remotehost:/directory

Thanks very much.  And (should have asked this first ....) is it
possible to init a repo remotely, i.e. to use the git on my machine to
do init-repo on a directory accessed via ssh or ftp?  And if yes ... to
do other git commands similarly remotely?

The latter would be a slow and painful way of working, I imagine, but
might be useful.
