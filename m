From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Configurable callbacks for missing objects (we Re: upload-pack: 
	support subtree packing)
Date: Wed, 28 Jul 2010 08:32:30 +1000
Message-ID: <AANLkTimPVzBN_KaxMpY9NoP+M_WdErh7fT0oyPWGky7m@mail.gmail.com>
References: <1280187370-23675-1-git-send-email-pclouds@gmail.com>
	<1280187370-23675-2-git-send-email-pclouds@gmail.com>
	<20100727144605.GA25268@spearce.org>
	<20100727185127.GD25124@worldvisions.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 00:32:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdshQ-00042q-63
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 00:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab0G0Wcb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 18:32:31 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:53877 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab0G0Wca convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 18:32:30 -0400
Received: by pxi14 with SMTP id 14so654420pxi.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 15:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iVk6Drx9Yl+AkbVO1Nt9WdQKC9oJYOjN5XAfkgTQPd8=;
        b=obs5uFUCWoxR+xV84FgPZ6XRj2EA9MGEz0Fovay4FHchs+U6uqBiQ1f0OdecACFEDy
         c81jz1QtUU8K/cjySmKQ8799VrriVzcFuUzUGOhz2Wzw8H3OfREu6qW1dNDuvCUrNoWP
         6qWJSnhhF3SjadQhZ5wuQmm4xwv7mQocrdxac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=V4fpEF1A6LC9ylfK3/B5vDSM+WedyjgJMHZgyt1HnpLNnTI38Eh51wqCjo5V+mKi85
         2Uuiyvvqh5gGC03Af7f1GWyOEyFc3D5tWggPYQBJnWAl1ay9UlKr7tJUat8wiR1itN5p
         +Xde/VslWMpP+bFwdIug45RlI0rDdOFgvV2JM=
Received: by 10.142.213.14 with SMTP id l14mr11003306wfg.90.1280269950057; 
	Tue, 27 Jul 2010 15:32:30 -0700 (PDT)
Received: by 10.142.98.1 with HTTP; Tue, 27 Jul 2010 15:32:30 -0700 (PDT)
In-Reply-To: <20100727185127.GD25124@worldvisions.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152011>

2010/7/28 Avery Pennarun <apenwarr@gmail.com>:
> But I've been thinking that a really elegant way to solve the problem=
 could
> be to have a user-configurable "get the missing objects" callback. =C2=
=A0If any
> part of git that *needs* an object can't find it, it calls this callb=
ack to
> go try to retrieve it (either just that one object, or it can request=
 to
> download the object recursively, ie. everything it points to).
>
> Then shallow clones could just auto-fill themselves if you really nee=
d a
> prior version, for example.

I think that's what lazy clone does in [1]

[1] http://thread.gmane.org/gmane.comp.version-control.git/73117/focus=3D=
73935
--=20
Duy
