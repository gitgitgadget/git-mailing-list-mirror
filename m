From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 2/2] Add Travis CI support
Date: Tue, 24 Nov 2015 22:03:04 +0100
Message-ID: <FC9B19DD-97CA-4ECE-BA99-631F5C14F504@gmail.com>
References: <1448267108-55652-1-git-send-email-larsxschneider@gmail.com> <1448267108-55652-3-git-send-email-larsxschneider@gmail.com> <20151124204004.GC7174@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 24 22:03:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Kk5-0007aY-AL
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 22:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299AbbKXVDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 16:03:11 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33355 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbbKXVDI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 16:03:08 -0500
Received: by wmec201 with SMTP id c201so228250554wme.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 13:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/ah01yQ+AvT/l+we2pddVscnF93qM2OsSxYV8HPJOlU=;
        b=f59Lr8dERT0fY6fTfz3bUqBdiufqSV0YqYd1R0Ei4Hd7DBjirzCqlgP6Cf+1+iTYPV
         CXiZWwLa5OT2iAvG75w08REAHHt8b99ew92EzadY/wibHJ/YErQE1TgbyPGvT39oOzR2
         XUfXNstVDMKto/6DWLZqoD2SkbfsOvgLisBJxHTI1iPI7SFl8Arzs3bHLyIMJjDohz/0
         sD7G3m/0C9GxCIc5ySEsSx6VTm8/L6XvrT6P8XZ7BFw3pQQueOR7sS0uw2HKIXWcmHha
         TyotBDnfT2+rNAyfU3+rrikef/xhJMqZILsTe4RCT0oPeDAIlIRh/Rg4pJng/+EVdctt
         EIhQ==
X-Received: by 10.28.97.197 with SMTP id v188mr471609wmb.63.1448398986688;
        Tue, 24 Nov 2015 13:03:06 -0800 (PST)
Received: from slxbook4.fritz.box (a89-182-126-48.net-htp.de. [89.182.126.48])
        by smtp.gmail.com with ESMTPSA id ft4sm19879848wjb.37.2015.11.24.13.03.05
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 13:03:06 -0800 (PST)
In-Reply-To: <20151124204004.GC7174@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281630>


> On 24 Nov 2015, at 21:40, Jeff King <peff@peff.net> wrote:
> 
> On Mon, Nov 23, 2015 at 09:25:08AM +0100, larsxschneider@gmail.com wrote:
> 
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> The tests are currently executed on "Ubuntu 12.04 LTS Server Edition
>> 64 bit" and on "OS X Mavericks" using gcc and clang.
>> 
>> Perforce and Git-LFS are installed and therefore available for the
>> respective tests.
> 
> Thanks, I find this one a little easier to digest.
> 
> I'm iffy on the NO_GETTEXT change from patch 1. I had hoped we could
> just build out of the box everywhere, but I think the "do we have
> libintl" decision is a hard one. Most people _do_ have it and want it,
> but it sounds like the Travis environment does not. So maybe it is a
> place where it is worth doing the tweak inside travis.yml and leaving
> the stock build alone.

OK, I'll try to fix it in the next roll.

Thanks,
Lars
