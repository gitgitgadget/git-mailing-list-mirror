From: hasen j <hasan.aljudy@gmail.com>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control 
	end-of-line conversion
Date: Sun, 9 May 2010 01:30:10 -0600
Message-ID: <o2h600158c31005090030uba3686e3v8bfe0be02bf2283d@mail.gmail.com>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> 
	<c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> 
	<alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> 
	<E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> 
	<20100509070043.GB14069@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	mat <matthieu.stigler@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 09:30:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB0yE-0003VT-HH
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 09:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365Ab0EIHad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 03:30:33 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:62608 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab0EIHac (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 03:30:32 -0400
Received: by ywh36 with SMTP id 36so1403465ywh.4
        for <git@vger.kernel.org>; Sun, 09 May 2010 00:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=AI8AII3IXO16xSpmJsjCw6PZ2w3ZgJ/QyJYekUWM1es=;
        b=GIL+KG3Qtu0u9OS4oZIFZT8ysyQueGcNdRVWFxkn7pjSPe6c8DAkinVZPXFbI4oRO9
         JwzAJEH+ZpLJ4DsbAfn+FQfdkT/el0R6LrFGuotpSV2fbWseTIDD0HcCGHA+US914Xrb
         zrm/UJPxbBAyAjHj3VKXRRp/E9LW1mEZI6C54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=PxnsptCB9EK1zo7F4cySAAyyjpE4VnL6Y8Hkg3YwFEObcour9E6SZMQJKW9OYEEkWY
         zJz+07Ee6kPstChSzHnRrNawgg40n04Qs7cj6s0/d9NOVam2T41lVqHXaLUikIGg638m
         +gUH+B6nL1zNJ6n8mEuNspAZuhoO3FEcJflVo=
Received: by 10.90.247.29 with SMTP id u29mr1320142agh.109.1273390230187; Sun, 
	09 May 2010 00:30:30 -0700 (PDT)
Received: by 10.90.79.17 with HTTP; Sun, 9 May 2010 00:30:10 -0700 (PDT)
In-Reply-To: <20100509070043.GB14069@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146707>

On 9 May 2010 01:00, Dmitry Potapov <dpotapov@gmail.com> wrote:
> [...] Also,
> I would rather call default as "default" instead of "native". So,
> why not use "core.crlf={true, false, default}"?

default and native have completely different connotations. default
makes me think "one of true or false, which ever happens to be the
default". native is a better fit here.
