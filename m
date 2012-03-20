From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH 1/2] Unification of user message strings
Date: Tue, 20 Mar 2012 08:47:46 +0100
Message-ID: <4F683622.6010409@lyx.org>
References: <1332179503-2992-1-git-send-email-vfr@lyx.org> <1332179503-2992-2-git-send-email-vfr@lyx.org> <20120319205300.GA3039@sigill.intra.peff.net> <7vaa3c9ste.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 08:47:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9tnN-0002nC-KH
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 08:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758298Ab2CTHrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Mar 2012 03:47:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36979 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756886Ab2CTHrs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 03:47:48 -0400
Received: by eaaq12 with SMTP id q12so2886545eaa.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 00:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=lgRThvBSsy5mUqGwxx+digoXUQHlXag5Ju6vQm7Y/YM=;
        b=aoJjhZFpQOQc/kl9dFd5+7939fVIBk4zg8yuLDbf4k0s1YSSQ973Qr2gVUl6umtYIW
         VanIHwApN5VesEfSBG1/1KiNx30pe+9g6JpatTc3evJlrRrPayjpki2VPJNq0p22KQex
         agd7x+POaKwp0vZ94Z5kvCmAZ3si6Tkv9A8FossE03C2RvXUPJHnPXmwTpPGp2RAlWrd
         oXbrMCbIlt7C+alSgLJT6r1o8IQbcl49WPkmcWQDQOyeNhmsXhTWG9gbNrSvV+GYKAto
         YolUPNO086ma44ZET48xRcR7rdpB6Xk7BvdhJV/7SKo2SA4lMVtGneIF1zaS2SMJcnFn
         YDqQ==
Received: by 10.213.34.197 with SMTP id m5mr927781ebd.265.1332229667321;
        Tue, 20 Mar 2012 00:47:47 -0700 (PDT)
Received: from [145.94.170.103] (wlan-145-94-170-103.wlan.tudelft.nl. [145.94.170.103])
        by mx.google.com with ESMTPS id q45sm2424405eem.7.2012.03.20.00.47.46
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 00:47:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vaa3c9ste.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmEMptX2RVzxMXsEGtSU41agIdC5xbXCa51MaNzywZw+FTTNuFvsDRjW/e43XPkA2/x25c1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193489>

> I had a vague impression that plumbing messages tend to be lowercase.=
  If
> it is not be too much trouble, it might be interesting to redo the nu=
mbers
> divided into the plumbing and Porcelain messages. Perhaps these "50%"
> folks updated both plumbing and Porcelain. Another possibility is tha=
t
> they tried to follow the local convention when they added a new one, =
or
> reworded an existing one.
>
> If we would be rewording, we would only be doing the Porcelain messag=
es,
> so I am OK with either way.

It seems that the terms "Porcelain" and "plumbing" seems to be mixed up=
=20
somewhere.

 From 'git help status': "The porcelain format is similar to the short=20
format, but is guaranteed not to change in a backwards-incompatible way=
=20
between git versions or based on user configuration. This makes it idea=
l=20
for parsing by scripts".

 From 'http://progit.org/book/ch9-1.html': "....it has a bunch of verbs=
=20
that do low-level work and were designed to be chained together UNIX=20
style or called from scripts. These commands are generally referred to=20
as =93plumbing=94 commands, and the more user-friendly commands are cal=
led=20
=93porcelain=94 commands."

It feels like 'porcelain' means: "be careful, things break easily"; and=
=20
'plumbing' means: "use all the force you want to get it into (a=20
user-friendly) shape".

Second, to me it is not totally clear which strings are plumbing and=20
which ones are porcelain. Is there a general rule to tell ? The=20
command-list file says what the general intention of a command is, but=20
often it's both plumbing as porcelain.

Can anyone help me out here ?

Vincent
