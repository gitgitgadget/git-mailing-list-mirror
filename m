From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] git-p4: add optional type specifier to gitConfig reader
Date: Thu, 03 Sep 2015 14:31:26 -0700
Message-ID: <xmqqio7ri40h.fsf@gitster.mtv.corp.google.com>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com>
	<1441298148-63885-2-git-send-email-larsxschneider@gmail.com>
	<55E8A5C2.9090500@diamand.org>
	<A76D6BC6-E0AD-48F4-AE33-80BD0803BFA3@gmail.com>
	<xmqqmvx3i7dg.fsf@gitster.mtv.corp.google.com>
	<6FAAE139-9010-4C68-AA97-2739E9A09564@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 23:31:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXc6Y-0001vT-0e
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 23:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757332AbbICVba convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 17:31:30 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33086 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753AbbICVb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 17:31:29 -0400
Received: by pacex6 with SMTP id ex6so2211183pac.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=OZ2MAlihEAm07X5mVg/LFWlSuIhAF4Y+hKW9JVsKEa4=;
        b=tjnUf6cE9EzwDTmqXlG+KUsPCIabqhPmoAsaW4KdLIhTXTtb2Oz+tbSLRqNrUyqXqK
         EreLU+0qha5p0h4WC3ITsSVHE+fVs2kg+x12h9yLI+m/GJ9wsZgoP0boQ7sO+yMnZlav
         gPgZTg9U1y4qNwctnn/+PsbNudcZvm8S08fDLE074BwDljyu3GsBw/rjL7hZ5XQu2ltt
         jMSk7Bh111+e946eCRZNevHb+SpUejezG/md63gC77Z4auoB7oG60ohaEJJxT0CJ/x5k
         KXFYauSierwpwh4qyLVUyTh22lTVi6fC7s3e3r/ObL/dlxCsiuGFmOGMpZAUplWksDEv
         TgPw==
X-Received: by 10.66.245.142 with SMTP id xo14mr13361pac.151.1441315887807;
        Thu, 03 Sep 2015 14:31:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id iv2sm69413pbd.88.2015.09.03.14.31.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 14:31:27 -0700 (PDT)
In-Reply-To: <6FAAE139-9010-4C68-AA97-2739E9A09564@gmail.com> (Lars
	Schneider's message of "Thu, 3 Sep 2015 22:53:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277259>

Lars Schneider <larsxschneider@gmail.com> writes:

> In case I agree with a reviewer. What is the more appropriate action?
> A response like the one above or a new role that includes the change
> right away? I don=E2=80=99t want to spam the list with lots of tiny c=
hanges=E2=80=A6

Responding to review comment like you did with "will do" is
perfectly fine.

When you do think you will (eventually) want to send an updated
patch, there are things other than "will do" that you can say.  "I
understand what you said, but I am not sure how exactly to make this
better.  Perhaps lend me a help?" is good, too.

An explanation, followed by "ok?", in response to "it is unclear
what you are doing here" (commenting on code) or to "I cannot
understand what this is trying to say" (commenting on log message),
is problematic because your intention becomes ambiguous.

The reviewers are rarely saying "I do not understand; educate me."
but "I do not understand, and it is likely many others don't, too.
Make it more easily understandable." is what they mean.

An explanation with "ok?" can be taken as a sign that you mistook
the review comment as "educate me".

	What I meant was ....  Do you think commenting the code here
	with the above description is good enough?  Or do you think
	of a way to restructure the code itself to be more self
	evident?

or something like that may be a way to avoid the ambiguity.

Thanks.
