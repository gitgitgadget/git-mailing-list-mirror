From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: git-svn dcommit failure
Date: Tue, 29 May 2007 17:20:26 +0200
Message-ID: <87k5ur64hx.fsf@mid.deneb.enyo.de>
References: <87veecat2k.fsf@mid.deneb.enyo.de>
	<87d50kas6p.fsf@mid.deneb.enyo.de>
	<20070529144742.GG1025@.intersec.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 17:20:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht3V8-0001oj-3e
	for gcvg-git@gmane.org; Tue, 29 May 2007 17:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbXE2PU3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 11:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbXE2PU3
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 11:20:29 -0400
Received: from mail.enyo.de ([212.9.189.167]:1586 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbXE2PU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 11:20:28 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1Ht3Up-00045T-D3
	for git@vger.kernel.org; Tue, 29 May 2007 17:20:27 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.67)
	(envelope-from <fw@deneb.enyo.de>)
	id 1Ht3Uo-0003gY-8U
	for git@vger.kernel.org; Tue, 29 May 2007 17:20:26 +0200
In-Reply-To: <20070529144742.GG1025@.intersec.eu> (Pierre Habouzit's message
	of "Tue, 29 May 2007 16:47:42 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48696>

* Pierre Habouzit:

> On Tue, May 29, 2007 at 11:35:10AM +0200, Florian Weimer wrote:
>> * Florian Weimer:
>> 
>> > This with git-svn 1.5.1.4-2 on something that is quite close to Debian
>> > etch.
>> 
>> Same issue with 1.5.2~rc3-2.
>
>   Are you using ControlMaster in your ssh setup in auto/autoask mode? (I
> assume your repository is svn+ssh). If yes, then you *have* to start a
> persistent ssh connection before you do anything else:

No.  It's svn+ssh (with a custom connect script), but without the
controlchan extension.  Subversion works fine and lets me commit
changes.

After manually committing the offending changes via Subversion, I
git-svn has begun to work again, too (but I haven't yet tried to
change the same files).
