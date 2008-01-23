From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Tue, 22 Jan 2008 19:53:56 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801221953030.1741@woody.linux-foundation.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org> <7vd4rv3ds5.fsf@gitster.siamese.dyndns.org>
 <7vtzl71x1c.fsf@gitster.siamese.dyndns.org> <7vprvv1wnu.fsf@gitster.siamese.dyndns.org> <7vlk6j1wjj.fsf@gitster.siamese.dyndns.org> <7vhch71vvb.fsf@gitster.siamese.dyndns.org> <7v8x2j1sul.fsf@gitster.siamese.dyndns.org> <7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211104590.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211120350.2957@woody.linux-foundation.org> <7vabmyykvg.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0801211242330.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801221355110.1741@woody.linux-foundation.org> <7vir1lp646.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 04:55:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHWha-00087D-Oh
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 04:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbYAWDyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 22:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753044AbYAWDyc
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 22:54:32 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57746 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753119AbYAWDyb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 22:54:31 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0N3rwki016507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Jan 2008 19:53:59 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0N3ruY8022271;
	Tue, 22 Jan 2008 19:53:57 -0800
In-Reply-To: <7vir1lp646.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.224 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71508>



On Tue, 22 Jan 2008, Junio C Hamano wrote:
>
> read-cache.c: fix a couple more CE_REMOVE conversion

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

			Linus
