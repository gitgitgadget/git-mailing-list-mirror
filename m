From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: First time compiling source
Date: Tue, 15 Jan 2008 22:23:32 +0100
Message-ID: <20080115212332.GD3213@steel.home>
References: <c0f2d4110801151234i2292ad2aw48e38f4f4fcb5ee7@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Chris Ortman <chrisortman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 22:24:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEtGM-0004D2-TK
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 22:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbYAOVXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 16:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbYAOVXf
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 16:23:35 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:12402 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbYAOVXe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 16:23:34 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolErE4=
Received: from tigra.home (Faa76.f.strato-dslnet.de [195.4.170.118])
	by post.webmailer.de (klopstock mo33) (RZmta 15.4)
	with ESMTP id c05b78k0FKFDgP ; Tue, 15 Jan 2008 22:23:32 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 67A5A277AE;
	Tue, 15 Jan 2008 22:23:32 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 50DEE56D22; Tue, 15 Jan 2008 22:23:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <c0f2d4110801151234i2292ad2aw48e38f4f4fcb5ee7@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70563>

Chris Ortman, Tue, Jan 15, 2008 21:34:12 +0100:
> Up until today I've always run git off whatever debs come with ubuntu.
> But if I'm going to try to do some work I figured I should be
> compiling from source.
> 
> To compile I did
> git co -b current v1.5.3.8
> make
> make install
> 
> then to check
> which git
> /home/chrisortman/bin/git
> as expected
> 
> however git --version still reports 1.5.2.5
> 
> What did I miss?

The git in /usr/bin is stuck in hashed paths of your shell?
For instance, bash remembers all the programs it managed to exec.
