From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v10 00/20] index-helper/watchman
Date: Sat, 14 May 2016 15:14:59 +0200
Message-ID: <1463231699.1993.1.camel@kaarsemaker.net>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat May 14 15:15:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1ZPX-0001Wj-LC
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 15:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbcENNPF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2016 09:15:05 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35985 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbcENNPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 09:15:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id w143so8822231wmw.3
        for <git@vger.kernel.org>; Sat, 14 May 2016 06:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IKfZ79UgG9kEM6JEvhN/nng2oqmt/ciT6YLvYXLJfg8=;
        b=ZmIvJRsXel9d2Hk1z1gV7bxxGAOKX4fKqtU9IZRG0od7eoDK0Ul68giETTht4b/4Cc
         /MqeHWsRniw+6gO9PEmH3Xn0zsTnnnWrZbkwS0XstvdeLRWF84bTn0dFnTCTRWiL/sUy
         9FYIdKhGINxRTRooNjBV66ohhfIZ2lyQCA6iqWHuzxZaDZYsWeaNPCK25YUBFX+BRWnB
         AkJl0XxGlm/ezkBthLNRulaa6tJWTwCOiLGg9hoieXfeyfxVoSjgNKOagNhr5BzwG6zc
         cjSu19FGRQd6i1Hfn/MRYH3xAB6icTjF5cKz3tLL9FsjUdoWI9WccvQskXRLL/xyEqDy
         mJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IKfZ79UgG9kEM6JEvhN/nng2oqmt/ciT6YLvYXLJfg8=;
        b=VUXyBxk68DCZcPT38yumFWtmli1JoDZ6irFa4dDA/tbrayDtXnN86kf+XYHWt2PbRe
         MxykNtMCMOOOgmUCKJ9SwiEXBE9NLqlnymgbPT+996qLjEXnmLuQdOELLh1RtrA8lHjJ
         2B+RkNGq2R+hI12Eok4yiiWf+e5IbRwU5S/RjO1kkLw+9DvicDqX2ZaUNLmxqgA3G9Rh
         XqEMjy7m6uQbXuU1VwkGLGOs6q9pPHXAHUXxjF+Q1syTC4OjCweH+IP7LQmQHrMXlsuB
         ah7lWPoBsf6hvWawGFirtxgsFUvu1LbSaJhSc7dya7cSxKwgF0WhZZCnAAKBO9wWCLBK
         xjSg==
X-Gm-Message-State: AOPr4FU2tDbs/PdfRSpwNrV5jSlGEgxc9aFoOBiFg28Ygo34yUP0+de8bIGpRtuVCAI5OQ==
X-Received: by 10.28.214.137 with SMTP id n131mr8445628wmg.20.1463231701990;
        Sat, 14 May 2016 06:15:01 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id ib1sm23598224wjb.48.2016.05.14.06.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 May 2016 06:15:00 -0700 (PDT)
In-Reply-To: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294611>

On do, 2016-05-12 at 16:19 -0400, David Turner wrote:

> This version fixes that.=C2=A0 I didn't test on a virtual machine, bu=
t I
> did test by adding a sleep().

I can confirm that on my single-cpu test VM, this no longer triggers
errors.

D.
