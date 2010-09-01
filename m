From: Joshua Juran <jjuran@gmail.com>
Subject: Re: html page display via cgit
Date: Wed, 1 Sep 2010 03:00:20 -0700
Message-ID: <9D2F75AD-B25E-4730-82FA-E8C5F73FCE1B@gmail.com>
References: <AANLkTinJx0ZKjCtpq9k6nwigodnu42EvqchpgQtwGp5S@mail.gmail.com> <AANLkTik-02dJZF_0m=xccg4N5Mdaj=b2JzZaMKp=vuww@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shivdas Gujare <shivdas.tech@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 12:00:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqk7K-0003HQ-Vn
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 12:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab0IAKAY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 06:00:24 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35417 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab0IAKAX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 06:00:23 -0400
Received: by pwi3 with SMTP id 3so699646pwi.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=7NVGAxhi+cTaNqP00YBevSesEdVogwn6w0UIEnmnMoU=;
        b=sMHMLkK7tg4dIXv+nmIbP8XZhZCevBntN+AxGgA4Ht3gLu9urIPUtofBHJCBilQyjQ
         IIsJeOJvBrT830TJqNjmkpiD5jwNe3I66toQI7kqNvRuETrKW+ICxns3MSp33brZ7kDo
         y9cRnA97QDRH0sadboZQVpBJYFL5+2EJgutVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=cr00gKnvhdX8kfvOCTcIXetHg4iWWhZi/f/SSW4jfXzJtlPOHnYLQBKyu6DcYVJUKo
         IEQ/oNVlfqIubLtUhTTqnlz2cz1LrJl20bt7ZAiJgdZcYcZqt28LGwMOB5vyVf4fSY74
         QsZ47CKDGo+HxuI4OoV7WF1nRYQEBKJq0xHi4=
Received: by 10.142.230.10 with SMTP id c10mr7007355wfh.289.1283335223500;
        Wed, 01 Sep 2010 03:00:23 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id 33sm18238788wad.6.2010.09.01.03.00.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 03:00:22 -0700 (PDT)
In-Reply-To: <AANLkTik-02dJZF_0m=xccg4N5Mdaj=b2JzZaMKp=vuww@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155031>

On Sep 1, 2010, at 2:46 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> On Wed, Sep 1, 2010 at 09:32, Shivdas Gujare =20
> <shivdas.tech@gmail.com> wrote:
>
>> I hope, this is the right mailing list for cgit as well.
>> I am trying to add some "html logs" inside cgit, but I can't open
>> these logs via cgit inside firefox, i.e. cgit open every files in
>> "plain" format,
>> would like to know if it is possible to open "html" pages inside cgi=
t
>> so that if I click on html page added into git, it opens in html and
>> not in plain format.
>>
>> for example:
>> if I click on "download.html" from
>> "http://cgit.freedesktop.org/~lb/mesa/tree/docs" it shows a raw file
>> as "http://cgit.freedesktop.org/~lb/mesa/tree/docs/download.html"
>> and if I click on "plain" it opens in firefox like
>> "http://cgit.freedesktop.org/~lb/mesa/plain/docs/download.html"
>> but here I am trying to open this "download.html" inside cgit so tha=
t
>> I can view it like html web page and not as "plain" text file.
>>
>> Thanks for any help or pointers.
>
> I don't know, but that's probably deliberate. You're viewing a /plain=
/
> link, which should be the equivalent of "git show".
>
> There's also XSS security implications to serving things as text/html
> on a shared hosting site if the main site serves cookies or otherwise
> has user logins.

One solution is parse the content server-side and re-render as =20
sanitized HTML.  In addition to stripping out scripts and frames, this =
=20
would avoid sending broken markup produced by someone else under your =20
name, or serving up otherwise well-formed XHTML as text/html.

Josh
