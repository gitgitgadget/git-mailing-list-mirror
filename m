From: Paul Dickson <paul@permanentmail.com>
Subject: Problems with cg-admin-setuprepo
Date: Mon, 12 Dec 2005 18:02:15 -0700
Message-ID: <20051212180215.e9b687e4.paul@permanentmail.com>
References: <20051212011210.GC12373@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Dec 13 02:03:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElyYg-0003IO-4P
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 02:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbVLMBCT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 20:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbVLMBCT
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 20:02:19 -0500
Received: from api.pobox.com ([208.210.124.75]:38041 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S932305AbVLMBCT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 20:02:19 -0500
Received: from thorn (localhost [127.0.0.1])
	by thorn.pobox.com (Postfix) with ESMTP id 84C55110
	for <git@vger.kernel.org>; Mon, 12 Dec 2005 20:02:40 -0500 (EST)
Received: from red.pwd.internal (ip68-230-78-84.ph.ph.cox.net [68.230.78.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by thorn.sasl.smtp.pobox.com (Postfix) with ESMTP id 2148F109C
	for <git@vger.kernel.org>; Mon, 12 Dec 2005 20:02:39 -0500 (EST)
Received: from white.pwd.internal ([192.168.1.9])
	by red.pwd.internal (8.13.5/8.13.4) with SMTP id jBD12G76012960
	for <git@vger.kernel.org>; Mon, 12 Dec 2005 18:02:16 -0700
To: git@vger.kernel.org
In-Reply-To: <20051212011210.GC12373@pasky.or.cz>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.8; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13552>

On Mon, 12 Dec 2005 02:12:10 +0100, Petr Baudis wrote:

>   this is Cogito version 0.16.1, the next stable release of the
> human-friendly version control UI for the Linus' GIT tool.


The help from cg-admin-setuprepo say it will create the repo in the given
directory, but doesn't say it must create the directory.

  $ mkdir ~/test
  $ cg-admin-setuprepo ~/test
  cg-admin-setuprepo: /home/dickson/test already exists

There seems to be a missing step in the help instructions:

  $ cg-admin-setuprepo ~/test/test1
  $ cg-push
  cg-push: where to push to?


	-Paul
