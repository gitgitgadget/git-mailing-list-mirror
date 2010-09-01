From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: html page display via cgit
Date: Wed, 1 Sep 2010 14:45:18 +0200
Message-ID: <AANLkTi=yEqrkfiY84qVrvJcaBjcU-_+U7tH5ki3h9J3x@mail.gmail.com>
References: <AANLkTinJx0ZKjCtpq9k6nwigodnu42EvqchpgQtwGp5S@mail.gmail.com>
	<4C7E29A1.8020304@atlas-elektronik.com>
	<AANLkTimucGi-7QdxbP5iLs0h5=VWW55GCxug51V584UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Shivdas Gujare <shivdas.tech@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 14:45:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqmgx-0006Xt-DD
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 14:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab0IAMpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 08:45:20 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36044 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab0IAMpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 08:45:19 -0400
Received: by qwh6 with SMTP id 6so6280605qwh.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 05:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ztnQkvJ/IksM1t8o+FkpqKfB8osilkMf0YYhlq1nuAc=;
        b=mJoevhCGzOdBFXqSoLwl2VCkyTW7pDCgVhNInX5GDf08sn7jR/UyLv0gf4KGz8ySI6
         l09Dnto1sFqF3l+PVW7ZiwW/rkJ3rDK56YdfradRfvGP6xccpe2+rOSwoF/iioAGDFk+
         D/nGrC/VroB/SiAqHXy2VsxZq/977h0JH/yag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=LRbQn0DniGFrtM3DoNMWh7wMYniWD2kkZRU8SlupwXLenWpcC0GpgRciXn1YPrmqNL
         Bbj0l7RG8hqvwkz6frH9GuHoZ4Wex2zEeDtjQ6ucz3UqElilKHBtoj2ln8J7Z+u4kyzW
         53xdHNUGyu/QBUD4OOY1mYWbHiRmk6+qiYxU4=
Received: by 10.224.89.143 with SMTP id e15mr5027555qam.393.1283345118060;
 Wed, 01 Sep 2010 05:45:18 -0700 (PDT)
Received: by 10.229.65.167 with HTTP; Wed, 1 Sep 2010 05:45:18 -0700 (PDT)
In-Reply-To: <AANLkTimucGi-7QdxbP5iLs0h5=VWW55GCxug51V584UA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155042>

On Wed, Sep 1, 2010 at 14:19, Shivdas Gujare <shivdas.tech@gmail.com> wrote:
> On Wed, Sep 1, 2010 at 3:53 PM, Stefan Naewe
> <stefan.naewe@atlas-elektronik.com> wrote:
>> Set this in /etc/cgitrc
>>
>> mimetype.gif=image/gif
>> mimetype.html=text/html
>> mimetype.jpg=image/jpeg
>> mimetype.jpeg=image/jpeg
>> mimetype.pdf=application/pdf
>> mimetype.png=image/png
>> mimetype.svg=image/svg+xml
>>
>
> I did tried this, but it didn't made any difference on showing html
> pages.

What cgit-version are you running? This option was added in cgit-0.8.3
(2009-09-13).

If your cgit has support for mimetype options, you probably have
caching enabled, i.e. you're watching the old output (including
Content-Type header).

> Does this work like adding a line "
> mimetype.pdf=application/pdf" to /etc/cgitrc allows me
> to open a pdf via cgit interface in browser?

Yes, the pdf will be displayed in your browser if your browser supports pdfs.

-- 
larsh
