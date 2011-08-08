From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 10/48] t6036: tests for criss-cross merges with various
 directory/file conflicts
Date: Mon, 8 Aug 2011 13:07:42 -0600
Message-ID: <CABPp-BGbwhDJF2=9gPWP08auk16qckho3db8eOes9JjTN0QdCw@mail.gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
	<1307518278-23814-11-git-send-email-newren@gmail.com>
	<7v39i3b1jg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 21:07:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqVAz-0006pe-Cy
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 21:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140Ab1HHTHo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 15:07:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50438 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab1HHTHn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 15:07:43 -0400
Received: by fxh19 with SMTP id 19so5659626fxh.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fDwRjrj+OnMUEayJrIs74ttsDf0cNXqtYE0O4swmEH8=;
        b=lB7wY2ngcrD8DwEOb7soG8LMB8wBxqB+ib8TXXA8B4oGXZa+pxfnJSSQntr8cfAhte
         yDPhr2RpzWRaqLH3XUecrKA0unG3N/yn9B8BzgN3IrVOJhYZIfNGlW3iN542/qE1rjAU
         e8ewjlBOgh4fYKVECx+RuMLJmpMXZ+XCMWdoQ=
Received: by 10.223.52.66 with SMTP id h2mr7991279fag.92.1312830462097; Mon,
 08 Aug 2011 12:07:42 -0700 (PDT)
Received: by 10.223.123.13 with HTTP; Mon, 8 Aug 2011 12:07:42 -0700 (PDT)
In-Reply-To: <7v39i3b1jg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178969>

On Mon, Jul 18, 2011 at 5:40 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> +test_expect_failure 'git detects conflict and handles merge of D & =
E1 correctly' '
>> + =C2=A0 =C2=A0 git reset --hard &&
>> + =C2=A0 =C2=A0 git reset --hard &&
>> + =C2=A0 =C2=A0 git clean -fdqx &&
>> + =C2=A0 =C2=A0 git checkout D^0 &&
>
> Why do you need to reset twice? =C2=A0Superstition (you have a commen=
ted one
> introduced later in the series --- perhaps this shows a bug in reset)=
?

I could have sworn that when I first created these tests last
September that the double reset was needed to get back to a clean
state.  I can't seem to duplicate the issue now, though I do see some
"error" messages printed on the first reset despite the reset working
successfully.  I'll drop the extra one.  *shrug*


[I'm not ignoring the many other good comments you made on this patch;
they just got incorporated into code and comment changes for the next
version of the series I send out.]
