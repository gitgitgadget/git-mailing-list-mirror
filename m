From: Joshua Juran <jjuran@gmail.com>
Subject: Re: html page display via cgit
Date: Wed, 1 Sep 2010 03:25:24 -0700
Message-ID: <EB82F537-FB11-40F2-B6DB-2A7043C819CF@gmail.com>
References: <AANLkTinJx0ZKjCtpq9k6nwigodnu42EvqchpgQtwGp5S@mail.gmail.com> <AANLkTik-02dJZF_0m=xccg4N5Mdaj=b2JzZaMKp=vuww@mail.gmail.com> <9D2F75AD-B25E-4730-82FA-E8C5F73FCE1B@gmail.com> <AANLkTinjVPAOJfmiHFOe3Pci_y-KwzGr5LzDryG8oN+A@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shivdas Gujare <shivdas.tech@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 12:25:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqkVZ-0001jU-Tk
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 12:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451Ab0IAKZ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 06:25:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38748 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab0IAKZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 06:25:27 -0400
Received: by pwi3 with SMTP id 3so705319pwi.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=4B/OEGpYM58VIycH0ia/q3wTwzZboljIfQ9JD/ND17A=;
        b=DmE8BJmbjEkMpxqMWUfHd3rPlPxfd+98b3XEZHuFWLQyEzfsqh1RjphSkdT84TdrXo
         HFn/E/wzmj6IFFLXICRkO3Z8n9ycZQAn5w3CVc/aQTyZrTNBFpgaGy13MSKXzChg02Hs
         nQrEdXyNn3O1p9SG6DOVnRC1U7fYGtGW6XJgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=GkT6vBYTHZ7L1u2Fl0PoFTF3BwEfBn1rTbrO2qes/KXH3uUbFLJmU9MIyDphN9AO5z
         lLd6tItFgrgJM3B/AGXoh/UDfuT6YayDhV4zJFWEY6NpBydcU0GnPUBEIGufGkHRGuCR
         zq5GqKG44H0omCW0FcyGti2NLHFQw6iuqA1wI=
Received: by 10.142.187.6 with SMTP id k6mr7192505wff.3.1283336727557;
        Wed, 01 Sep 2010 03:25:27 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id d4sm12305146wfh.23.2010.09.01.03.25.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 03:25:26 -0700 (PDT)
In-Reply-To: <AANLkTinjVPAOJfmiHFOe3Pci_y-KwzGr5LzDryG8oN+A@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155034>

On Sep 1, 2010, at 3:06 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> On Wed, Sep 1, 2010 at 10:00, Joshua Juran <jjuran@gmail.com> wrote:
>> On Sep 1, 2010, at 2:46 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>>
>>> On Wed, Sep 1, 2010 at 09:32, Shivdas Gujare =20
>>> <shivdas.tech@gmail.com>
>>> wrote:
>>>
>>>> I hope, this is the right mailing list for cgit as well.
>>>> I am trying to add some "html logs" inside cgit, but I can't open
>>>> these logs via cgit inside firefox, i.e. cgit open every files in
>>>> "plain" format,
>>>> would like to know if it is possible to open "html" pages inside =20
>>>> cgit
>>>> so that if I click on html page added into git, it opens in html =20
>>>> and
>>>> not in plain format.
>>>>
>>>> for example:
>>>> if I click on "download.html" from
>>>> "http://cgit.freedesktop.org/~lb/mesa/tree/docs" it shows a raw =20
>>>> file
>>>> as "http://cgit.freedesktop.org/~lb/mesa/tree/docs/download.html"
>>>> and if I click on "plain" it opens in firefox like
>>>> "http://cgit.freedesktop.org/~lb/mesa/plain/docs/download.html"
>>>> but here I am trying to open this "download.html" inside cgit so =20
>>>> that
>>>> I can view it like html web page and not as "plain" text file.
>>>>
>>>> Thanks for any help or pointers.
>>>
>>> I don't know, but that's probably deliberate. You're viewing a /=20
>>> plain/
>>> link, which should be the equivalent of "git show".
>>>
>>> There's also XSS security implications to serving things as text/=20
>>> html
>>> on a shared hosting site if the main site serves cookies or =20
>>> otherwise
>>> has user logins.
>>
>> One solution is parse the content server-side and re-render as =20
>> sanitized
>> HTML.  In addition to stripping out scripts and frames, this would =20
>> avoid
>> sending broken markup produced by someone else under your name, or =20
>> serving
>> up otherwise well-formed XHTML as text/html.
>
> Yes, but have you seen programs that try to secure arbitrary
> user-supplied HTML like this? It isn't pretty, and very hard to get
> right.

I haven't looked at any.  I'm not suggesting tweaking the HTML, but =20
replacing it outright.  Use a whitelist of elements and attributes; =20
everything else gets dropped, including comments.  I'm not a security =20
expert, but my assessment is that this does the job.

Josh
