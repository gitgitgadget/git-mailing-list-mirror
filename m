From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 17:26:20 -0500
Message-ID: <53559b0cc066_6c39e772f09d@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
 <53558476703cb_5c94d452ec4e@nysa.notmuch>
 <53558A54.4060801@gmail.com>
 <53558ae6f1282_604be1f30cf3@nysa.notmuch>
 <53559020.1050407@gmail.com>
 <xmqqa9be8i4o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 00:36:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcMpU-0000fE-7A
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbaDUWgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:36:44 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:60148 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027AbaDUWgm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:36:42 -0400
Received: by mail-yh0-f52.google.com with SMTP id 29so2168861yhl.25
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=gGWKKIZBT/4Rc0fsYX7AGYGORQxOajFdv3sjXIhEXkU=;
        b=j72gbGhqxakf0NLYdGmzVIuKqRuL3WbQGWpRgONdFLdg546tLCM6qbrjF4mUolHS9v
         uTxQDFun4xhCM4KIarT0aQRyLdQaSKzb93nxOD4Q/BwlBAO4JxFuQ9ZXb5XNOcd5R6Cz
         EF/DXeSqBijqprJZwfqvNjUDl+no2Rji1GIwByGrw/TGoGTLvxBzDA3PnQaRPcEn48sb
         ljGFNKNMJr4giT0ahjcqPjYVYkBf69Rf6WyaMhU/KcJa7Lc8svyqLdaZ8wvxeMM6S74H
         sO0L9axaIdej+5/USMnZbAsd2Rmg73gkhDidHqR5iPtoXMwX1DnvE6GnZUrYFFvTLVDu
         pmdA==
X-Received: by 10.236.53.5 with SMTP id f5mr56613439yhc.53.1398119802160;
        Mon, 21 Apr 2014 15:36:42 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id z69sm75019979yha.26.2014.04.21.15.36.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 15:36:41 -0700 (PDT)
In-Reply-To: <xmqqa9be8i4o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246661>

Junio C Hamano wrote:
> Ilya Bobyr <ilya.bobyr@gmail.com> writes:
> 
> > On 4/21/2014 2:17 PM, Felipe Contreras wrote:
> >> Ilya Bobyr wrote:
> >>
> >>> Also, most have names that start with either "pre-" or "post-".
> >>> It seems reasonable for both "pre-update-branch" and
> >>> "post-update-branch" to exist.
> >> I don't see what would be the point in that.
> >
> > Do you see the point in the other hooks doing that?
> 
> pre- and post- are primarily so that people can tell that "pre-
> happens before the operation and its primary motivation is to stop
> an operation from happening" as opposed to "post- is called after
> the fact and there is no way for it to intervene---it is too late;
> it is primarily for things like logging" easily.
> 
> As long as you can tell what you can use it for and when it is
> called from the name of the hook, there is no fundamental reason why
> you need to have pre- or post- prefix in your hook names, but unless
> there is no other strong reason not to, it is probably a good idea
> to follow suit.  There is not much value in trying to be "original"
> in naming things, just to be different; it will only confuse the
> users.

It's not original; there are _already_ hooks without pre/post. And it's not
confusing, "update-branch" doesn't tell much, not any hook name could, that's
what the documentation is for.

-- 
Felipe Contreras
