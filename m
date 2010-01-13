From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] grep: rip out support for external grep
Date: Wed, 13 Jan 2010 07:20:37 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001130720200.17145@localhost.localdomain>
References: <7vtyv4cpna.fsf@alter.siamese.dyndns.org> <87ljgfgbl0.fsf@catnip.gol.com> <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com> <877hrzga16.fsf@catnip.gol.com> <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org> <20100104053125.GA5083@coredump.intra.peff.net> <7vbphaquwl.fsf@alter.siamese.dyndns.org> <20100104064408.GA7785@coredump.intra.peff.net> <alpine.LFD.2.00.1001040659150.3630@localhost.localdomain>
 <fc339e4a1001040757n31298f3h724eacfafb68c63e@mail.gmail.com> <alpine.LFD.2.00.1001040801290.3630@localhost.localdomain> <7vvdf9402f.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001110739280.13040@localhost.localdomain> <alpine.LFD.2.00.1001110748560.13040@localhost.localdomain>
 <7vtyusr4r7.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001110830070.13040@localhost.localdomain> <7v63774tfd.fsf@alter.siamese.dyndns.org> <7v4omqv6tx.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Miles Bader <miles@gnu.org>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 16:22:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV53O-000458-60
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 16:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755497Ab0AMPWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 10:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755190Ab0AMPWS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 10:22:18 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37742 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755163Ab0AMPWR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jan 2010 10:22:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0DFKc6F006187
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 Jan 2010 07:20:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0DFKb1b011575;
	Wed, 13 Jan 2010 07:20:37 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v4omqv6tx.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.95 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136831>



On Tue, 12 Jan 2010, Junio C Hamano wrote:
> 
>  These nits out-of-way, we can now start doing this.
> 
>  Makefile        |   10 --
>  builtin-grep.c  |  305 +------------------------------------------------------
>  t/t7002-grep.sh |    6 +-
>  3 files changed, 8 insertions(+), 313 deletions(-)

Yay!

		Linus
