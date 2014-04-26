From: Marius Ungureanu <marius.ungureanu@xamarin.com>
Subject: Re: [PATCH] Updated C# userdiff patterns.
Date: Sat, 26 Apr 2014 21:52:17 +0300
Message-ID: <E0FA908C-1D48-401C-8865-EA9AD8B0531E@xamarin.com>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org> <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com> <535BF1C0.7080204@kdbg.org> <1EA6F663-54DC-4665-A88C-8627F38B356E@xamarin.com> <535BFFEB.8040103@kdbg.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 15:37:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WePGq-0002jU-G9
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 15:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbaD0Ngw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Apr 2014 09:36:52 -0400
Received: from mail-ee0-f45.google.com ([74.125.83.45]:61874 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbaD0NgT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2014 09:36:19 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so3997802eek.18
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 06:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xamarin.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=mU/1kgA5sT51ciLOVq5ew46yfxPmK5YJ4MDGo+HeYro=;
        b=hK4Mk6iWxlaFDh/3LX/BwT3qEdCrX8tRwBpwy1upX1I31RUAfFfgVGPPsbxzzgBHVE
         fXCzDAluqaoIXgR855WRgKBQdwzu0HqA0yDn55wfKWACC2CLtc9lp7nsuI3IV12zjWs1
         7JTcBGMssACOyVzDOkX9PpJIGhXJMTx+QOIZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=mU/1kgA5sT51ciLOVq5ew46yfxPmK5YJ4MDGo+HeYro=;
        b=a0za+zn6rLIyDVd5RALErhHtbpaSlba0F7LV5ZeXHEc3jew+d9dExh+MVF/gcWsU6d
         PTF79/H2bFlXFHgs+z1fWsRa/YKKorvGSTlVSbEui5Beuh7FhGVqFtf4DSoCi1c+R2gy
         tHhXdPwCuksGe3xdc0hQ2WUKxL/ZYFiFPAojJBsIemre2lI9BJKEaaz6aziCMObrgts/
         2/oJ2X9MWTKpzIhThegk9m5q+QH2EfTHIKUJGufTTvgzQh/4w7e7Lgt+DrLjgTWLauLm
         9J9B+kNdL0tMnStfNxxwN8NUi6aXoxM5ORwGLRugQ1VFM5V22s4tHigfVJ+rE6R8//OJ
         RHJg==
X-Gm-Message-State: ALoCoQnuRKcEYcmPqoV1hC6EYVczpJjPSbXfMAM1BoIWNeUCeOQcP/p49tIp+VpgJwSTCV3nFHb6
X-Received: by 10.14.246.1 with SMTP id p1mr25388122eer.20.1398605777667;
        Sun, 27 Apr 2014 06:36:17 -0700 (PDT)
Received: from [192.168.1.101] ([188.26.30.123])
        by mx.google.com with ESMTPSA id e42sm41759353eev.32.2014.04.27.06.36.16
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 06:36:16 -0700 (PDT)
In-Reply-To: <535BFFEB.8040103@kdbg.org>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247199>


On 26 Apr 2014, at 21:50, Johannes Sixt <j6t@kdbg.org> wrote:

> Am 26.04.2014 20:33, schrieb Marius Ungureanu:
>> ... add as many unit tests I can.
>=20
> Great! Keep in mind that quantity is secondary. Quality counts.

Obviously. By =91as many=92, I meant to cover all the cases here.

>> I=92ll start a new thread with the new
>> patch as soon as I=92m done with it.
>=20
> If possible, do not start a new thread, but post your new patch as a
> reply in this thread.
>=20

Okay, understood.

> Thanks,
> -- Hannes
>=20

Thanks,
Marius
