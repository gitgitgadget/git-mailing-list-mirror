From: Julien Cretel <j.cretel@umail.ucc.ie>
Subject: Re: Should "git log --decorate" indicate whether the HEAD is detached?
Date: Thu, 19 Feb 2015 11:13:42 +0000
Message-ID: <CACdBeKnqZuu50knWs=aCm7295no880EN9TYY+hMnfSdVvdZ4AA@mail.gmail.com>
References: <CACdBeKmNazMtzK4hdd7WXMPDr7HdPe+EFpyd3M-TPBAUEY+HpA@mail.gmail.com>
	<xmqqa90d4fdp.fsf@gitster.dls.corp.google.com>
	<CACdBeKnWJvUmFaHNrzcX7LtovOLu3PFaeTyoUAUeC7wmYUboDg@mail.gmail.com>
	<54E46635.4060009@drmicha.warpmail.net>
	<xmqq8ufv408l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:13:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOP3F-0002mz-2M
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 12:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbbBSLNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 06:13:44 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:37992 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbbBSLNn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 06:13:43 -0500
Received: by mail-yk0-f177.google.com with SMTP id 20so3716258yks.8
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 03:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Z/uq33VjANfPbLEt2jp+Y9mcv4IbZS7P6VZ3dFMzkGI=;
        b=AawkQu24sAef8pZ7tKY2bLOb43vb2dWci0ROndA448bOqZP0GIksC7xjIBiWvZOQlq
         AojCN2nJX0VCQ0oc2tzDZB4i3+ALe7v+Ka2sLDijIz36yVGHh8oi43M7qwMz1V16oxCI
         FQARpGyFBWGIAi9IJesWrIrfqy1MVOYlChtFcZ8fEhawOUbLFfepN9aAbQUtJSc42pCI
         1P2Alwzx7d/cT6XNVhRiOgk6dprUTeSnXZzwFmvyX+sDJGlCAecQyLxoobWWgESt/ERv
         zuVJherS9Iumgt8kcWCcKbqlTz48qrn0HfPwGfEF6NfVHkUjEKwJGDD0DUGiWpdYqwfC
         wcHQ==
X-Gm-Message-State: ALoCoQmdbo0Mhiu10gg7O4SSqm5Mfdq4sSgfvAthwYD8x+Z5xMQ+EuFqzNUWgRv0BwO0tLH/QrT8
X-Received: by 10.236.1.38 with SMTP id 26mr2169149yhc.163.1424344422236; Thu,
 19 Feb 2015 03:13:42 -0800 (PST)
Received: by 10.170.36.197 with HTTP; Thu, 19 Feb 2015 03:13:42 -0800 (PST)
In-Reply-To: <xmqq8ufv408l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264091>

On Wed, Feb 18, 2015 at 5:07 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Julien's "HEAD=master, other" vs "HEAD, master, other" may be
> subdued enough to be undistracting, I would guess.  I do not think
> the distinction between "HEAD = master" and "HEAD -> master" would
> be useful, on the other hand.

Just to clarify, I suggested these two notations as alternatives for
denoting the same state: "HEAD is attached to master". They were not
meant to denote different states. Accordingly, a detached HEAD could
be denoted by "HEAD, master, other" (i.e. the same as the current
output of "git log --decorate").
