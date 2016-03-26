From: =?UTF-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
Subject: Re: [GSoC] Proposal
Date: Sat, 26 Mar 2016 10:26:07 +0800
Message-ID: <CAKqreux=ym0NjKDFa-AMBvGteprxi=9VcMVEGSexK01jkpCGTg@mail.gmail.com>
References: <CAKqreuwbGC1=42V2ZnTj53z76sgGcqfzjjrD7SP2AeuHJo9etQ@mail.gmail.com>
	<CAKqreuwFbObbMf_Lc6Lc01zrdGZf2qCTwgeD+db_CwebS_iDrg@mail.gmail.com>
	<CAFZEwPOm0SvvsH_mzp+G6Me6zKU2GVk6AxMJ7iJOYuEJ7iJV2A@mail.gmail.com>
	<CAKqreuzXezkFdp2zvAL3oF0G5GxLS=MdAeu18BZicBriwbbAKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 03:26:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajdva-0004s9-W7
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 03:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbcCZC0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2016 22:26:10 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34553 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbcCZC0J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Mar 2016 22:26:09 -0400
Received: by mail-ob0-f177.google.com with SMTP id kf9so62318565obc.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 19:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=xtZm4DBiHjtVulPsJDHCP4saWRIZvIERG0C3pkjdMdc=;
        b=Tihf/FxThnvc9t51DcmbwCvMFRSJX8YB0hWeZ5ZHVesFCtawT/QIOeKS1M2+NS4q6o
         85bWX5pSYHE1dynYegpYR8kxznr+A9aA5jtHdRgGjHdxiXyhr37JNaNxQ/SPktp8kMiG
         vrlB5lDkWaa8+/iOMaT4t2Zzk3nfYGVgU8D5ldiDXCyjzTgB7NePoe64EyffTga5SHhD
         N1HaDBwImTgY09vf/QCB2MF8Hi3s32bC+A5/5uN/XEBavhiqX8BMrC8yjn1bwli3uY4t
         Id2GJJT3Bg3hlbR+9DCivIQvD4lmPNLl2plGfgY1IpJZDyUuWc1wIR2FkmFKShZzbVwg
         FKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=xtZm4DBiHjtVulPsJDHCP4saWRIZvIERG0C3pkjdMdc=;
        b=ECtfedMJ7yeZZBtK2gyM1TSc2nUfsToDbmkWikC1VhiL++IkpvtRo83ifWeeLHK2k3
         A3LkOG3IR8zr6E1JVPyzPeg6MOpl7SesIgNJTWOEC/pDLJUosPi9911cSQyGmFL2+xIW
         USWR8HH4Zo0YKtbApEsKntzn3ikLdsSMLPiJA2qw1Rcg7k9se53VXRfmpZH6HadjzZ2D
         lDf10lNZAm97g3cjqmYAAyW7zqYxj3tyroAjpylfQ0+7NUWY/mNQAHC3uzlQxlJZIzhz
         cxN4fwuhnJj/641LbAyQoyrZmPAKrafBCg10UWdc0lyPshf8dk9sAzWaqIxf/M84W8A/
         6ekA==
X-Gm-Message-State: AD7BkJKmVFsQ93E+2ZHmgop+Os4m9U67zVx7iuSUuz2rrAUQBx7XUjQstILGdjqRRr9+8/uC30PTZOIogrHwPw==
X-Received: by 10.182.24.170 with SMTP id v10mr8256556obf.55.1458959167908;
 Fri, 25 Mar 2016 19:26:07 -0700 (PDT)
Received: by 10.157.27.250 with HTTP; Fri, 25 Mar 2016 19:26:07 -0700 (PDT)
In-Reply-To: <CAKqreuzXezkFdp2zvAL3oF0G5GxLS=MdAeu18BZicBriwbbAKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289975>

I had updated the proposal before deadline, if someone is interesting.

2016-03-25 15:12 GMT+08:00 =E6=83=A0=E8=BD=B6=E7=BE=A4 <huiyiqun@gmail.=
com>:
> Well, I should have done some search before ask.
