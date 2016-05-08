From: Christian Couder <christian.couder@gmail.com>
Subject: Draft of Git Rev News edition 15
Date: Sun, 8 May 2016 14:50:34 +0200
Message-ID: <CAP8UFD1uyJQJSi+wi-W6EH7=7AAZoKKx01=P+oQ3zbpzsJ4Xqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>, Jeff King <peff@peff.net>,
	"Sytse 'Sid' Sijbrandij" <sytse@gitlab.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Spencer Krum <nibz@spencerkrum.com>,
	Roberto Tyley <robertotyley@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 14:50:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azOAT-0004ic-Kl
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 14:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbcEHMuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 08:50:37 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38540 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcEHMug (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 08:50:36 -0400
Received: by mail-wm0-f46.google.com with SMTP id g17so144673955wme.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=e3TUpFD4u9wWg6369ZyYcJbhEquWN9u6kTKKQaQxtxQ=;
        b=aX+f/45YoD+qRnd+2Z/7b7KyvqTR4PIcZYIC4OXCJCGD3NNCVwGBON9J5kHj9SVbHv
         UJRL89F4HJb7NDImuvw40VRftFNKl/30UoOpYwDKVZPBusJT99q6ywLzYBPWE0Yq9dvj
         h0mmF4+IM9/IReIitouRfQ1UK5sSXGA/kWythy9iJitHdwJ3BHHbIkio8+2iDrC2e/Cp
         NfI59vcV4STy63XgzOewDnO4gJKV7J5Ap0mxG6W0KhiV738QkWWVroZz5grOhOQglA0G
         8PkMUp7VdnYD/mar8D5F5CDYGSFcjoPURFAd5krxMeAnmMzAv+UcV5TI/ItM5y/vvDIK
         JO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=e3TUpFD4u9wWg6369ZyYcJbhEquWN9u6kTKKQaQxtxQ=;
        b=Hk4JchyCw/EeHB3FxAYmsvp/fIgxyoHkTX3AAfrluFOqY9IOdMp+AwHytxaycwwfQ8
         FQb0mp2WuzhIF8wd7ZMiL78dJKqu3IoDyNIT8elSh91cAtdZhdkzQ3tHscgb+aH4k7yH
         gwPFgHfaMPirmRq9wYz1m5oHQ3e9d85076ezrcYztsHoYBN29ya2itHvrNBfCWtBJixM
         GmoddmfbxUKotyBbxP+IYmf34ESwHbDFzQmV5JRDpt9Muj6lPqTSZ581TnVhZVCrvCk5
         rrxtPmPeiXQh8dxdjBMLTVEacqELe4kaymQuh0agQf9OLvIkOvxSDwszzVOMwuHo7cd8
         nJeQ==
X-Gm-Message-State: AOPr4FUki7z2giin6lHCC0LdwRDBIDi6i8iaat0+ryNgGBfrpaxbNxdRUWuAmIIvzUb48o4f6DboL+YImHKygQ==
X-Received: by 10.28.54.33 with SMTP id d33mr6748051wma.62.1462711834974; Sun,
 08 May 2016 05:50:34 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sun, 8 May 2016 05:50:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293966>

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-15.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/152

You can also reply to this email.

I tried to cc everyone who appears in this edition but maybe I missed
some people, sorry about that.

Thomas, Nicola and myself plan to publish this edition on Wednesday
May 11.

Thanks,
Christian.
