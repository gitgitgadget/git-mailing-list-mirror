From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 00/11] daemon-win32
Date: Thu, 26 Nov 2009 21:04:24 +0100
Message-ID: <200911262104.25087.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Erik Faye-Lund" <kusmabite@googlemail.com>, git@vger.kernel.org,
	dotzenlabs@gmail.com, "Erik Faye-Lund" <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 21:04:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDka7-0002nY-Gr
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 21:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbZKZUEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 15:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbZKZUEg
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 15:04:36 -0500
Received: from [93.83.142.38] ([93.83.142.38]:57723 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752576AbZKZUEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 15:04:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2D8EC19F6B1;
	Thu, 26 Nov 2009 21:04:25 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133830>

On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
> This is my stab at cleaning up Mike Pape's patches for git-daemon
> on Windows for submission, plus some of my own.

Please rebase the series on top of current master. I'd appreciate if you could 
make it available to pull from somewhere. I've a version here:

  git://repo.or.cz/git/mingw/j6t.git ef/mingw-daemon

(including Martin's getaddrinfo updates) but the resulting git-daemon crashes 
immediately after there is a connection.

-- Hannes
