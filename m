From: "Constantine A. Murenin" <mureninc@gmail.com>
Subject: Re: Setting file timestamps to commit time (git-checkout)
Date: Tue, 10 Dec 2013 17:39:05 -0800
Message-ID: <CAPKkNb6pUkJnJ=wW=BqgjFOpGixy1S=Hccv+OxWjoBipoYoq=A@mail.gmail.com>
References: <20131209112528.GA5309@linux.vnet.ibm.com>
	<xmqqsiu1yd7p.fsf@gitster.dls.corp.google.com>
	<20131210083531.GB4087@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: vogt@linux.vnet.ibm.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 11 02:39:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqYld-0007Wi-3D
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 02:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172Ab3LKBjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 20:39:10 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:57370 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab3LKBjH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 20:39:07 -0500
Received: by mail-la0-f49.google.com with SMTP id er20so3234051lab.8
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 17:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=J2IbaqPcY/cNgU00xLoWfXZsi541evz/6h3WucO90Gw=;
        b=maGqFqptwhdvBZ+PS54EgwlLVwQC2WLHjl/vPjRuRc6EDVKMI6EFW5+bH/wFSgCRSt
         ULv5on7CC2AffnuZ9abyVCKmvhh7h9mUUawAdUhxUFezm5XMaBokTf0yh9wHFGWCxZTH
         TNoD8vM3fg4ULeC1Cifq5xBuUdGNLfhEWgtXLtLUSTG46D5TGrjLQ+GIJTJGRxsGXGoy
         pE3VC9RRAGfU8mhfBc/e7sYEf3zLk1CjfNr1hZqPm4porA1NfqCsLmugOPFa6SXp/Nml
         p9hqns9WP24P5CF6iv95beQ4IlVLoahijjVvHqNxowhA3BfJYo6SlDdvazxR4zEA0R5S
         D3Dg==
X-Received: by 10.152.87.37 with SMTP id u5mr9789242laz.11.1386725945782; Tue,
 10 Dec 2013 17:39:05 -0800 (PST)
Received: by 10.114.79.135 with HTTP; Tue, 10 Dec 2013 17:39:05 -0800 (PST)
In-Reply-To: <20131210083531.GB4087@linux.vnet.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239165>

On 10 December 2013 00:35, Dominik Vogt <vogt@linux.vnet.ibm.com> wrote:
> that sounds awfully expensive, and really out of the scope of an
> RCS.  The second best approach I could think of is to stamp files
> with the timestamp of the last commit that touched that, but I
> guess that is not a cheap operation either.

You can already do this with a very small third-party script:

    https://github.com/cnst/git-tools/blob/master/git-restore-mtime-core

C.
