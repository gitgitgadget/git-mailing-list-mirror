From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email.perl: Add sendmail aliases support
Date: Thu, 21 May 2015 14:38:37 -0700
Message-ID: <xmqqwq01haqq.fsf@gitster.dls.corp.google.com>
References: <3f1091c3de6e4e62037bc3c84c69026e33ee9707.1432229888.git.allenbh@gmail.com>
	<xmqqioblisyk.fsf@gitster.dls.corp.google.com>
	<CAJ80satMSCGydLRb5k=xpSqxXSBL=_T7nsHEz3jsuFV9MdmmtA@mail.gmail.com>
	<CAPig+cQFana40n=SCBOC0P2v4Ss7Via3eS6Ms2rU=M9_V_3Osg@mail.gmail.com>
	<CAJ80savEBYGKLJx8pN+4xsDodi0PJcV2YHJLukDKztg3YV__FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 23:38:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvYB5-00045V-GD
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 23:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756574AbbEUVin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 17:38:43 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35495 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756533AbbEUVij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 17:38:39 -0400
Received: by igbyr2 with SMTP id yr2so21254944igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 14:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4U4ZzDZxYoh22HnsI5MUYz1Cjg4K40SANDevb+Q9Cok=;
        b=CmtrIGlU28XbFNsJwrNqnCVeJrMra1PoeaTwDyp4hmXmCB6QSQO3kuamx6gBT34x5l
         PGPkFAH+b6Z5rbmz09m0yp5l/e9lJp/iJsPXs6fJEJiFV2iNIkWp9TW/E6Ho1HF6emNx
         SpfYYWC/8MwdwicX9zN7Ied4GmuOwU1tWDum220KcemhTqNvJ2MJVbp4SpljqsSyAr9Y
         aYjFgGfaR80BD/eUO97MHF32Hd+3xO7jhoh69i/QeWLotN6g8G0XeNCsbodl0IlQTWaq
         NKDr5s3qPL19vouE4G0zJaXmwJLFuDYg5Qkcm725012K4hOLaK9lR2uDGanu7IqIRztL
         87TQ==
X-Received: by 10.50.61.200 with SMTP id s8mr1082458igr.7.1432244318929;
        Thu, 21 May 2015 14:38:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id c20sm73874ioc.40.2015.05.21.14.38.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 14:38:38 -0700 (PDT)
In-Reply-To: <CAJ80savEBYGKLJx8pN+4xsDodi0PJcV2YHJLukDKztg3YV__FQ@mail.gmail.com>
	(Allen Hubbe's message of "Thu, 21 May 2015 17:30:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269666>

Allen Hubbe <allenbh@gmail.com> writes:

> Those are good points.  Maybe I shouldn't even mention sendmail at
> all, not in the name of the format, and not in the commit message.
> What name would be a good name for this format?

"simple"?

And if you are going to define such a format, then I do not think
you would even need to pretend that someday you might support
line folding (hence there is no need for "eh, excuse me, you seem to
have wanted to express a long folded line here, but I do not support
it (yet)" warning messages).
