From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git configure/make does not honor ARFLAGS
Date: Sun, 13 Sep 2015 21:57:08 -0700
Message-ID: <CAPc5daUBBPRxaaptTS9xyr+pJ6Fgt4XXi+MU=DSZeoQ6uHCHvg@mail.gmail.com>
References: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
 <20150913101727.GB26562@sigill.intra.peff.net> <CAPig+cQV-kaDDdBH+QZXsSjDHjP2CUYDXp3WKSBtgguVmLvofg@mail.gmail.com>
 <20150914043016.GA10167@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeffrey Walton <noloader@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 06:57:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbLpr-0008P2-RL
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 06:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbbINE53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 00:57:29 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38325 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbINE52 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 00:57:28 -0400
Received: by igxx6 with SMTP id x6so74027749igx.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 21:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CYKbBeOBn8Kpj/8tV/Ar6F09EwI0HsE5umwhC4oFEfg=;
        b=o46aTp89Oj2ah+GHUN5LOQF6TSBnWrvkwkLB1fF307iHrc1bUqltgMwqCPFy0Apb1W
         GfjaNTW2W9/sgoABIMZYu4joplqlG1c3Q1S7hVBqoFhx8Eyqvxc8lMfvIvQFU/C+KnhJ
         k3HxheQg/zLdjac5Cq6HglhHWJFijDv/V/6c3ISfHtxk4FQ8icbYczmhb8TMoz+fuHki
         ZoHJjsmyz777dtmVkB5tp7IfRiHWb9zBf1jsGUAGH1MwMkoXOm2gGPE5Cqef4Sbmq0Sy
         V3N3TVelO8uo7KD4LfDFhl/sjaOLA5+x15C/HNPhaKVsDgtt/252Or8Fng/iUFxaUmnn
         qFLA==
X-Received: by 10.50.117.100 with SMTP id kd4mr13761709igb.75.1442206648199;
 Sun, 13 Sep 2015 21:57:28 -0700 (PDT)
Received: by 10.36.79.69 with HTTP; Sun, 13 Sep 2015 21:57:08 -0700 (PDT)
In-Reply-To: <20150914043016.GA10167@sigill.intra.peff.net>
X-Google-Sender-Auth: LIbFSad4cHLJcnvtTeAfsE824So
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277804>

On Sun, Sep 13, 2015 at 9:30 PM, Jeff King <peff@peff.net> wrote:
>
> Ah, OK. Today I learned something. :)
>
> Jeffrey, can you produce a tested patch which works for you?

If I am not mistaken, I think I already have one on 'pu' (I think I did that
as an afternoon-tea time hack or something).
