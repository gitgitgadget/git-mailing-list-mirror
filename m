From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] pager: drop "wait for output to run less" hack
Date: Tue, 5 Jun 2012 17:52:24 +0200
Message-ID: <CABPQNSbhgan+i_Q142R8VvRdJ5T+GyYHqgEJ6KS-BBJguRu-OQ@mail.gmail.com>
References: <20120605085604.GA27298@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 17:53:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbw4F-0006ur-Ep
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 17:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab2FEPxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 11:53:06 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58097 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467Ab2FEPxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 11:53:05 -0400
Received: by pbbrp8 with SMTP id rp8so7627688pbb.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=0z+zaW8QpoTynk8qQGoSBWzm936hM/GZ+S4fJTWqgds=;
        b=GCuSaMtV96s7AoDRzmuX55jm3HNM3/AI1hY1erX68l3OZRJRC5IFJ9FwBkyN1Nm/4h
         Zc5EKQED89HJYeHoHLxeMVLWEtvrs4ZXupsuF0VmUvmo23GElPKoRGEhJckGgp5q3sbo
         oGKeSlNxXwj8ltnVPEyz23upPAFUlynspNSEz6e6MAASmuoyN5MHycFna12G3h0Alnzn
         LbaIri3PKzJuKREq44wF08ShAvLRGW5Dt+jqQwOacWXu3SGYSrclBXzV4xnPtN8FCO+a
         t6fJT7rByp7j8Mbeov+TUktQ8jkFYpU2ffaSekquWhSysCqPWa0eJzebQRnEeeD9o2k9
         mWRg==
Received: by 10.68.217.166 with SMTP id oz6mr3891438pbc.136.1338911584775;
 Tue, 05 Jun 2012 08:53:04 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 5 Jun 2012 08:52:24 -0700 (PDT)
In-Reply-To: <20120605085604.GA27298@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199254>

On Tue, Jun 5, 2012 at 10:56 AM, Jeff King <peff@peff.net> wrote:
> I checked, and even RHEL5 is on less 436. So besides people on antique
> "I installed less from source more than 5 years ago" systems, my only
> concern would be that some other pager depends on this hack in a weird
> way. But I have never heard of such a thing, so...

On my RHEL5 box at work:
$ less --version
less 394
Copyright (C) 1984-2005 Mark Nudelman
