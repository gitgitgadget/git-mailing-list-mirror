From: Stefan Beller <sbeller@google.com>
Subject: Re: git on vagrant shared folder
Date: Tue, 14 Jul 2015 11:53:52 -0700
Message-ID: <CAGZ79kbBKzbjbg5u7A7BgnV1JF=5A+-gb0OdYs11g6kx_UQu_A@mail.gmail.com>
References: <7C05ACF4-6536-4E60-BC92-FF7F0E266C0D@e-confirm.de>
	<20150714183215.GG7613@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Peter_H=C3=BCfner?= <p.huefner@e-confirm.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 20:53:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF5L3-0006l6-U1
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 20:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbbGNSxx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 14:53:53 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:32889 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbbGNSxx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2015 14:53:53 -0400
Received: by ykeo3 with SMTP id o3so16322872yke.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lEx0uuZAopxWiwho89KSvv/HUxgZ4Eg8VXHMcebd7YE=;
        b=X+9u8DB0pKEf5ARGN3sNbGSqZWs3RA6wAE9Z/JGA4Ex5Js2rjIKu17u+zgJyjC1J8d
         IR0jtp0ZGm7KwepqjNvUNVkpTlJg6XOR2I+3FSpsZQkv6ASfjLQnaEuJ+AvgyRcCYob5
         UdBOuyyhvDEehEd2LV0Atsktbs1MLM7U4CzlNVet+luK8UDlXGTHOWtnFCuSq3RBCELB
         YaFxbhRlRI4YHffOdOyPe2DBC07LVrCYuSidz+MtuSlTEKg3fbrUwNhL7GW/Rs/1f6Tf
         iVPJ4xduykiYX7wL5RNKmdDl5DWGb+INLCAz5RUNxjgSYv/VWyP5mdezNx8cx+Jk/6gg
         E8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lEx0uuZAopxWiwho89KSvv/HUxgZ4Eg8VXHMcebd7YE=;
        b=XyTOee/iAUlh2O4aj3NsZwktN2TN21OuRJRFdxh3L4wMvWY97yJIrU82HF8e56/B8O
         re5RhSUUckEYmu9vveYmAqWMMppWNfKWpNT9Woo2mBTTvPQ6nROlQ0d/Kuh3q1EgTOy/
         4vTb8YbXjx03P6fBw3L+R+ZREIu7ZDmtR9pva7cQIUAzARUx01JaA/ew6c3xXuI9WfcE
         caseCos9qnIxpDYw/AuJ88gLweHRflt5RVEfNUP0cnXauAnHVKt2tbtNdTQL9D+DkcYZ
         VLD8zOx6NPCmXOnj7Hu6fqxTE93Bk6xvuhfCFl9FzbmPoKiXJxJ8RJjtlkMerRAG6pE+
         h0+A==
X-Gm-Message-State: ALoCoQmOQjYYk3fEgJQrw4beMXfPxWzYCkubxuHlT4NPUJMdrA7kbmtbt06n5TTlaqtOdnagPd+/
X-Received: by 10.170.82.131 with SMTP id y125mr23561yky.115.1436900032563;
 Tue, 14 Jul 2015 11:53:52 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Tue, 14 Jul 2015 11:53:52 -0700 (PDT)
In-Reply-To: <20150714183215.GG7613@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273972>

>
>> A few weeks ago we weren=E2=80=99t able to clone and get an error: c=
ould not commit /vagrant/.git/config file. Manually we were able to cha=
nge that file and also the clone command works outside the shared folde=
r.
>
> Why are you trying to commit a file inside the .git dir? Files in tha=
t
> dir should not be commited (and I'm pretty sure there was a patch abo=
ut
> this a while ago). The .git/config file for example is local to each =
git
> repo and should not be commited.

Actually it is considered a security risk, see
http://article.gmane.org/gmane.linux.kernel/1853266
