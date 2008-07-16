From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/5] add pack index v2 reading capability to git
 v1.4.4.4
Date: Wed, 16 Jul 2008 10:34:13 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807161033170.2835@woody.linux-foundation.org>
References: <1216189899-14279-1-git-send-email-nico@cam.org> <alpine.LFD.1.10.0807160924340.2835@woody.linux-foundation.org> <7vhcapsqoa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 19:37:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJAwB-0003NA-Ob
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 19:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbYGPRgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 13:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbYGPRgL
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 13:36:11 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60082 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751809AbYGPRgK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jul 2008 13:36:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6GHYEos018043
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jul 2008 10:34:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6GHYDoe004311;
	Wed, 16 Jul 2008 10:34:13 -0700
In-Reply-To: <7vhcapsqoa.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.909 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88699>



On Wed, 16 Jul 2008, Junio C Hamano wrote:
> 
> I do not think it should SEGV.  The pack-idx signature was chosen rather
> carefully to allow older ones to die gracefully.

Well, Pasky reported differently.

>     error: non-monotonic index
>     error: Could not read 4a588075c54cd5902e5f4d43b9d6b0c31d0f9769

Pasky's report was

	error: non-monotonic index
	/usr/bin/git-fetch: line 297: 30402 Segmentation fault git-http-fetch -v -a "$head" "$remote/"

but maybe that was something specific to his case.

		Linus
