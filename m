From: suvayu ali <fatkasuvayu+linux@gmail.com>
Subject: Re: Trouble with file specific merge strategies
Date: Sun, 11 Mar 2012 11:10:19 +0100
Message-ID: <CAMXnza12HVFdmji7k-b-G43NWmobqCQEwXZXB=VxJA=tatqX-g@mail.gmail.com>
References: <CAMXnza3SLHWLsFkYLhkJLAwtP2n=QVTXZ__GSL-CvajxC6i0Dw@mail.gmail.com>
 <7vk42rzfab.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 11:10:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6fjh-0006Td-4X
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 11:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab2CKKKk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 06:10:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64233 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2CKKKj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2012 06:10:39 -0400
Received: by iagz16 with SMTP id z16so5108866iag.19
        for <git@vger.kernel.org>; Sun, 11 Mar 2012 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2Jjq5e/Fz7XVHjOPxjBYrl9oVHihyPytiX3aTDyNNK8=;
        b=G5JadsJCLxJ0evukl/YCyzDwVDpNWul8I1pycb/n8fv9/+CpI0J7/adt9+5JRt6m+S
         sEeVFhCv1ByPuAF4vPOBNp9wTvmIolaNslJMVHNGLLqyGHEJTmbgAD8On8eQxM79wqwg
         aYpkvJps+4yRl7V64t3zXGcJjvKIWtschH+FTGk6jsCpW5XPvmqPfkV55VvLMHJuJq3t
         SkoWbBTbfm+mi9WkpkNKVyX5r5cBw0F1fV1/pI1Sw1paSXX9dqQyqW9JrhtqSjzBw+BV
         Pj4dlBrKFhHzFWWFXJzLG2JNLAZugRH5Dh98+kXNPxRLPz9IifdT24MY/ZLwvcPkc9kE
         M9kA==
Received: by 10.182.38.3 with SMTP id c3mr3883037obk.42.1331460639148; Sun, 11
 Mar 2012 03:10:39 -0700 (PDT)
Received: by 10.60.20.104 with HTTP; Sun, 11 Mar 2012 03:10:19 -0700 (PDT)
In-Reply-To: <7vk42rzfab.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: -daIxT_kH94KN3kymGRzp86sUCs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192800>

Hi Junio,

On Sun, Mar 11, 2012 at 09:57, Junio C Hamano <gitster@pobox.com> wrote=
:
> suvayu ali <fatkasuvayu+linux@gmail.com> writes:
>
>> ... So when I came across
>> the possibility of using .gitattributes for file specific merge
>> strategies, I tried the following:
>>
>> pattern merge=3Dours
>
> I do not think we say .gitattributes can give merge strategy
> anywhere in our document.
>
> You can choose one of the few built-in merge drivers but "ours" is
> not one of them. =C2=A0Have you defined your own merge driver "ours"
> following the example in the gitattributes documentation (look for
> "feel-free merge driver")?

Ah, that explains it. You are absolutely correct in saying that the
docs don't imply this. I was having doubts about this while reading the
docs (man gitattributes). I got confused by this[1] example on progit
and several pointers to it on stackoverflow. And no, I don't have a
custom merge driver.

This brings up the question, is that discussion on progit talking about
something else? Is there a way to setup file specific merge strategies
in a repo?

Thanks a lot for your response. :)

Cheers,

=46ootnotes:

[1] http://progit.org/book/ch7-2.html#merge_strategies

--=20
Suvayu

Open source is the future. It sets us free.
