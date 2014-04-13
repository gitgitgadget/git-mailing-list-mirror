From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Get all tips quickly
Date: Sun, 13 Apr 2014 20:29:25 +0200
Message-ID: <CACBZZX7C+TyDy0=DhnYp81hR8aNoa0Na2sBOYOxk6jF=hh_fVg@mail.gmail.com>
References: <4A7A3A96-DC10-4748-BBCC-F52F48977022@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Stanislav.Erokhin@jetbrains.com
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 20:30:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZPAm-0007sX-2m
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 20:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbaDMS3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2014 14:29:46 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:47867 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbaDMS3q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Apr 2014 14:29:46 -0400
Received: by mail-ob0-f169.google.com with SMTP id va2so8199628obc.14
        for <git@vger.kernel.org>; Sun, 13 Apr 2014 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HeOszXPi93vDSwWnW6Axedplwl/oMEHHybAxFFQsZOw=;
        b=n9ti17G9Oh/Bq76eQyhJ2gAGIA+gOFahjsVTL68NAvv1+KU7ze2/vGJxrBp9bRgmWL
         wPJZJD6HwznHO0KMd0alM0cd2yXb8PJEXq4rDsmeQHz+vM+qM0rSZKEpM6IhdhcGtqx9
         A2iPYRqPFGSPWHhuoBy9hoez+BTJnBS7UVBI7RNP2sjWD02tfEBA19dsyHqqBRO8QgQY
         ZUCdxZPElV/+74vcl7nLgpzQr3q1r1uxnpJaYm73l3IyyDD/BFd09m3JJd5Hc77J58ep
         T3Qt5fBAFp7rzdZC+7eRKQa3Bpq+LAbzKRMDNkv5mdB9vbj8yIo6oAdjPUniQ/qbRsxS
         r4Mg==
X-Received: by 10.60.44.135 with SMTP id e7mr86125oem.63.1397413785500; Sun,
 13 Apr 2014 11:29:45 -0700 (PDT)
Received: by 10.76.176.40 with HTTP; Sun, 13 Apr 2014 11:29:25 -0700 (PDT)
In-Reply-To: <4A7A3A96-DC10-4748-BBCC-F52F48977022@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246209>

On Sun, Apr 13, 2014 at 4:19 PM, Kirill Likhodedov
<kirill.likhodedov@jetbrains.com> wrote:
> Hi,
>
> What is fastest possible way to get all =E2=80=9Ctips=E2=80=9D (leafs=
 of the Git log graph) in a Git repository with hashes of commits they =
point to?

Tried "git for-each-ref" and the various options it has?

Doing this for 35k tags is still going to be non-trivial.
