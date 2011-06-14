From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 14 Jun 2011 12:34:47 +0200
Message-ID: <BANLkTikxwUhrfiYkd0ci0cps2=S4TYcRoQ@mail.gmail.com>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <7vtybtm3dl.fsf@alter.siamese.dyndns.org> <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com>
 <201106141202.46720.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 12:35:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWQy5-0006y6-L8
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 12:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab1FNKf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 06:35:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36549 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042Ab1FNKf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 06:35:28 -0400
Received: by pwi15 with SMTP id 15so2549047pwi.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=eA1oEWm/AAtlJp4b9SAcTpLQq7M59c+WmtZ0aOOs250=;
        b=aO8GC0d1m6Z+VzKOo5XDRkE6ftfxIi9xZNzRBbswCrRWkTnOzeEyFFjCWd8bihKibA
         df/JMmX/Lejd9J8m8tFhVqCQ45hsvjLc1yE2fv7ksWRq3ECT0BM3rUofx455XxCzVQPb
         3x0g1v76wvFXQA6mIVWnqK3qpj3vUKlwriwP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gmZGEJCIv/DJUydxyfdNGh/k4ytyBlv0LBNlsPzinqItV4PhGVvBuU+LfvSAQLp6s2
         mLBB6wWzVfHLFYajl9g5bePYDk/c4MqLaE96r3nNf08snxkOx4YEQKwq6scihsm3qL7t
         d9h/syWfyuLsocUAqlktq2wOSBqDqAMvIYmkw=
Received: by 10.68.22.3 with SMTP id z3mr2728871pbe.142.1308047727235; Tue, 14
 Jun 2011 03:35:27 -0700 (PDT)
Received: by 10.68.41.99 with HTTP; Tue, 14 Jun 2011 03:34:47 -0700 (PDT)
In-Reply-To: <201106141202.46720.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175760>

Heya,

On Tue, Jun 14, 2011 at 12:02, Johan Herland <johan@herland.net> wrote:
> Not quite sure what you mean by "create a note on 'r651235'". You could
> devise a scheme where you SHA1('r651235'), and then create a note on the
> resulting hash.

I was thinking they could annotate anything, even non-sha's, but in
that case, yes, the sha of the revision would work just as well.


-- 
Cheers,

Sverre Rabbelier
