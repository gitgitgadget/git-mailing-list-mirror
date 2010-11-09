From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Tue, 9 Nov 2010 23:27:13 +0100
Message-ID: <AANLkTimBmRd5jTmjQ5GT3dd25pp3mHes+0Zmitt6DEj=@mail.gmail.com>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
	<AANLkTi=F6768YZdR4H-vcnHgknV=roHG249dzbNRJVXR@mail.gmail.com>
	<AANLkTinwdFvR4AV9nR=9sVuMYYZHMn4C7RQ0wneX6Ys+@mail.gmail.com>
	<AANLkTikbA0qYKZ8BtDgKA8KXKu3d_JtUGVF9d6HFUgJC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Nov 09 23:27:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFwev-00027k-EH
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 23:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312Ab0KIW1Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 17:27:16 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52838 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab0KIW1Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 17:27:16 -0500
Received: by fxm16 with SMTP id 16so5433264fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 14:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FPF9wlg8bOurdySMna09nJSaygU9mSSyqtSgFI3/lxU=;
        b=xwTBGkNj9/k/rBwzup5q6PEO7E62+whjcve3aqnu9is+E7752fzbabS8Ab5e0B8h4H
         BjpofNPqjBFN/lgzO24BhQLVEbq0KxCQrHM2+D3s1X8qNOoOnYHhw9NVS4kPh2OWSXqL
         rUhsWCIkDn7TAfB3hHLkBU/rTXE6R3fvdhdkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LkqDb3pHli8U7utsXTzYs/C+pNdV7I0vW6uNnioclW3rlUCw4Xy02vzUQygheTIXX4
         3yEG2zIuTu9oK9GcpPw4gQxIuPMvK8Nqe+D5J5X1EsxZqFVBpKSJXsHMY2HD3P5YLoCG
         rF/SAvgd9p05jf9q3wZGJ2pyOmU7V+z1zhnsI=
Received: by 10.223.83.138 with SMTP id f10mr5806819fal.114.1289341633878;
 Tue, 09 Nov 2010 14:27:13 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Tue, 9 Nov 2010 14:27:13 -0800 (PST)
In-Reply-To: <AANLkTikbA0qYKZ8BtDgKA8KXKu3d_JtUGVF9d6HFUgJC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161106>

On Tue, Nov 9, 2010 at 23:25, Erik Faye-Lund <kusmabite@gmail.com> wrot=
e:
> On Tue, Nov 9, 2010 at 11:21 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> On Tue, Nov 9, 2010 at 23:17, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>>> Hmmm, this is a bit more annoying IMO - this currently breaks in
>>> msysgit, due to lack of gettext and NO_GETTEXT not working properly=
=2E
>>> =C3=86var is aware of this
>>> (AANLkTiny+NmXew6UxjNMO+o75=3DCxxWm9iVRMRxs0LyTJ@mail.gmail.com), b=
ut
>>> haven't fixed it yet. I do have the patches needed to get a gettext=
 in
>>> msysgit, so it's not a very big deal to me. But are you sure that t=
his
>>> makes this series ready for 'next'?
>>
>> I hear ya. I'm hoping to get around to fixing all this stuff before =
it
>> lands in "next".
>>
>
> Good to hear :)
>
>> Also going to look at your gettext patches to see if there's anythin=
g
>> there that needs
>> to be made part of the series.
>>
>
> My "gettext-patches" are patches for msysgit (the development
> environment used to build Git for Windows) to build and install
> gettext. They're not patches against git.git, so I doubt they are
> useful to outside of msysgit.git.

Right, I hadn't looked at them. Thanks for that clarification.

And thanks for working on building gettext on msysgit. That will be
very useful later on.
