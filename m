Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 17381 invoked by uid 107); 21 Feb 2010 23:18:50 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 18:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab0BUXS3 (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 18:18:29 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50218 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab0BUXS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 18:18:28 -0500
Received: by pwj8 with SMTP id 8so2030773pwj.19
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 15:18:27 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=znGHYRgeo9u34WmUYkvN7X4XycaqKj4EQe41rK5FLMA=;
        b=CEe8kWR81NZgOc2/04bpXmBuZ9VSevGsXvOPykvoYLVGPLFroxyX4aIPFrT387HLvn
         ADTtnmQnFGhWmIFynDaPHZJSKsDqI9/XfmgKNOeaT9PF7VwpscaxEVrsEMBVH7v4fn3k
         iO+hbNbZJIauZw33MkDox9kq5tc5er1BVmvF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=T4LDuN5Qc2wtsMhpY4WnbJVhzYpI+W3Y9Z+VrtfuTIoy5uK9LgY8fyaZ2vWqT4mwDJ
         NWVtsRYEJeL2orDRqQlIiojgi5Nk+0EY5UQPHWnosMAoNsN6B0saTGtjrvb46f7IUZYh
         1hEo7j5GrPacmR2rWL4ZOEWQ7EneocDfVLD2w=
MIME-Version: 1.0
Received: by 10.114.11.2 with SMTP id 2mr8824350wak.73.1266794306923; Sun, 21 
	Feb 2010 15:18:26 -0800 (PST)
In-Reply-To: <2cfc40321002211504o28069d16h4b9d1ef2230d03fe@mail.gmail.com>
References: <2cfc40321002171835j107d2cdcr5f7667d769bf391e@mail.gmail.com>
	 <20100218051129.GD10970@coredump.intra.peff.net>
	 <2cfc40321002181704i73eb87demd03faaddf9bb108@mail.gmail.com>
	 <32541b131002181913t24989addr84b612787a2f8c48@mail.gmail.com>
	 <2cfc40321002182329q7b8c5b90nbd77a4e0678cd9c8@mail.gmail.com>
	 <32541b131002191220q5a0eae6dk304173418f818ff3@mail.gmail.com>
	 <2cfc40321002191825i605e5045w6f52f9f044a5d369@mail.gmail.com>
	 <32541b131002191905u59a90866he0a38dfc661d45d2@mail.gmail.com>
	 <2cfc40321002211504o28069d16h4b9d1ef2230d03fe@mail.gmail.com>
Date:	Mon, 22 Feb 2010 10:18:26 +1100
Message-ID: <2cfc40321002211518u5eca5112wba42131341c3e286@mail.gmail.com>
Subject: Re: RFD: best way to automatically rewrite a git DAG as a linear 
	history?
From:	Jon Seymour <jon.seymour@gmail.com>
To:	Avery Pennarun <apenwarr@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Sorry, that lacked complete sense:

Thank you - FWIW, it is shaping up very well. In turns out that in
cases where the original merge was resolved in favour of the _rebased branch_,
the compensation can be squashed with the compensated commit -
effectively bringing the eventual resolution of the conflict forward in time.

jon.
