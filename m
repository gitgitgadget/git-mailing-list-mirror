From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [ALTERNATE PATCH] Add a simple option parser.
Date: Fri, 5 Oct 2007 09:51:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710050950550.23684@woody.linux-foundation.org>
References: <1191447902-27326-1-git-send-email-krh@redhat.com>
 <20071005142140.GK19879@artemis.corp> <20071005142507.GL19879@artemis.corp>
 <20071005143014.GA18176@glandium.org> <20071005144540.GM19879@artemis.corp>
 <598D5675D34BE349929AF5EDE9B03E2701624FD6@az33exm24.fsl.freescale.net>
 <20071005155647.GC20305@artemis.corp> <598D5675D34BE349929AF5EDE9B03E2701624FF2@az33exm24.fsl.freescale.net>
 <alpine.LFD.0.999.0710050924530.23684@woody.linux-foundation.org>
 <598D5675D34BE349929AF5EDE9B03E270162501A@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Mike Hommey <mh@glandium.org>,
	Kristian H?gsberg <krh@redhat.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 18:53:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdqQF-0000Xw-LC
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 18:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929AbXJEQw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 12:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754252AbXJEQw6
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 12:52:58 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38472 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756929AbXJEQw6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Oct 2007 12:52:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l95GpYkX023958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Oct 2007 09:51:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l95GpYa9009795;
	Fri, 5 Oct 2007 09:51:34 -0700
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E270162501A@az33exm24.fsl.freescale.net>
X-Spam-Status: No, hits=-3.241 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60114>



On Fri, 5 Oct 2007, Medve Emilian-EMMEDVE1 wrote:
> 
> From what I understand argp is part of glibc.

So are you arguing that we include all of glibc just to get git to be 
portable?

That's even worse.

		Linus
