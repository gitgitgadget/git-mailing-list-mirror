From: Mamta <mamta.upadhyay@gmail.com>
Subject: Re: [msysGit] Re:
Date: Thu, 9 Apr 2015 09:35:28 -0500
Message-ID: <88FC14EA-E627-40C7-BD22-A8DB687E55B6@gmail.com>
References: <CAM9_S8jip3q-vUWFHCWP6ia2wrKOxDpxz2zLSQZPQvAQ0xmKrw@mail.gmail.com> <5525A4A2.9080405@virtuell-zuhause.de> <20150409142716.bd75cc6b9e13dc580cdda722@domain007.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 16:35:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgDYO-0001Np-2L
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 16:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbbDIOfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 10:35:31 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34002 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286AbbDIOfa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2015 10:35:30 -0400
Received: by obbry2 with SMTP id ry2so16583347obb.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2015 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=98r/XeFA9CkwnoDkTo8bbfNnXpx3HX7rweKEqurtUz8=;
        b=o2BXjfpEKDCc9RsO/bpVikngEhf475KIrrVLWiA7/bj5myN/40+s4H5cc/BKNA+v1p
         JTkbIl10u6L04f9FoilNCEf3OrTK0RvMxlsBXEufIrMTpzI2tux3kxdGg3Wh4F/ruYwd
         vrE6qT+eQZJgu6zMvlV3KtbKXaqd5/UM+wCBXgHArwzQ0IW90fpMgV1F3i7pz+5m64h1
         4S4/iVyjyq4tzXQr28QPB7Y8JYb7/Xt6/dt4ZN1ph9EJxoH4yV82WJJvSMrlwh32tJou
         5+CnwNyGRiIIRLzFR8F/mxuzvTlKoOSA1HKVELmO9T0HxMC5mXmHdePEdN8ak0NqmE/j
         3vLA==
X-Received: by 10.60.78.72 with SMTP id z8mr39009691oew.13.1428590130020;
        Thu, 09 Apr 2015 07:35:30 -0700 (PDT)
Received: from ?IPv6:2601:b:2a80:d66d:8947:3df9:ba1f:fa4b? ([2601:b:2a80:d66d:8947:3df9:ba1f:fa4b])
        by mx.google.com with ESMTPSA id bt6sm11468277obd.0.2015.04.09.07.35.28
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 Apr 2015 07:35:29 -0700 (PDT)
X-Mailer: iPhone Mail (11A501)
In-Reply-To: <20150409142716.bd75cc6b9e13dc580cdda722@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266997>

I was not cross posting. Posted on this thread after you mentioned in your post that writing on msysgit user group is futile. Thought I wouldn't get further replies on my questions there. Plus I got a feeling that I will get more in depth information here. Sorry if I sent a wrong message

> On Apr 9, 2015, at 6:27 AM, Konstantin Khomoutov <flatworm@users.sourceforge.net> wrote:
> 
> On Wed, 08 Apr 2015 23:58:58 +0200
> Thomas Braun <thomas.braun@virtuell-zuhause.de> wrote:
> 
> [...]
>>> I am trying to run the latest git 1.9.5 installer on windows. When I
>>> run strings on libneon-25.dll it shows this:
>>> 
>>> ./libneon-25.dll:            OpenSSL 1.0.1h 5 Jun 2014
>>> 
>>> But when I load this dll in dependency walker, it picks up
>>> msys-openssl 1.0.1m and has no trace of openssl-1.0.1h. My questions
>>> to you:
>>> 
>>> 1. Is libneon-25.dll statically linked with openssl-1.0.1h?
>>> 2. If not, where is the reference to 1.0.1h coming from?
>> 
>> I would be suprised if we link openssl statically into libneon. I
>> guess libneon just reports against which openssl version it was
>> *built*.
>> 
>>> I am asked to rebuild git with libneon-25.dll linked against
>>> openssl-1.0.1m. But I am having a feeling that this is not needed,
>>> since libneon is already picking the latest openssl version. Can you
>>> please confirm?
>> 
>> You can download the development enviroment for git for windows here
>> [1]. After installation, checkout the msys branch and then you can try
>> to recomplile libneon using /src/subversion/release.sh.
>> 
>> [1]:
>> https://github.com/msysgit/msysgit/releases/download/Git-1.9.5-preview20150319/msysGit-netinstall-1.9.5-preview20150319.exe
> [...]
> 
> JFTR, the discussion about the same issue has been brought up on
> git-users as well [2].
> 
> (People should really somehow use the basics of netiquette and mention
> in their posts where they cross-post things.)
> 
> 2. https://groups.google.com/d/topic/git-users/WXyWE5_JfNc/discussion
