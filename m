From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Make more commands builtin
Date: Tue, 23 May 2006 14:20:56 +0200
Message-ID: <20060523122056.GA5777@bohr.gbar.dtu.dk>
References: <11483865361243-git-send-email-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 23 14:21:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiVsj-0003Y3-7b
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWEWMU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWEWMU6
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:20:58 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:28610 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1751335AbWEWMU6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:20:58 -0400
Received: (qmail 6482 invoked by uid 5842); 23 May 2006 14:20:56 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <11483865361243-git-send-email-1>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20601>

Btw.

I used these commands to produce the patch series:

git diff --stat -C 24b65a30015aedd..pe/builtin
git-send-email --no-chain-reply-to --compose \
               --from=s022018@student.dtu.dk --not-signed-off-by-cc \
               --quiet \
               --subject="Make more commands builtin" \
               --to=git@vger.kernel.org Patches/*

Is this a reasonable way to do it?

Peter 
