From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH en/cascade-tests] tests: add missing &&
Date: Thu, 4 Nov 2010 22:57:08 -0600
Message-ID: <AANLkTimYj3dW76QGdgx1F1PGxZ7_my9H=JV+FnB4aaVF@mail.gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
	<1286136014-7728-16-git-send-email-newren@gmail.com>
	<20101031014654.GC29456@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 05 05:58:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEENN-000072-94
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 05:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932Ab0KEE5L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Nov 2010 00:57:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36771 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab0KEE5K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Nov 2010 00:57:10 -0400
Received: by fxm16 with SMTP id 16so2068351fxm.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 21:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hyLT1Hjdk3PIuPe+sRH0UO7m1LZx6Uc5q2FfPHhCA98=;
        b=pySGmHhbhSG1dqSJTmgjrzydfRqcQHRTbiiWOa4FEJB1C/0SckqUA/EszJZ88qibP9
         t9IFHjKw9Ck1miNK6SCZKISII6tnhG/t9KvrL75Z8gS5jUfJ9uYYoAHi8Hy5Qk6Iy9mc
         EgP/99tIaeOE3u3ToKqB7ajes1KBi36ant2/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=asK5K98xiHL0silWLI4y1GpLJXdwpZcL+Www6PaqoKNveKfRIyeC5Qe/zXmpi4rmo+
         tfIQiuzp9eVkA3LTRw4aYZvA8ETpOakj2PyUbn2rVop9c8Z9pCPAhgGYBnX9fMGCyqvh
         nO2wZ+T6+PKiE3gsP7BhxTQF85eXAu6N3mXQ4=
Received: by 10.223.102.79 with SMTP id f15mr511318fao.134.1288933029083; Thu,
 04 Nov 2010 21:57:09 -0700 (PDT)
Received: by 10.223.120.20 with HTTP; Thu, 4 Nov 2010 21:57:08 -0700 (PDT)
In-Reply-To: <20101031014654.GC29456@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160799>

Hi,

On Sat, Oct 30, 2010 at 7:46 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Breaks in a test assertion's && chain can potentially hide
> failures from earlier commands in the chain.
>
> Commands intended to fail should be marked with !, test_must_fail, or
> test_might_fail. =C2=A0The examples in this patch do not require that=
=2E
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi,
>
> Just found some time to work through reports from the && checker.
> The examples below only add && to the end of lines in various tests.
> Passes all tests there (though of course that does not mean much).
>
> Thoughts?

I haven't had a chance to look at this in detail, but this is really
cool.  Thanks for working on it.  (And sorry for disappearing for over
a month with some unfinished series; I'll try to update them this
weekend.)


Elijah
