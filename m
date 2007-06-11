From: Theodore Tso <tytso@mit.edu>
Subject: Re: Please pull mergetool.git
Date: Mon, 11 Jun 2007 09:31:00 -0400
Message-ID: <20070611133100.GB15117@thunk.org>
References: <E1HxPt7-0007jV-6V@candygram.thunk.org> <7v1wgj8tzy.fsf@assigned-by-dhcp.cox.net> <26568045-F443-415E-A250-29C7DD3998A9@silverinsanity.com> <7vabv74838.fsf@assigned-by-dhcp.cox.net> <46a038f90706101855g639656f3qe80adeeb3a7d6dc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 15:31:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxjzM-0004xZ-9r
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 15:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbXFKNbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 09:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbXFKNbM
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 09:31:12 -0400
Received: from THUNK.ORG ([69.25.196.29]:55546 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbXFKNbM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 09:31:12 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1Hxk6Z-0007H0-Vz; Mon, 11 Jun 2007 09:38:48 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1Hxjz2-0005Zu-Pa; Mon, 11 Jun 2007 09:31:00 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90706101855g639656f3qe80adeeb3a7d6dc2@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49849>

On Mon, Jun 11, 2007 at 01:55:25PM +1200, Martin Langhoff wrote:
> FWIW, it depends on whether you are using xterm (DISPLAY is set) or
> Terminal.app (DISPLAY may not be set). In any case FileMerge.app will
> ignore DISPLAY.

Is there a reliable way on MacOS to determine whether the user is
sitting in front of the terminal, as opposed to logged into the MacOS
box remotely?  Ideally we would only try opendiff/FileMerge.app if we
new that the user is indeed sitting in front of the graphical display.

						- Ted
