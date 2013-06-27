From: =?ISO-8859-1?Q?Jean-No=EBl_Avila?= <avila.jn@gmail.com>
Subject: Re: Off-line deverloper workflow?
Date: Thu, 27 Jun 2013 15:43:51 +0200
Message-ID: <51CC4197.3000007@gmail.com>
References: <20130627124656.GA2620@zuhnb712>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Woody Wu <narkewoody@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 15:44:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsCUR-0003GT-AA
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 15:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868Ab3F0Nnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 09:43:55 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39808 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753Ab3F0Nny (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 09:43:54 -0400
Received: by mail-ee0-f46.google.com with SMTP id d41so408751eek.5
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oPdcycT7WzY+MOQnfh30uQI4cczPt/YCkXIbXFXXvP8=;
        b=SVroIh3RAk9Wh7CJhy8xX0TeKbwqix8nU4rKKPFHQhp2WgxdRc/IuElyTjKA8lxDvL
         V4hTG9Ecdz8cmJlZC6HY86UV42/egyoBDZ4nIR6mA+9p3U0syf0E87JKh+bPp/FOMXW5
         5elQqPAJ9ZbUHoFh8AHk7gZTefHxqB+ABxEAcIssg9ZXCH/tJ2tAphEsry/Z2PGaZlZ/
         b7umjAM2iTqbquGM2tu2SepIUywY7rEqwPkjOCXoOrWZ9vB9SHvOv12HvyJG4lgv+yBZ
         p6uWniKd3D8yN3aw0UN5Oiuk6pPO4b5E1dcx5LL4ORrFquHHe8Pgfhy/bbb9GyVBU8qL
         nwBA==
X-Received: by 10.14.202.70 with SMTP id c46mr9240862eeo.28.1372340633716;
        Thu, 27 Jun 2013 06:43:53 -0700 (PDT)
Received: from [192.168.1.54] ([178.21.183.81])
        by mx.google.com with ESMTPSA id b3sm3926299eev.10.2013.06.27.06.43.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 06:43:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130627124656.GA2620@zuhnb712>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229104>

Le 27/06/2013 14:46, Woody Wu a =E9crit :
> Hi,
>
> I have a colleague who has to left our office for three month, but st=
ill
> need to work on the project which is hosted on our in-office git
> repository. Problem is that our company has firewall, it's not possib=
le
> or not allowed to access the company LAN outside the building.  So I
> want to ask you expert, can you suggest a best practice of git workfl=
ow
> that suitable to my situation?
>
> Thanks in advance.
>
> -woody
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

=46or a short time, I had the same issue. We came up using "git bundle"=
 to=20
bundle changes and exchange them via email.

The setup was to work in two separate branches. The roaming developper=20
started a new branch when leaving. After some work, she sent the commit=
s=20
on her branch as a bundle file. The origin merged the branch extracted=20
from the developper's bundle and sent back the bundle of the changes on=
=20
origin since the last merge.

No doubt that both side need to understand well the workflow of=20
fetch/merge. Bundle files can be encrypted for better security.

Hope this helps.

JN
