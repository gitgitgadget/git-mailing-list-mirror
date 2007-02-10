From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Git rescue mission
Date: Sat, 10 Feb 2007 11:05:02 -0500
Message-ID: <1171123504783-git-send-email-tytso@mit.edu>
References: <20070209014852.GA13207@thunk.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 17:05:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFuj1-0005rE-TX
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 17:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbXBJQFK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 11:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbXBJQFK
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 11:05:10 -0500
Received: from THUNK.ORG ([69.25.196.29]:33228 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932734AbXBJQFH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 11:05:07 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HFunw-0002L4-Ho; Sat, 10 Feb 2007 11:10:24 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HFuim-0007fi-BR; Sat, 10 Feb 2007 11:05:04 -0500
X-Mailer: git-send-email 1.5.0.rc4
In-Reply-To: <20070209014852.GA13207@thunk.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39234>

Shawn O. Pearce <spearce@spearce.org> wrote:
>Its not you.  The problem is 'gitk' is not an internal command,
>nor is there a 'git-gitk'.  So we cannot execute it.  Instead we
>are giving back a horrible error message.

Here are some patches to fix the horrible error message and to allow
aliases to expand to external shell commands.

                                        - Ted
