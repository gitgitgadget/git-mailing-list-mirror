From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/5] nd/multiple-work-trees follow-ups
Date: Thu, 31 Jul 2014 17:13:01 +0700
Message-ID: <CACsJy8AambnVfbchGrvV0rgN1JyzCXBGgJxbV8JD1BF1DeDdHA@mail.gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com> <xmqqr412zqdo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 12:13:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCnMe-0005pW-Sw
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 12:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261AbaGaKNd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2014 06:13:33 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38149 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756210AbaGaKNc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2014 06:13:32 -0400
Received: by mail-ie0-f180.google.com with SMTP id at20so3400389iec.39
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 03:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kBb8QmIs+JlAZlyIAVSKQKodnFlCRNzxjIUNTF6vOyE=;
        b=cz+0Vdd58q4mJnsRzwJ/lrbQbu515xEpAMb/OiWeBHWGN1qTaV4fyC6CvLwpshMa+O
         oNrDPrBSjlKzeNnVqqQWE8ne8uN1CXex++62vRsyTt62PzNQmshWTJtAA/n39ZVABjuy
         q/fa+bVddF8K/I2dcOHB+K1wRZ3lR1HNLSiInIb9IHkOJTFGAk8vxalWbJfiy3X1h7lz
         f+yDp5fajhipD4AEV6VvLw3NF1FmvaD0Kpg08nFopwh2fFlnEZ6ebU01MZTfeQiKwHgs
         DSPpl8d6CZCPocH1mMzvTf5jmP2+cMKd22SOp/p4koJX51xs63BuC+0ihSrh8R10eiwV
         7S2A==
X-Received: by 10.43.129.74 with SMTP id hh10mr13669645icc.48.1406801611397;
 Thu, 31 Jul 2014 03:13:31 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Thu, 31 Jul 2014 03:13:01 -0700 (PDT)
In-Reply-To: <xmqqr412zqdo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254550>

On Thu, Jul 31, 2014 at 12:51 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> The series has entered 'next' so I can't replace patches any more.
>> Besides the brown paper bag fixes, checkout now rejects if a branch =
is
>> already checked out elsewhere.
>
> I do not think we would want to rush the entire series to 'master'
> before the upcoming release, so we could squash these fixes into the
> original when we rewind 'next' post release, if you wanted to.

Great. Please remove it from next at the next rewind.

> The fix-ups are easier to review than wholesale replacements; keep
> them coming as needed.

Will do.
--=20
Duy
