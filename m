From: Maria Jose Fernandez <mjose.fernandezj@gmail.com>
Subject: Re: problems installing GIT on my MAC OS X 10.11.5
Date: Tue, 14 Jun 2016 17:49:50 +0100
Message-ID: <ADD00034-0B8C-4CBA-87C9-E3F50AA408A2@gmail.com>
References: <1F59C8B7-AF53-4C84-9428-5A4AB80DB295@gmail.com> <20160614190641.0d0ba5344e52304e16ca4f52@domain007.com> <f4c72626-1bd5-0b26-a18a-49feed67a742@web.de> <E9D8E5F7-BBD1-4384-A6D6-B9184AEDE881@gmail.com> <e88e33b0-5443-0517-370e-5b0b76a4df5b@web.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>, git@vger.kernel.org
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 14 18:55:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCrXW-0004kr-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 18:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbcFNQuA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2016 12:50:00 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35133 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727AbcFNQt6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 12:49:58 -0400
Received: by mail-wm0-f51.google.com with SMTP id v199so129692116wmv.0
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i9uORGelPapE2YAaDk4V02O1mSBqyiaRJ44KQlg3lDQ=;
        b=xaW2hsA2KGzYhsvZAt1G6RRMHypJkIqI0C+NXg1YOV6DBkMhdV2yKzfbEIb6s3zm4/
         Wen6ybkmG1xkvxPk41RuMRN+UI/qTW6zV9eZ58ZhZ7NJKkTxjbej+X9Z9m5vOMniCGvC
         DId4vinH/flxEG13KkAGPnneHIwypLu4nC2lY/D4IxRh9qkGtPNS72pWh+sEchnhjd5d
         STnsv4fiMbYf0463SWz7eksrA8Aq8rCiKXB6K3KbREXXdDLJCWHcxjPKMYZCWLFrHhYw
         de8t1BqVvTHvguFr89VpipJiQTgeFgZ61aeGah7AJbWY5njjbBdTrzNy9kadqERKzT85
         r2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i9uORGelPapE2YAaDk4V02O1mSBqyiaRJ44KQlg3lDQ=;
        b=hTC9XlxY6FE9uuqjIbEwinlkmNmlRmh7kFeJc2k+nnohX3XKyPT0BxTIlaypsBlzR1
         i5qwOemZ+SlYe1JHqEq215pKdespaBYYdYaOTNqIaTSwmMTaUeneYLkjCyXnGag8nLx0
         YGgzk3NNe3Y8Du9GNJIbrygA6CDxMizBGW+KUi27aoLNtmTfHsWNxmos/6Zo3rzMQfPo
         cFFyRiUcAUrJ5B3pj2R6Z4Dy7J40r2/ZBThrWIc25xaK9+RSQOT59DcnIaohVgK29XOo
         s2fPb1pRHnpBT+C2QwM1cCZEU8C09iwaqE+gadHXNDRT1RSakhja1Xb6/BQdPz7OeGVc
         am7Q==
X-Gm-Message-State: ALyK8tKvlyjqGol47hTe8qgVzdAhmXspcox4cZvJABa82izE0gAt+A+fmgP6mNFucihMXg==
X-Received: by 10.28.158.17 with SMTP id h17mr7791714wme.1.1465922991663;
        Tue, 14 Jun 2016 09:49:51 -0700 (PDT)
Received: from [192.168.0.8] (cpc75192-slam8-2-0-cust379.2-4.cable.virginm.net. [82.28.141.124])
        by smtp.gmail.com with ESMTPSA id u71sm5008549wmu.13.2016.06.14.09.49.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Jun 2016 09:49:51 -0700 (PDT)
In-Reply-To: <e88e33b0-5443-0517-370e-5b0b76a4df5b@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297305>

I am very sorry but I am not understanding what you are saying.=20
I will try with homebrew and see if it works that way.

> On 14 Jun 2016, at 17:48, Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>=20
> On 14.06.16 18:45, Maria Jose Fernandez wrote:
>> From http://git-scm.com/download/mac I clicked to download manually.
>> Then it goes to https://sourceforge.net/projects/git-osx-installer/f=
iles/git-2.8.1-intel-universal-mavericks.dmg/download?use_mirror=3Dauto=
select
>> I found the git - 2.8.1-intel-universal-mavericks.dmg <https://sourc=
eforge.net/projects/git-osx-installer/files/git-2.8.1-intel-universal-m=
avericks.dmg/download?use_mirror=3Dautoselect> downloaded on my desktop=
=2E I open that and go through the installation process and then it say=
s is installed but not found anywhere on my computer.=20
>>=20
>>=20
> It says ?
>=20
> Do you think that you open a terminal and type
> which git
> git --version
> and post the output here ?
>=20
>=20
