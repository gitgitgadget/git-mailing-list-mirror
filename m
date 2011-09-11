From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 0/4] Signed push
Date: Sun, 11 Sep 2011 10:53:24 +0200
Message-ID: <CAGdFq_gzmkzGrWeSfZwPNWWSkXBsTm+e52J6GxEAdt78+KWOag@mail.gmail.com>
References: <1315512102-19022-1-git-send-email-gitster@pobox.com>
 <1315600904-17032-1-git-send-email-gitster@pobox.com> <7vipp1otyp.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hWVPCEeJKKccp4Wc-j+XMSFXqRf6VYd7ngLER8RhODRQ@mail.gmail.com>
 <7vehzopdga.fsf@alter.siamese.dyndns.org> <20110910192225.GA5397@thunk.org> <7v4o0jq2fx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Ted Ts'o" <tytso@mit.edu>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 10:54:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2fnv-0005nr-JH
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 10:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207Ab1IKIyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 04:54:07 -0400
Received: from mail-gw0-f42.google.com ([74.125.83.42]:35498 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961Ab1IKIyG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 04:54:06 -0400
Received: by gwb17 with SMTP id 17so3016068gwb.1
        for <git@vger.kernel.org>; Sun, 11 Sep 2011 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=of5B5L0gog2fFkkzZ5o4rTQTT3PHpBaXD0XDQYFHVOM=;
        b=oumAzOSnBIoVNY9pDxWOXXjicLIhJseuSXf5Z/ZZ4h/OHrcjvYVgwsd8hNBlKUKYXR
         Cg79stiOCoeubRToqml/OfayG8XJnEzCd8rLEWqHhRV9AUvHUoKgUXvCatMiTg3yeAVL
         JgBHAlVX/PWlOhuQztnOaw5R1gWhe15JIfktg=
Received: by 10.68.6.1 with SMTP id w1mr811777pbw.366.1315731244224; Sun, 11
 Sep 2011 01:54:04 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Sun, 11 Sep 2011 01:53:24 -0700 (PDT)
In-Reply-To: <7v4o0jq2fx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181168>

Heya,

On Sun, Sep 11, 2011 at 03:42, Junio C Hamano <gitster@pobox.com> wrote:
> I do not know if you read the message Sverre was responding to, but the
> "you have to have local copy" requirement has another and potentially
> bigger downside (which Sverre did not quote) for people who push out to
> multiple places.

That's not what I meant though. I was responding to your "than you can
later _inspect_ the certificates from multiple locations". I was
indicating that it would be easier to do such inspection if you can
optionally fetch the notes from different remotes to different
locations in the refs/remotes namespace.

-- 
Cheers,

Sverre Rabbelier
