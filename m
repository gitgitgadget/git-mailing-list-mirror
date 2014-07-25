From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git feature-branch
Date: Fri, 25 Jul 2014 11:39:44 +0530
Message-ID: <53D1F4A8.4050509@gmail.com>
References: <CAJnDmGJ16NRV7kUuwE7Cr6Pc202yq8YuXdUB-5=aXRQWCDfK2g@mail.gmail.com> <53D1D90C.5040704@gmail.com> <CAJnDmGLaXPFYSVteehdz66C-kiDcBpAkQpW-uX8x-s9Qe_+kNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sheldon Els <sheldon@easyfundraising.org.uk>
X-From: git-owner@vger.kernel.org Fri Jul 25 08:09:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAYhV-0001W7-6t
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 08:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814AbaGYGJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 02:09:49 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:57556 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbaGYGJs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 02:09:48 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5091278pdj.12
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=eOKOCr7bp5/nbLHNTmksLkt8xjq0dBQOhSiZVRMUKhE=;
        b=HZ4BvJ2rTUs7VCkNixhy++Bh8224JPdH1yPaGVdQNVpjWrFlwWTncpDqFQBzyMepJt
         /uq64GVlMQ33wL/A/jedaB2/QIKW43I1KAMZt8kvCQsO3JJbUnt5MQ02mUMDKJO8LeX5
         vF2wLDhqktn6WKCKupyWKzqkYHGZ/LANzP/DhTo00HCu4L8MFv3WonYN5x63MNYBmjyc
         L3dNz8zXfjp/L2BK0PJr41yTzKaW+Fmrdh9xqFsHQq2DfyKm0hb17eGocEC5aHljUu7q
         Dv1/PdlEf/TSzqHPZFtpwOY7BqUnAxu7V/+GC6jqtwSZIDDOpFMFMa6LAIEu6FXbF+jh
         DbSw==
X-Received: by 10.70.16.68 with SMTP id e4mr15772pdd.161.1406268588387;
        Thu, 24 Jul 2014 23:09:48 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id vy8sm7592624pbc.84.2014.07.24.23.09.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 23:09:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAJnDmGLaXPFYSVteehdz66C-kiDcBpAkQpW-uX8x-s9Qe_+kNA@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254197>

On 07/25/2014 11:10 AM, Sheldon Els wrote:
> It is just a shell script yes, and a man page to make things a bit
> more discoverable for "git help feature-branch".
> 
> The brew command comes from homebrew, a popular OSX package manager.
> My platform of choice.

You might want to at least add "these instructions are for people using
macs".  Otherwise it seems like you assume everyone is using macs, and
nothing else exists in the world as far as you are concerned.

> Perhaps I can get support for an easy install for your platform. Do

When I said "more generic" I meant "it's just *one* shell script; put it
somewhere on your $PATH".  That should be sufficient for something like
this (at the risk of going a bit off-topic for the list).

> you think a Makefile that installs to /usr/local/bin and
> /usr/local/share/man would fit, or are you on windows?

Ouch.  That hurt.

> On 25 July 2014 05:11, Sitaram Chamarty <sitaramc@gmail.com> wrote:
>> On 07/25/2014 03:45 AM, Sheldon Els wrote:
>>> Hi
>>>
>>> A small tool I wrote that is useful for some workflows. I thought it'd
>>> be worth sharing. https://github.com/sheldon/git-feature-branch/
>>
>> As far as I can tell it's just a shell script; does it really need
>> installation instructions, and if so can they not be more generic than
>> "brew install"?  Speaking for myself I have NO clue what that is.
