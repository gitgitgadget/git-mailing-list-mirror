From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Tue, 15 Jan 2008 06:48:07 +0100
Message-ID: <20080115054807.GA3694@steel.home>
References: <a5eb9c330801140921m63b1b8a9pe67bf6f0d2e58dba@mail.gmail.com> <20080114202932.GA25130@steel.home> <a5eb9c330801141421g13c627e5x77afb357e2a78463@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Umbers <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 06:48:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEefA-00071n-IF
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 06:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbYAOFsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 00:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYAOFsN
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 00:48:13 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:9815 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbYAOFsM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 00:48:12 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOV/Ag==
Received: from tigra.home (Faf3b.f.strato-dslnet.de [195.4.175.59])
	by post.webmailer.de (mrclete mo38) (RZmta 15.4)
	with ESMTP id j01cd6k0F0chkQ ; Tue, 15 Jan 2008 06:48:09 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6A9B5277AE;
	Tue, 15 Jan 2008 06:48:08 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id C6AAE56D22; Tue, 15 Jan 2008 06:48:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a5eb9c330801141421g13c627e5x77afb357e2a78463@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70503>

Paul Umbers, Mon, Jan 14, 2008 23:21:28 +0100:
> The "mount" command tells me everything I have is mounted in binmode.

Now that's unusual, unless you had "Text Mode" selected in the installer

> Are you saying I need to make sure the repository directory is mounted
> in text-mode (for Windows compatibility)? I just reinstalled cygwin,
> selecting text-mode as the default.

No, text-mode is definitely wrong for almost anything. It just
corrupts data. Try activating binary mode.
