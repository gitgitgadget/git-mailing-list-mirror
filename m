From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH v2] blame: Add option to show author email instead of name
Date: Thu, 21 Oct 2010 13:54:22 -0700
Message-ID: <1D51CC29-0248-4C12-BD1B-4013434AEA03@sb.org>
References: <7vsk02ypj5.fsf@alter.siamese.dyndns.org> <1287535323-20347-1-git-send-email-kevin@sb.org> <20101021180525.GA11501@burratino> <79AB0864-E151-468E-9C86-EBCAD929938B@sb.org> <20101021203210.GA12685@burratino> <20101021205358.GA29377@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:54:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P929e-0002bC-U5
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461Ab0JUUy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 16:54:26 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60144 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab0JUUy0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 16:54:26 -0400
Received: by pwj3 with SMTP id 3so94084pwj.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 13:54:25 -0700 (PDT)
Received: by 10.143.35.18 with SMTP id n18mr1352997wfj.179.1287694465658;
        Thu, 21 Oct 2010 13:54:25 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm3051865wfg.8.2010.10.21.13.54.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 13:54:24 -0700 (PDT)
In-Reply-To: <20101021205358.GA29377@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159567>

On Oct 21, 2010, at 1:53 PM, Jeff King wrote:

> On Thu, Oct 21, 2010 at 03:32:10PM -0500, Jonathan Nieder wrote:
> 
>> No preference, since I never use "git annotate" myself.  In fact,
>> long term, I'd rather see a "git blame --format=<template>" appearing
>> and "git annotate" replaced with a thin script wrapping "git blame".
> 
> Isn't that what it is already?
> 
>  $ grep blame builtin/annotate.c
>  return cmd_blame(argc + 1, nargv, prefix);
> 
> -Peff

IIRC, git-annotate is equivalent to `git blame -c`, which is why the tests for git-blame
are so useless (they're all tests for `git blame -c`, which makes them identical to the
tests for git-annotate).

-Kevin Ballard