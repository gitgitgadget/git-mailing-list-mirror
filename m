From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv2] tag: add --points-at list option
Date: Mon,  6 Feb 2012 23:01:15 -0800
Message-ID: <1328598076-7773-1-git-send-email-tmgrennan@gmail.com>
References: <20120206081119.GA3939@sigill.intra.peff.net>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 08:01:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruf3V-0000Ja-0G
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 08:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537Ab2BGHB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 02:01:28 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:35002 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544Ab2BGHB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 02:01:28 -0500
Received: by qcqw6 with SMTP id w6so3876202qcq.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 23:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=T8/qYxM7gLUyP8EWhqTCejLz6QpCvZXIcuQp54bcReM=;
        b=ADPgUg1bGZB60jRKgMAH+N0rqDcwnNbDPlsD2Cklc+UlcoRMWJmbtn7WIxotQ/gbTl
         gMcHR8U+B3MzrECGcVk4R6FL5/ArMJ18Y3a7UF09E0S0PGpvk2R8QaoVFFOuANJlUoaU
         wPbZ9u8NgHa9QAOtnj3zq6a1Ym3rwBG6Favbw=
Received: by 10.229.69.30 with SMTP id x30mr8410546qci.97.1328598087307;
        Mon, 06 Feb 2012 23:01:27 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id dm8sm39035448qab.18.2012.02.06.23.01.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 23:01:26 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <20120206081119.GA3939@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190146>

The following is version 2 of the "points-at" feature.  I think that I've
addressed all of the comments on this discussion other than the name objection.
I suggest "of" instead, as in: "Show me the tags of...".
But, this may be too terse, so I welcome any other suggestions.

Note that this has been rebased onto pu for integration of 'jk/maint-tag-show-fixes'.

Thanks,

Tom Grennan (1):
  tag: add --points-at list option

 Documentation/git-tag.txt |    5 ++-
 builtin/tag.c             |   87 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 86 insertions(+), 6 deletions(-)

-- 
1.7.8
