From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Sat, 9 Feb 2013 12:59:12 +0530
Message-ID: <CALkWK0nP8m+VY=FzWtxts8hXCBnnQAiD8VB3Krjz70xAt-HLFw@mail.gmail.com>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com> <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
 <20130207233017.GD19397@google.com> <CALkWK0kR-KWJbG_kWSf7+JMJEQc7vO0Emx=_yogCB0jMBfccAg@mail.gmail.com>
 <7vhalm1unu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 08:29:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U44sm-0006jb-DQ
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 08:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040Ab3BIH3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 02:29:33 -0500
Received: from mail-ia0-f171.google.com ([209.85.210.171]:48814 "EHLO
	mail-ia0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab3BIH3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 02:29:33 -0500
Received: by mail-ia0-f171.google.com with SMTP id z13so5039574iaz.2
        for <git@vger.kernel.org>; Fri, 08 Feb 2013 23:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=K4tyQva5sAuRMe/VSL1jblScNIw8i/x0/wzGCzgvVTQ=;
        b=Sf2FSe4Rb2JeNyHr3J4Q3sfinWjje2LuE9lm/cm673wPOGNwF6CbtFHG+ebIa1tRGN
         46Xf0fBP0BXv8QKGdA5prxFeECcHey/1SbomstJzRg3+eTYwZkk/ttpHQBGycdJnbErW
         bFEZkl4K7WRJL19SsR4eZF3wZeHCy3IvfemSYVuOpn/zRIoBANkFmyXOyNk3DcIElOOt
         WHygegEzBvbCR8YZxlcNolaEBizctc+/HrzKT78Jo/TB5EBL++93IR6K0OCAHZPC0Yyd
         pU7KGg+UCqvFPbPsV7BZK1rBKRj8x/jou+XeD98xLrb0NVPxwxvrJKNEVzrE6/PXYn2+
         3Trg==
X-Received: by 10.50.17.201 with SMTP id q9mr6984289igd.107.1360394972506;
 Fri, 08 Feb 2013 23:29:32 -0800 (PST)
Received: by 10.64.86.18 with HTTP; Fri, 8 Feb 2013 23:29:12 -0800 (PST)
In-Reply-To: <7vhalm1unu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215853>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Jonathan Nieder wrote:
>>> Ramkumar Ramachandra wrote:
>>>
>>>> And yes, a regular `git push origin refs/for/master` is just retarded.
>>>
>>> The usual incantation is "git push gerrit HEAD:refs/for/master".  Is
>>> the code review creation push that uses a different branchname from
>>> the branch the integrator pulls what seems backward, or is it the need
>>> to specify a refname at all on the command line?
>>
>> How else would you design a system to differentiate between a
>> push-for-review, and push-to-update-ref?
>
> You don't have to.
>
> If the reviewed result is merged on the server side and appear on
> 'master', nobody has to push to update refs/heads/master.

I'm sorry, I meant differentiating between push-for-review and
push-for-personal-work.
