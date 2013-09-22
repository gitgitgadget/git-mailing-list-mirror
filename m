From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [BUG?] inconsistent `git reflog show` output, possibly `git fsck`
 output
Date: Sun, 22 Sep 2013 23:52:14 +0100
Message-ID: <523F749E.5030306@gmail.com>
References: <871u4hzusr.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Keshav Kini <keshav.kini@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 00:52:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNsVl-0006sj-9K
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 00:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab3IVWwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 18:52:13 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:43928 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab3IVWwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 18:52:12 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm2so1545923wib.4
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 15:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=EHSCXs/eL+iOTVdjY6W0zFXr4J4K7Fsz1eLMAPHPQBw=;
        b=oN5zNqvEUG41kRdfqM4/c/pciMGt33jTdq5pVe/ZSzhbAM819GCa5fBNQzgGVWHite
         A8kEkqwUXWamUm6YgC0Zjqw5ifT1KTuEXbnW0zueQQXrA/keUpPDhFMXvPS+16wveBnG
         DvX3hzFYaCBSv+MqhLHU0d4711lNca4ew1p0AWUhdB4Xi7zbGo2DhnRpe7Ke4zY/pWIO
         vwBgu+PkzMMpxbGSrR+o3RRQ0tiBOE6qTcxrsZREoUHsD5Vr2SZ58Q5N0KjKAYfZtGU7
         LQEwDF6buXr1s7S84vs9bbde2bno3gf2LabMGPkmW5axRkM/U/vNPNqyPNjzH2/P1PhW
         UdVQ==
X-Received: by 10.194.89.233 with SMTP id br9mr14677774wjb.15.1379890331401;
        Sun, 22 Sep 2013 15:52:11 -0700 (PDT)
Received: from shiny.local (host81-159-150-183.range81-159.btcentralplus.com. [81.159.150.183])
        by mx.google.com with ESMTPSA id i8sm21633063wiy.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 15:52:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <871u4hzusr.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235173>

On 21/09/2013 23:16, Keshav Kini wrote:
> [SNIP]
> This situation came about because the BFG Repo-Cleaner doesn't write new
> reflog entries after creating its new objects and moving refs around.

True enough - I don't think the BFG does write new entires to the
reflog when it does the final ref-update, and it would be nicer if it 
did. I'll get that fixed.

thanks,
Roberto
