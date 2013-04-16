From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/3] fast-export: add --signed-tags=warn-strip mode
Date: Mon, 15 Apr 2013 21:09:53 -0700
Message-ID: <CAGdFq_jCO_+qj87rtcFyFG2tot8Ah2706X2dm82F6=GBV-g6nw@mail.gmail.com>
References: <CAGdFq_g+kk-Fy1fcV6D5x4kroRXX63T8wjKNUqqfu39wUkSO6A@mail.gmail.com>
 <cover.1365936811.git.john@keeping.me.uk> <8716b887972b0eb1671afd2692416efd588f7d1d.1365936811.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Apr 16 06:10:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URxE8-0008Fj-0E
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 06:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522Ab3DPEKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 00:10:35 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:41969 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab3DPEKf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 00:10:35 -0400
Received: by mail-ie0-f178.google.com with SMTP id bn7so72591ieb.23
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 21:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=e/n4Z/XMZJ5FLdvLEVilmT3krANrFxlu2FEPcDJnR/8=;
        b=j6g2Oq3YubakS2Ucn5ZJAeyAkkxhPw6ap7fNg/1cjo6aIBnr6iLIMUIRG6EWqymowf
         QgvMSzr0HrkExRsXhPbQJlmr5Ev+m1BHhxhm7WPcJk9MRikQ7CJPVzKSxOZnQ8txDQO8
         kCmnXdgaZWADdKerchmBFNWK7gSAmEisyWXlk4+/4PPwFvV1/ZmitHEKP2KhaVbhXj3S
         +aV6USjF6r1iA79iAVIze+VzquTJSwhYqJYbqnmqHgj3WDQi1W62Waia7JOE7aWTBQJy
         MFZ6VbHZToqZxe5FRv+RON4ya9rEqaKEk0M0AX6N9rT2ZWGvgpbqKJ6EP3Z9B67fUQsL
         yD2w==
X-Received: by 10.50.55.8 with SMTP id n8mr341268igp.28.1366085434587; Mon, 15
 Apr 2013 21:10:34 -0700 (PDT)
Received: by 10.50.157.229 with HTTP; Mon, 15 Apr 2013 21:09:53 -0700 (PDT)
In-Reply-To: <8716b887972b0eb1671afd2692416efd588f7d1d.1365936811.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221357>

On Sun, Apr 14, 2013 at 3:57 AM, John Keeping <john@keeping.me.uk> wrote:
> This issues a warning while stripping signatures from signed tags, which
> allows us to use it as default behaviour for remote helpers which cannot
> specify how to handle signed tags.

Perhaps it makes sense to instead count the number of signed tags and
emit "Stripped signature from %d tags"? For example, for git.git it
would be on the order of a hundred warning lines.

--
Cheers,

Sverre Rabbelier
