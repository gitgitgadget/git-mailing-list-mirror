From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 1 Oct 2012 13:08:21 +0530
Message-ID: <CALkWK0m9tkRXFZw-d_XADR9LXqxa0j_82bhhrd0FoEoHsO6yPg@mail.gmail.com>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
 <vpqy5k8raig.fsf@grenoble-inp.fr> <CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com>
 <vpqd31kr7v4.fsf@grenoble-inp.fr> <CALkWK0=ROz8fxXgnqt-+AthU-hgq_mzFg0GhBQCrAshH_mRBPQ@mail.gmail.com>
 <vpqvcfcps2z.fsf@grenoble-inp.fr> <7v4nmwwqox.fsf@alter.siamese.dyndns.org>
 <vpqipbcpp69.fsf@grenoble-inp.fr> <7vvcfctmka.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 09:38:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIaaa-0005z8-QZ
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 09:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751903Ab2JAHim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 03:38:42 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:59800 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab2JAHim (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 03:38:42 -0400
Received: by qchd3 with SMTP id d3so3442161qch.19
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 00:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rWSLNCLE4KDrETab1UmeYHu6wutOgCBUlZd5J3HJ7Rs=;
        b=nR98RQmmkpGgsILFviwMhBYXmJnj68V4P4xD/9dr4gdvir936RG2xnQuYMK3IMZveN
         SfjHWClKMmVXdX7jFGvQH6y0SjemBZIKrOCakUjkPdATcq12fOmsjaSIe0M1UFwLKv/r
         8+RQae/LkJD0xSnYp4a27lsebDD2wvN1n8iEgmmjgew/mP2cHIw3umMxUHcyaIUo9U/e
         qpzxWf2//TBf1lprKGkqfueVJIFiXHHzxO2Kho5Dco6mU3zrJjfqDL7b45beypCMyEK8
         daIj157/8u3EpgCjfaL5ClreGB1v39Cw4xmuBBfcmWhSbPxGjw+SwLFUlLExI+hDPr+y
         k8Sw==
Received: by 10.224.78.141 with SMTP id l13mr34835642qak.25.1349077121484;
 Mon, 01 Oct 2012 00:38:41 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 1 Oct 2012 00:38:21 -0700 (PDT)
In-Reply-To: <7vvcfctmka.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206724>

Hi Junio,

Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> I haven't been paying attention, but does that mean on that system,
>>> a total stranger kseygold can write, modify, and remove whatever Ram
>>> owns?  I am hoping that is not the case.
>>
>> I can see two reasons for having the same UID for two login names:
>>
>> 1) the sysadmin really messed up, and as you say, a total stranger has
>> complete ownership of your files. Ramkumar, you should check that this
>> is not your case.
>>
>> 2) the sysadmin explicitely gave two login names to the same physical
>> person, as kinds of aliases for the same UID (e.g. the person got
>> married, changed her name and login, but expects ~oldlogin to continue
>> working). I'm not sure how common this is, and to which extend we want
>> to support this in our test scripts.
>
> I've only been assuming (1), but (2) feels like a legitimate (if
> confusing) way to configure your system.
>
> It is a separate issue if it is worth bending backwards to support
> it in the test, though.

For what it's worth, `sudo` is "broken" on my system.

Ram
