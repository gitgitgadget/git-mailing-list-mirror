From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/7] git-p4: add optional type specifier to gitConfig reader
Date: Tue, 22 Sep 2015 14:49:07 -0700
Message-ID: <xmqqd1xa15ws.fsf@gitster.mtv.corp.google.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
	<1442875273-48610-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 22 23:49:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeVRF-0006EY-8G
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 23:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbbIVVtV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2015 17:49:21 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36179 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbbIVVtU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 17:49:20 -0400
Received: by pacbt3 with SMTP id bt3so2059052pac.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=P/HYXmXc5cYTuVEPxW3Mqw2yQwFFxeSSviqKFIkBUOw=;
        b=XrK2NBd50tQZeGDmQ/VNsCTsPX/0RXQre/xj5N+f0bgiRewtCFvRI1A+i8u9BESWK5
         jijVIqCcT3MSVvwhVF2c/ySavnhNVFTBWR6c+HZAtilJd32T4WDvcAXK2+DwEMsGkvJM
         uUdAqUOLenifd6DX6mB6eGnHpA1fWcvJjUC78Mh/wmMPwYro0P7q6vLPGWdz+87GiO2O
         NPdgrBiPUgdLlq7jsIhh30ivmBHttXc7yQghLkwbLQ/VAgpW9LeMRdOEADQunMkNgBDH
         zcKJgMDnBR5fggxww3QKn9kek5jxA+N4nkdz3U4X8ovtAqRchW8Z4mVsnsGRUszosI/5
         /MIQ==
X-Received: by 10.66.147.74 with SMTP id ti10mr4412585pab.88.1442958549632;
        Tue, 22 Sep 2015 14:49:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id eh4sm4088168pbd.27.2015.09.22.14.49.07
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 14:49:07 -0700 (PDT)
In-Reply-To: <1442875273-48610-2-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Tue, 22 Sep 2015 00:41:07
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278442>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> The functions =E2=80=9CgitConfig=E2=80=9D and =E2=80=9CgitConfigBool=E2=
=80=9D are almost identical. Make =E2=80=9CgitConfig=E2=80=9D more gene=
ric by adding an optional type specifier. Use the type specifier =E2=80=
=9C=E2=80=94bool=E2=80=9D with =E2=80=9CgitConfig=E2=80=9D to implement=
 =E2=80=9CgitConfigBool. This prepares the implementation of other type=
 specifiers such as =E2=80=9C=E2=80=94int=E2=80=9D.

What is this overlong single line paragraph?  Is this a MUA artifact
on my end?
