From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/4] Support triangular workflows
Date: Mon, 18 Mar 2013 19:58:23 +0530
Message-ID: <CALkWK0=D6JmocJJcLJTV6z-TcyuJL35cDpozaa6t64V_W2KSRQ@mail.gmail.com>
References: <1363612575-7340-1-git-send-email-artagnon@gmail.com> <20130318142526.GA23075@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 18 15:29:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHb3n-0002eb-Ll
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 15:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883Ab3CRO2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 10:28:44 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:46289 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab3CRO2o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 10:28:44 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so7057043ieb.34
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 07:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=suVncQBTerda+P27Q0GMFg0yM4rIDTa8jYtZz66n0Os=;
        b=MPajDUFoteDGSacQZPTgcq/7q93ryS5DSEU9FpylOW8pw0I9tjXa89wgCVHu7jW3eW
         AVYvvNG2YqJxUQIwyiCCGZJslzJ8R2XgKrSSJ0+zp4CUnjhtkZWBvN+5EdPvPRvToVhC
         9I+lpkKz1iC/BuzsCvKR143qp33xdZNNkc8ycMWyMdTqMNqeGukpfHPfLV3AD7JxdTJi
         QxTMEXI8PLnunEkkvMUfppi4kbIEBaHg1HMWz3w9Kzprp9afT44HiP/dv7oRpyiiCKuZ
         iEuc2Y4JO5/2vRPeGXJ72Xl5hIHu5sF0DTTUm4Ur9aHqE+ZDXsjuNeEfOBFgKojwV/c+
         WbkA==
X-Received: by 10.50.17.71 with SMTP id m7mr6146075igd.14.1363616923899; Mon,
 18 Mar 2013 07:28:43 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Mon, 18 Mar 2013 07:28:23 -0700 (PDT)
In-Reply-To: <20130318142526.GA23075@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218418>

Jeff King wrote:
> On Mon, Mar 18, 2013 at 06:46:11PM +0530, Ramkumar Ramachandra wrote:
>>  Documentation/config.txt | 23 ++++++++++++++++---
>>  builtin/push.c           |  2 +-
>>  remote.c                 | 60 +++++++++++++++++++++++++++++++++++-------------
>>  remote.h                 |  1 +
>>  4 files changed, 66 insertions(+), 20 deletions(-)
>
> No new tests?

Honestly, it slipped my mind.  Will write it now.

Thanks for the reminder.
