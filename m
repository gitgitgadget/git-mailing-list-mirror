From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git am" and then "git am -3" regression?
Date: Mon, 27 Jul 2015 07:21:27 -0700
Message-ID: <xmqq8ua1k7fc.fsf@gitster.dls.corp.google.com>
References: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
	<20150724180921.GA17730@peff.net>
	<CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 16:21:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJjHb-0002rh-6a
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 16:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbbG0OVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 10:21:31 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35145 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbbG0OVa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 10:21:30 -0400
Received: by pdrg1 with SMTP id g1so52935906pdr.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0pJkmiySwZwXwg/hSmt0HQGJa4KT5owAA3CuL9G0KZY=;
        b=J3BNJmSOTzL10UjTL2WqVmi2qeRBnuv0PobY/ZgYinsmsv3O72tLovuDRqKNOzE1Bs
         0J5H5KYhsKCDmKTy3b1D8sgoZOE3cBhyBanEkO0mJsf8cAGrGwv0d7PhFC97Iagl8ys+
         jfMsxxrJ9699DViMcwwo3J2cweDZFCtiwmgKmGCzAkmLsd01XoBiBAKDjQH7ZRRNfIWY
         LC07e98lI8YbJd1x85nC9eAKAx9Ou5JNxG0/ih1pGC83tcT2pYLbnZlZy4HINNKj1/cj
         6SuUNymnyx5M7HR/joie8N+XCYgawey/bAD8YmABdFjwCKQTS3dEuq6/12p5LI83IJBY
         Dt6A==
X-Received: by 10.70.20.196 with SMTP id p4mr68887504pde.58.1438006889839;
        Mon, 27 Jul 2015 07:21:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2496:725d:b368:d039])
        by smtp.gmail.com with ESMTPSA id t2sm29817590pdo.81.2015.07.27.07.21.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 07:21:29 -0700 (PDT)
In-Reply-To: <CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
	(Paul Tan's message of "Sun, 26 Jul 2015 13:03:59 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274679>

Paul Tan <pyokagan@gmail.com> writes:

> Junio, how do you want to proceed?

I'd expect that builtin series would graduate in 2 releases from now
at the latest, if not earlier.  Let's just revert the regressing
change from the scripted version and have it implemented in the
builtin one in the meantime.  I do not think it is worth adding
features to the scripted one at this point.

Thanks.
