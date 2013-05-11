From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Makefile: fix default regex settings on Darwin
Date: Fri, 10 May 2013 23:44:11 -0700
Message-ID: <CAJDDKr5StD_bDr7+29qEYc4Lza+q8w=ZrHuwdSLwvCSru3YYWQ@mail.gmail.com>
References: <1368248913-95188-1-git-send-email-davvid@gmail.com>
	<20130511063132.GF3394@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 08:44:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub3Xg-00077G-UP
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 08:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465Ab3EKGoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 02:44:13 -0400
Received: from mail-ea0-f178.google.com ([209.85.215.178]:43651 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab3EKGoM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 02:44:12 -0400
Received: by mail-ea0-f178.google.com with SMTP id q15so684475ead.37
        for <git@vger.kernel.org>; Fri, 10 May 2013 23:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=qApU5noztPBcoTHUZJp4gRV9QTS54zxXJQPevdo3ep0=;
        b=tg390bsEeOy1+3t+J51NBiMmu8fBh4qOo4wUqW8iIYJD1feP4xsH3rxHLycAEvg8uu
         fTwmqSFh9AXWxBAVvbecSx4/i+VUqPzjjp21kqv5LQHTEXbu5t85V6FXzKfgGWZV1MTf
         H+nSKxPUUW9/XEIVv0p9gUcYqqLLUjKFL+m2IaDKPwrZaWPbWBy/ED8C8xVlklH+0Ygq
         as2Tz0zcJd3EYIuJ7fcpw4eCPSG5T+CVtADml2VXWmlioilA8AGmgoaepDT5vwA1pYyl
         8XUOgd0+G/iXRxMMKhKFbfdMrkUNYn5kyBxZX/z1AcFtdG5mcppBuEVzd8HrIxdhoulO
         kniA==
X-Received: by 10.14.206.129 with SMTP id l1mr49864355eeo.30.1368254651093;
 Fri, 10 May 2013 23:44:11 -0700 (PDT)
Received: by 10.14.32.65 with HTTP; Fri, 10 May 2013 23:44:11 -0700 (PDT)
In-Reply-To: <20130511063132.GF3394@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223935>

On Fri, May 10, 2013 at 11:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> David Aguilar wrote:
>
>> t0070-fundamental.sh fails on Mac OS X 10.8 by default.
>> Fix it by using Git's regex library.
>
> Can you say more about the failure?  What does
>
>         ./t0070-fundamental.sh -v
>
> say?

[..snip...]

expecting success:
# if this test fails, re-build git with NO_REGEX=1
test-regex

fatal: regex bug confirmed: re-build git with NO_REGEX=1
not ok 4 - check for a bug in the regex routines
#
# # if this test fails, re-build git with NO_REGEX=1
# test-regex
#

# failed 1 among 4 test(s)
1..4
--
David
