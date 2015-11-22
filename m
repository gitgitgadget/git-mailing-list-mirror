From: Dair Grant <dair@feralinteractive.com>
Subject: Re: [RFC] OS X El Capitan + Xcode ships without SSL header?!
Date: Sun, 22 Nov 2015 13:12:24 +0000
Message-ID: <86841415-A635-4656-9EF5-02F543257FF4@feralinteractive.com>
References: <BBD3F9B1-9FCA-4207-B374-3ADCF19F1431@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 22 14:13:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0URx-0008HC-D7
	for gcvg-git-2@plane.gmane.org; Sun, 22 Nov 2015 14:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbbKVNM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2015 08:12:28 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38744 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbbKVNM1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Nov 2015 08:12:27 -0500
Received: by wmec201 with SMTP id c201so73774070wme.1
        for <git@vger.kernel.org>; Sun, 22 Nov 2015 05:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=feralinteractive-com.20150623.gappssmtp.com; s=20150623;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=ZiHS+xBLiJvjN2ED2wAki1P2GD4aphdBzjrRpEPuwN8=;
        b=N62fP/SVUELS3lWVctN7EGxcVkMxSUpUHdvF1Dsaajj6fQQPrQnWGLPFfmW6MAPEiT
         +CbPtpqhPHLbGUivKkN5EaCpDxuRQJEnETf1kjtdLOQ9prxkRxweowCAxHz9WmuQw6wh
         Nu7c7vymJA7hLG5l51RRMgB5Rgm/G5Kxz6I64grEvz2/S5NukS8pyeYV9WEfwh50VpUE
         8/QIM8njoSc8T5jYjfsiB7eny+cB3er1QxGDOsabE43BzyvpFxlommcchXs0J8QUNTRn
         d3T7vngdLXOqj+Moif62267sMY0ejiuX929yeJUucZdf2N0VncuYsCqUJ9gbWFVk5jMH
         +Myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:content-transfer-encoding:message-id:references:to;
        bh=ZiHS+xBLiJvjN2ED2wAki1P2GD4aphdBzjrRpEPuwN8=;
        b=AyYOOEeUJPzwczmhNZnlHhFl7pDmdGPdSEJHoSiXvgbtAu49TC1nKfD7rpUHDcwMIf
         wuA3/RZKH4XqncjovFCxng0494K96yercBtTScx/dww7Nu2H55225nPNHiIV5CSflbHU
         r15LUao9rURNgd+ZLUX3Z5o6kiT4FLxwKrFn76wb0MKgCJPWfiDHomwKvYPnEss7rVfy
         mwPl15dAuO6rjOR7yWmA03x/yn3tgcSfMP1Js6HU5R0JKoQeXwKwuB1uNRzqC+w/V+kH
         9vnBAUCZwhXl0CBZ9dxpgoDh9PedsmO1i3pKMv4BajYWitTyKPePfOB5LO+RwILJSHjS
         CWvw==
X-Gm-Message-State: ALoCoQkcspdQRr7qbN813Iwd9UmEp4mq2SsYmifsry/32MyC7Dio/59pAVWnDAp6gwRZUgq5tCei
X-Received: by 10.194.57.178 with SMTP id j18mr29603890wjq.113.1448197945625;
        Sun, 22 Nov 2015 05:12:25 -0800 (PST)
Received: from [10.0.1.2] (host86-176-161-241.range86-176.btcentralplus.com. [86.176.161.241])
        by smtp.gmail.com with ESMTPSA id t133sm8438715wmf.24.2015.11.22.05.12.24
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Nov 2015 05:12:25 -0800 (PST)
In-Reply-To: <BBD3F9B1-9FCA-4207-B374-3ADCF19F1431@gmail.com>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281564>


> On 21 Nov 2015, at 18:58, Lars Schneider <larsxschneider@gmail.com> w=
rote:
>=20
> I installed OpenSSL with brew, added the include path and it works.
>=20
> Can anyone confirm?

That is correct. Xcode=E2=80=99s copy of OpenSSL has been deprecated si=
nce 10.7 and was removed for 10.11 in Xcode 7:

   https://lists.apple.com/archives/macnetworkprog/2015/Jun/msg00025.ht=
ml


-dair