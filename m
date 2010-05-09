From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [Patch 001/GSoC] Move static files into subdir
Date: Sun, 9 May 2010 23:18:09 +0530
Message-ID: <n2ie72faaa81005091048hf229bd13qf29f9bfd5d58ac16@mail.gmail.com>
References: <p2ze72faaa81005090656j593c3464v9ee1bb6432461efc@mail.gmail.com>
	 <201005091910.05193.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun May 09 19:48:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBAbz-0000bj-5I
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 19:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab0EIRsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 13:48:12 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:49252 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab0EIRsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 13:48:10 -0400
Received: by yxe1 with SMTP id 1so2011325yxe.33
        for <git@vger.kernel.org>; Sun, 09 May 2010 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ad9uVFmcztYlVw0u/4Ujyqa6xIQQSSyX+idvGJauBZk=;
        b=FfSAob6+ryE7GwSDDRW+gZaN+L1u4krwu2H0fg1wmCarrWpzDCiWc32wOQT7dMRXYg
         HhSC3JhKulpRqGTRkN7CgVoa3BweBZkMCO7iJBZi7OUAGMiM4IaiqJBlIJLaW6L2k08E
         n8vnLfOCqIgQMP5m2AjB0KjrSdZ6O8DlCZTfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BO1/ECcl3ZW2W6svjy4ABrZVADVnFGADgjnD2kCrON8OwLsGyuNaEX4YV3uLjm3/6p
         Bb43Gn9m/tUlq5HPAd0HjF7jwRZ6VikVTh/iMRJhBHkSWsjfoO/PPo81HrHrO5Fj/pP5
         exMyJsi3Z7rU/BSgirKSpi1Q5kDw6LpJT3TMA=
Received: by 10.90.253.11 with SMTP id a11mr1629018agi.26.1273427290003; Sun, 
	09 May 2010 10:48:10 -0700 (PDT)
Received: by 10.90.63.14 with HTTP; Sun, 9 May 2010 10:48:09 -0700 (PDT)
In-Reply-To: <201005091910.05193.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146730>

I will try to follow them from next time onwards.

Thanks

- Pavan

On Sun, May 9, 2010 at 10:40 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> On Sunday 09 May 2010 15:56:30 Pavan Kumar Sunkara wrote:
> Hi,
>
>> Hi,
>>
>> It's been a while I mail to this list since I got GSoC. But I have
>> been in contact with Christian and Petr (mentors) everyday. As I am
>> having my vacation, I decided to statrt the project earlier itself.
>> Here's is my first patch in the process of my GSoC.
>>
>> One of my project goals is to split gitweb. This patch initiates the
>>  splitting.
>
> All of the above should go after the three dashes and before the diffstat
> bellow.
>
> Please try to look at the submitting patch documentation and what other
> people's patches look like.
>
>> From e25db0b62b481e029354ad33af8f0615a8353633 Mon Sep 17 00:00:00 2001
>> From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
>> Date: Wed, 5 May 2010 21:44:57 -0700
>
> The above line should not appear.
>
>> Subject: [PATCH] Gitweb: Move all static files into a seperate directory
>
> This line should be the subject of your email.
> If you really want to say that it's a GSoC patch you can use [PATCH GSoC]
> instead of [PATCH] but please don't put "001/GSoC".
>
>> This commit creates a new subdirectory called 'static' in gitweb
>> which will contain all the static files required by gitweb.cgi
>> while executing. By doing so, the gitweb source will be more
>> readable and maintainable.
>>
>> Also changed INSTALL, README, Makefile and test files
>> according to this change.
>>
>> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
>> ---
>
> The comments that you put on top of the patch should go here.
>
>>  gitweb/INSTALL                      |   20 ++++++++++----------
>>  gitweb/Makefile                     |   20 ++++++++++----------
>>  gitweb/README                       |    8 ++++----
>>  gitweb/{ => static}/git-favicon.png |  Bin 115 -> 115 bytes
>>  gitweb/{ => static}/git-logo.png    |  Bin 207 -> 207 bytes
>>  gitweb/{ => static}/gitweb.css      |    0
>>  gitweb/{ => static}/gitweb.js       |    0
>>  t/gitweb-lib.sh                     |    6 +++---
>>  8 files changed, 27 insertions(+), 27 deletions(-)
>>  rename gitweb/{ => static}/git-favicon.png (100%)
>>  rename gitweb/{ => static}/git-logo.png (100%)
>>  rename gitweb/{ => static}/gitweb.css (100%)
>>  rename gitweb/{ => static}/gitweb.js (100%)
>
> [...]
>
> Regards,
> Christian.
>
