From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 22/31] checkout: support checking out into a new
 working directory
Date: Wed, 16 Jul 2014 23:37:10 -0700
Message-ID: <CAPc5daXiLqx6wkRFN7fs29Hu+zyZGL9kFed4jkwjJQB8hR0E-Q@mail.gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com> <1405227068-25506-23-git-send-email-pclouds@gmail.com>
 <20140717041928.GA10056@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Jul 17 08:37:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7fJw-0006RS-Nr
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 08:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905AbaGQGhd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2014 02:37:33 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:56844 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbaGQGhc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2014 02:37:32 -0400
Received: by mail-la0-f51.google.com with SMTP id el20so1359029lab.38
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 23:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=8kjRZ12rea59HAxzZpejGjF/uiaAWPt3p2Ex38hEfn4=;
        b=Qm0DZkHO54r4la1WCEZ1OK9mOu1UniEeI+Co0CsFJVyh6Ik4PHz96cTU1BRaBy2VRp
         +g26GAjdzz5rFBVziIpMWdLMjSpzToegLdWysidGty5oti9u6FD3AMG7UOoFZB43/To1
         qa2vzI6+17rE5sAp87xjhOoGq5Az6p40X4lk+9c2iLPaebgZ9OhyadmxeHC/rXYlIix0
         uTYp+4a0D6pJfdbzhL654HGxNsuUS4SfL1axo0YUrCIqwrq3GfiK6u8kxC1+VBsTjOnk
         v4TzWtc/baq+vyqWfDKRTwM2LZgyI/cUJJBEKoz0oaW8wK9/9uHT26yPnYEjvrlzM1xg
         OBkQ==
X-Received: by 10.152.87.207 with SMTP id ba15mr30147247lab.15.1405579050390;
 Wed, 16 Jul 2014 23:37:30 -0700 (PDT)
Received: by 10.112.26.212 with HTTP; Wed, 16 Jul 2014 23:37:10 -0700 (PDT)
In-Reply-To: <20140717041928.GA10056@wheezy.local>
X-Google-Sender-Auth: OsNxUoHjjUK7U0TZ2QbkKI9uTag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253722>

On Wed, Jul 16, 2014 at 9:19 PM, Max Kirillov <max@max630.net> wrote:
> Hi.
>
> On Sun, Jul 13, 2014 at 11:50:59AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>> +MULTIPLE CHECKOUT MODE
>> +-------------------------------
>
> This generates incorrect html for me, making all section
> until next heading "EXAMPLES" into a preformatted text. If I
> justify the line of dashes to be the exactly same width as
> header it starts generating correctly looking html.

Thanks; what you did is the correct AsciiDoc formatting.
