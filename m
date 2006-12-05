X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Print progress message to stderr, not stdout
Date: Tue, 5 Dec 2006 09:06:56 +0000
Message-ID: <b0943d9e0612050106k1081813ds98aec9272174a9ae@mail.gmail.com>
References: <20061111121625.8988.45195.stgit@localhost>
	 <e5bfff550612020520w3ad48a09xfdde63b9050a75cf@mail.gmail.com>
	 <b0943d9e0612040117y6554b891yaf6eb59d0d52ebf0@mail.gmail.com>
	 <20061204153705.GA8644@diana.vm.bytemark.co.uk>
	 <e5bfff550612041034g727a1bebg464f7c523c0fac7f@mail.gmail.com>
	 <b0943d9e0612041413p4f303176x3d0fa95afd1c4a1@mail.gmail.com>
	 <Pine.LNX.4.63.0612050841160.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 09:07:09 +0000 (UTC)
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DUH38bI6vrjByhRtYgYwo0NQeHZjDGsShq5EHZXvfcaw7u52b8FP0EObDwuSg2pc7UPuOO4L8015a0S9rT58DycuhTgsoZIEdKhYrkQj5kbhSD8T2UblIytYxeXtbo9UN5TLjqj/4TaZ9PSrohgLOvRxpkNXJQcLhulnKPYikP4=
In-Reply-To: <Pine.LNX.4.63.0612050841160.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33324>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrWGV-0006zt-2u for gcvg-git@gmane.org; Tue, 05 Dec
 2006 10:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967575AbWLEJHA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 04:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968104AbWLEJHA
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 04:07:00 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:12067 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S967575AbWLEJG7 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec
 2006 04:06:59 -0500
Received: by nz-out-0102.google.com with SMTP id s1so2047756nze for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 01:06:56 -0800 (PST)
Received: by 10.65.188.20 with SMTP id q20mr13928206qbp.1165309616284; Tue,
 05 Dec 2006 01:06:56 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Tue, 5 Dec 2006 01:06:56 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On 05/12/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 4 Dec 2006, Catalin Marinas wrote:
> > I'll first move the message back to stdout.
>
> In other parts of git, the progress message is only printed if output goes
> to a tty. Why not do the same?

Thanks for the hint. This seems to me like the easiest solution.

-- 
