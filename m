From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: [PATCH 01/19] spell checking
Date: Sat, 9 Mar 2013 20:07:20 +0000
Message-ID: <CALeLG_kdYjFhZXWedTgr2zdzJfrGV6XmqT1qkMX9XpJgztnPcg@mail.gmail.com>
References: <CALeLG_=R4o1y-kA+n883nnAu+jrjgaA2ys2d+Vo9KasmVKeduQ@mail.gmail.com>
	<7vobese4rp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, David Greene <greened@obbligato.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 21:07:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEQ3b-00032h-6q
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 21:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391Ab3CIUHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 15:07:22 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:38349 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab3CIUHV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 15:07:21 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so2276964obb.14
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 12:07:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=0+K1ce8ZodZkG/dgjP9snAW5oUabRijodIA0mexjyd4=;
        b=XS+5JgJM7pyfnTEwYDoCIAFvkqsH0yOILTy1V+xTBVX/nNOSxgREIBHSas5wa/F1PU
         HHHaydlo24YUp/mqo0l1RQrXqWCOcGoVsZCQX8iun6aqG5fstt9iRnbCQr6Ie3jJatBp
         gX+AIQSnsqMatjj0dUoS5WX6+X4uQamQ1//rp+CEipdjqpYR4GJUOeNcWIp5REz2SASm
         p1ntsaJORAlv5bAVmjNZZjSfWtNyOotIIk7Lf025XuQk610l7of8Slr/Yh7wx++rDDUq
         OnrM8D+fB+hAygA83wJFK9OAhX63SzW6rNfh2NoYObt3AdyQ5S5dly0OGp69XPcDkvgD
         k47g==
X-Received: by 10.182.12.6 with SMTP id u6mr5145594obb.3.1362859640828; Sat,
 09 Mar 2013 12:07:20 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 12:07:20 -0800 (PST)
X-Originating-IP: [2.102.85.67]
In-Reply-To: <7vobese4rp.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkGd8MPuRvCecAsoUwk6tO1zy26NVBBwvWmJS7yP62fryZfXsZ/kZV4KH0bBPOjsWCwBB+O
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217759>

On Sat, Mar 9, 2013 at 7:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Campbell <pcampbell@kemitix.net> writes:
>
>> From 72fc84b6e5085b328cc90e664c9f85a1f5cde36c Mon Sep 17 00:00:00 2001
>> From: Paul Cartwright <paul.cartwright@ziilabs.com>
>> Date: Thu, 27 Jan 2011 22:33:06 +0800
>> Subject: [PATCH 01/19] spell checking
>>
>> ---
>>  contrib/subtree/git-subtree.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> I won't repeat these for other 18 patches, but please:

Thanks and apologies. All noted, although I have a question below.

>  - drop the first "From <object name> <magic timestamp>" line which
>    is not part of the patch (it is only meant to help people who
>    maintain the "file(1)" and "magic(5)");
>
>  - keep "From: <author name> ..." and "Date: " lines for other
>    peoples' patches you are forwarding (they can be dropped for your
>    own patches); and
>
>  - drop "Subject: " as that is the same as the subject of the e-mail
>    message.
>
>  - fix the subject to make it clear that the change is for
>    contrib/subtree.
>
>    "spell checking" [*1*] in the output of "git shortlog v1.8.1..",
>    together with other 600+ patches' titles, will not help the
>    reader to see how much activity each area had and who worked in
>    what area.

I'd wanted to avoid changing the original author's work as much as
possible. Wrong choice on my part.

>  - have the authors sign-off their patches, and then add yours as
>    the person who is forwarding other peoples' patches (see
>    Documentation/SubmittingPatches).

Four of the eight original authors now have dead email addresses. As I
found out when I started getting the mail bounces when I started
sending these patches out. Would it be acceptable for those patches to
leave the From line, add a Based-on-patch-by and then sign of myself?
I've really only done enough on top of the cherry-picking to get round
any conflicts.

>  - Cc the area maintainer (I thought it was David Greene?)
>
> if these patches are meant to become part of git.git eventually.

I knew that and forgot. Can I blame this on my head-cold? No?

> Thanks.
>
>
> [Footnote]
>
> *1* Besides, a patch can never be "spell *checking*".  It would be
>  "typofix" after the author did a 'spell checking' ;-)

-- 
Paul [W] Campbell
