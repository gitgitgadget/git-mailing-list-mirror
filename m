From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2 5/5] describe: Break annotated tag ties by tagger
	date
Date: Tue, 13 Apr 2010 07:08:30 -0700
Message-ID: <20100413140830.GA12635@spearce.org>
References: <20100411024008.GC23075@spearce.org> <1271114729-18166-5-git-send-email-spearce@spearce.org> <201004131132.30186.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Apr 13 16:08:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1gnE-0006QW-Id
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 16:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766Ab0DMOIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 10:08:39 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:62867 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab0DMOIi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 10:08:38 -0400
Received: by bwz19 with SMTP id 19so8051bwz.21
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 07:08:36 -0700 (PDT)
Received: by 10.204.138.219 with SMTP id b27mr1042556bku.139.1271167716073;
        Tue, 13 Apr 2010 07:08:36 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id a11sm46563870bkc.3.2010.04.13.07.08.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 07:08:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201004131132.30186.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144818>

Thomas Rast <trast@student.ethz.ch> wrote:
> Shawn O. Pearce wrote:
> > If the tag is an older-style annotated tag with no tagger date,
> > we assume a date stamp of 1 second after the UNIX epoch.
> 
> This patch doesn't seem to actually set this, but as a minor nit: the
> '1 second' contradicts the 0 mentioned in the last patch.
> 
> (The effect is the same for all practical purposes.)

Whoops.  Old commit message from v1.  I skim read it knowing I
needed to adjust something in the message before reusing it, but
didn't see anything, so sent it as-is.

Junio, it might make sense to drop the part Thomas quoted above
before you apply this.

-- 
Shawn.
