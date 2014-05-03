From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH] subtree/Makefile: Standardize (esp. for packagers)
Date: Sun, 04 May 2014 08:12:54 +1000
Message-ID: <6e64be78-58d0-42c5-97de-aaf9310f014d@email.android.com>
References: <1398304336-1879-1-git-send-email-nod.helm@gmail.com> <CAHYYfeGNDLVxzP6zMyJnSi8GxpQaUKGAkqaLfXbZ=8B1k7vvyQ@mail.gmail.com> <3cb4338e-de68-404d-86dc-70cac7e13606@email.android.com> <20140426072520.GB7558@sigill.intra.peff.net> <6a7bcc79-d9c3-4cf8-8f3b-a6a16298c221@email.android.com> <20140430032045.GA4613@comcast.net> <CAHYYfeGNO5QknoKkZfYy3XLNRZsVmf0WjeNGkDxH3QwPF-RsUQ@mail.gmail.com> <5365420874947_27397d32f016@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Sun May 04 00:13:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgiBB-0006oi-Mm
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 00:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbaECWNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 18:13:05 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34405 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbaECWNE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 18:13:04 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so4218435pdj.10
        for <git@vger.kernel.org>; Sat, 03 May 2014 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=ao+XtPkeYlBacalByVrxQ+pJMg04rX9OU9i8xR3c+Rg=;
        b=JPeSDlDanmYazwz/K7HT9JNtIq6hcfJixmuuojNEIYen5TAWAbmL7kZUV8smBpIXVO
         b2f1zfx/envb4IXAXpmdmWFTZGmTOkgCHCK9KRGBWbBz9VngSeq8F/p5sl9HQqCid91Y
         FHhC70XqsNB30KZZZNQbT7KENmon4HRNgInvbouLlJjLegq2zhhm/90no1hEqqOPqtG8
         69l/cz5hVfWQlyUafOEZ4r258VTpCjRXfkKDabPb6m3l+wGuGbKkGbC/ZfxmGOVUNw/8
         Wj2baeIAGUNxMkZR3nE5xGqVPsBlnR+T5xbXYl657GYGhvnpO8TACfIX6EgusjmYTHiT
         CuGg==
X-Received: by 10.66.147.130 with SMTP id tk2mr9711249pab.125.1399155182793;
        Sat, 03 May 2014 15:13:02 -0700 (PDT)
Received: from [10.94.180.28] ([101.119.29.196])
        by mx.google.com with ESMTPSA id qx11sm28769711pab.35.2014.05.03.15.13.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 03 May 2014 15:13:02 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <5365420874947_27397d32f016@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248060>

On 4 May 2014 05:22:48 GMT+10:00, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>I think you should take a look at the Makefile of
>contrib/remote-helpers. I bet something simple like that would work
>just
>fine for subtree.

The current makefile is simple enough, just quirky and likes
to be a special snowflake. 'sall good, the v2 addresses most
of my immediate concerns with it.

Regards,
James Denholm.
