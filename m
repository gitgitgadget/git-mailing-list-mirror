From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Wed, 1 May 2013 01:23:29 +0530
Message-ID: <CALkWK0kUOEygRE8uMJbW=fOV6iGPAap+mbS7mysTHT3Ri+9eGg@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
 <7vppxcdjd1.fsf@alter.siamese.dyndns.org> <7vhaindcuk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 21:54:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXGcx-0000sc-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 21:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933634Ab3D3TyM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 15:54:12 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:57683 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932661Ab3D3TyL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 15:54:11 -0400
Received: by mail-ia0-f178.google.com with SMTP id j38so778198iad.23
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MiFY9a3Do7u7r6xUU48GSigm+xbCdrDDvBGwGQPiwlA=;
        b=WB+n8B05W+I9t/aI1vT8W5kWHaVCYxOG2hN8yH0JphPTlZjbxeM91WJ7C0BDco1B7u
         omYfKykp84YBgnQNSse1yYDd3eajR73KnO5rvGeJbdSRn5wHBqIkKwrTHfwHft9zVSID
         7haX68SjL3V5sX2BoKcJOGMr3woiyvHnogTlH860XxvsacPx7YoJw9BEyOKTH1s6Vm0x
         uYS5mKyFOOAC0ju+AgCafloQ/feXZF/fYt9uZK4WTCYFR2GDrlEbcQpUqmfSgUL7t6qU
         jJ4U735QYSVBzHiNO8exeR/KmwE8YfBoGYpT5gLVIJoVOe9xre2vthAzi3QcF9Pp9yAb
         PKhw==
X-Received: by 10.42.27.146 with SMTP id j18mr21361937icc.54.1367351650888;
 Tue, 30 Apr 2013 12:54:10 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 12:53:29 -0700 (PDT)
In-Reply-To: <7vhaindcuk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222997>

Junio C Hamano wrote:
> [...]
> You can't go any simpler than that rule, and there is no room for
> confusion if that rule is properly implemented.

In other words: the sequence "@" is short for "HEAD".  Isn't that
_exactly_ what I implemented in my two-liner?

However, I'm tilting towards respecting .git/@ as a manual override.
Why?  Because we'd have to either claim that git symbolic-ref @ HEAD
is a noop, or deny it altogether (by saying that @ is not a valid
symbolic ref).  The latter approach obviously sounds more sensible,
but I don't like unnecessarily eating up @.
