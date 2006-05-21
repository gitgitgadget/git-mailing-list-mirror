From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Sat, 20 May 2006 17:41:16 -0700
Message-ID: <7v8xow1a6r.fsf@assigned-by-dhcp.cox.net>
References: <7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
	<m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
	<7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
	<m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com>
	<7vsln8cwn6.fsf@assigned-by-dhcp.cox.net>
	<m1zmhg31cm.fsf@ebiederm.dsl.xmission.com>
	<7vy7x09qet.fsf@assigned-by-dhcp.cox.net>
	<m1ejyr38xx.fsf@ebiederm.dsl.xmission.com>
	<20060519235825.GA3289@kroah.com>
	<m1ac9dv2ld.fsf@ebiederm.dsl.xmission.com>
	<20060520213257.GH24672@kroah.com>
	<m1fyj4qkm2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 02:41:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhc0W-0003aq-8A
	for gcvg-git@gmane.org; Sun, 21 May 2006 02:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWEUAlR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 20:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWEUAlR
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 20:41:17 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:27284 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932294AbWEUAlR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 20:41:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521004116.OWAT15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 May 2006 20:41:16 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1fyj4qkm2.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Sat, 20 May 2006 18:36:53 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20412>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Currently git-mailinfo distinguishes headers and non-headers by the
> presence of the first blank line.  So it seems to work just fine on
> mbox format patches.

The program was designed to be fed one e-mail a time (the
intended way for it to work is that a wrapper script uses
git-mailsplit to break mbox up and call git-mailinfo one by
one).
