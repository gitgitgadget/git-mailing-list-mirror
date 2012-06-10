From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2012, #01; Sun, 3)
Date: Sun, 10 Jun 2012 17:09:22 +0200
Message-ID: <CAMP44s2US+PoxfboZSML84GEvUwiHV4eQBOQSp6zhruT8xrKdg@mail.gmail.com>
References: <7vr4twudqm.fsf@alter.siamese.dyndns.org>
	<CAMP44s0cQe3jdfzbJmFVoFS50Ho5hVPg9dpZx0KhG3sP_J8=_g@mail.gmail.com>
	<7vbokwmifp.fsf@alter.siamese.dyndns.org>
	<CAMP44s2VGLj8kRih-95A0VDq86WKWHF3EhLvz0etyHHtP27qLA@mail.gmail.com>
	<7vmx4baaqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 17:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdjlg-0006yZ-SN
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 17:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab2FJPJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 11:09:24 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36559 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751392Ab2FJPJX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 11:09:23 -0400
Received: by lahd3 with SMTP id d3so2218460lah.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Db14gfjXkxrVe+MoV0TnrCLCueUR9s9XqhOWN8AzpnU=;
        b=SQJ9rCPzxnA80VxqJyAtjsudjxD1H6XTsxUJak9rG6koeqmw4SbDK/+xFvsxDrUJhk
         /39/7EcYomxNGoPFk2OJ2kb+QB1liOJUdq+CUidmlRY0As/E18gLd9IYKyBp8C7CilBm
         X7vChMzrA5TXpGW7GiVBLKoqJe3dYpEXTkj59TqDFOYn8RYkLqyHBYsfoPLd1GwSusXL
         L1290o2KYXa0rE88pgNatkaXwMmz2cu47a5Ko3OIncDzohD8SPlWVVBe7uBIhA/MHpny
         uOcehG3ADLkCroKU5pbIiPxnrEVpSlVe1W6R5HtmA4rh8G2/jXeByfAnY/g3a/cemidE
         U/HA==
Received: by 10.152.123.244 with SMTP id md20mr14677202lab.0.1339340962070;
 Sun, 10 Jun 2012 08:09:22 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Sun, 10 Jun 2012 08:09:22 -0700 (PDT)
In-Reply-To: <7vmx4baaqc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199606>

On Sun, Jun 10, 2012 at 9:26 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> I did not see anything like these.
>>
>> Nor is it needed *right now*. You could release v1.7.11 without any =
of
>> these, and then v1.7.11.1 or even v1.7.12 with a solution; I bet
>> __gitdir() would not have changed by that point.
>
> And by that time on whom are you placing the burden of making sure
> they do not diverge? =C2=A0Don't you still realize that you are being
> irresponsible?

There would be no divergence, that is my bet. There has been only
*two* changes since the creation of __gitdir(), and one is in the
queue.

And even if it does change, there would be *no problem*. Since you
have avoided the question, here it goes again:

>> It is not even funny to see these two conflicting claims made in a
>> single sentence.  Given that you are aware that it will cause a huge
>> problem to the end users if they diverge,
>
> What would be that *huge* problem?
>
> Suppose __gitdir() in git-prompt.sh is never updated again; it won't
> be any worst than it is currently, would it?
>
> Sow what would be this _theoretical_ problem?

You say I'm being irresponsible, I say you are being preoccupied by a
theoretical problem that will not occur, and would not cause any
problems if it does.

> In any case, I am tired of your arguing without being constructive,
> so let's try again. =C2=A0This is the third option I suggested to you=
=2E

I could say the same about you :)

> Subject: completion: warn people about duplicated function

If you want to solve fictional problems, sure go ahead, now the 0
persons that plan to change __git_dir() before v1.7.11.1  would be
warned. As long as the real problem is fixed I'm fine with it.

Cheers.

--=20
=46elipe Contreras
